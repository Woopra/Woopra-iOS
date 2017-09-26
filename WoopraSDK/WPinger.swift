//
//  WNPinger.swift
//  WoopraSDK
//
//  Created by Woopra on 15.09.17.
//  Copyright © 2017 Woopra. All rights reserved.
//

import UIKit

class WPinger: NSObject {
    
    var tracker: WTracker? = nil
    private var pingTimer: Timer?
    private var observerContext = 0
    private var pingInterval = 50.0
    private let WPingEndpoint = "https://www.woopra.com/track/ping/"
    
    init(tracker: WTracker) {
        super.init()
        self.tracker = tracker
        
        for p in monitoredTrackerProperties() {
            tracker.addObserver(self, forKeyPath: p, options: NSKeyValueObservingOptions.new, context: &observerContext)
        }
        
        startStopPingTimerAccordingToTrackerState()
    }
    
    deinit {
        for p in monitoredTrackerProperties() {
            tracker?.removeObserver(self, forKeyPath: p, context: &observerContext)
        }
    }
    
    override public func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let tracker = self.tracker, let keyPath = keyPath {
            if tracker.isEqual(object) && self.monitoredTrackerProperties().contains(keyPath) {
                self.startStopPingTimerAccordingToTrackerState()
            } else {
                super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
            }
        }
    }
    
    private func startStopPingTimerAccordingToTrackerState() {
        pingTimer?.invalidate()
        pingTimer = nil
        
        if let tracker = self.tracker, let domain = tracker.domain {
            if (domain.characters.count > 0 &&
                tracker.visitor != nil &&
                tracker.pingEnabled) {
                pingInterval = tracker.idleTimeout - 10.0
                pingTimer = Timer.scheduledTimer(timeInterval: pingInterval, target: self, selector: #selector(WPinger.pingTimerDidFire(timer:)), userInfo: nil, repeats: true)
                self.pingTimerDidFire(timer: pingTimer!)
            }
        }
    }
    
    func pingTimerDidFire(timer: Timer) {
        
        if let tracker = self.tracker, let domain = tracker.domain, let visitor = tracker.visitor {
            let parameters = "?host=" + domain + "&response=xml&cookie=\(visitor.cookie)&meta=VGhpcyBpcyBhIHRlc3Q&timeout=\(Int(tracker.idleTimeout * 1000))"
            
            if  let url = URL(string: WPingEndpoint.appending(parameters)) {
                let pingRequest = URLRequest(url: url)
                let session = URLSession.shared
                let task = session.dataTask(with: pingRequest, completionHandler: { (data, response, error) in
                    
                    guard error == nil else {
                        print("error")
                        print(error!)
                        return
                    }
                    
                    guard let responseData = data else {
                        print("Error: did not receive data")
                        return
                    }
                    
                    print("\(Date()) " + responseData.debugDescription)
                    print(parameters)
                })
                task.resume()
            }
        }
    }

    private func monitoredTrackerProperties() -> [String] {
        return ["pingEnabled", "idleTimeout", "visitor", "domain"]
    }
}
