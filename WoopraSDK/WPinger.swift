//
//  WNPinger.swift
//  WoopraSDK
//
//  Created by Woopra on 15.09.17.
//  Copyright © 2017 Woopra. All rights reserved.
//

class WPinger: NSObject {
    
    let tracker: WTracker
    private var pingTimer: Timer?
    private var observerContext = 0
    private var pingInterval = 50.0
    private let pingEndpoint = "https://www.woopra.com/track/ping/"
    
    init(tracker: WTracker) {
        self.tracker = tracker
        super.init()

        for p in monitoredTrackerProperties() {
            tracker.addObserver(self, forKeyPath: p, options: NSKeyValueObservingOptions.new, context: &observerContext)
        }
        
        startStopPingTimerAccordingToTrackerState()
    }
    
    deinit {
        for p in monitoredTrackerProperties() {
            tracker.removeObserver(self, forKeyPath: p, context: &observerContext)
        }
    }
    
    override public func observeValue(forKeyPath keyPath: String?,
                                      of object: Any?,
                                      change: [NSKeyValueChangeKey : Any]?,
                                      context: UnsafeMutableRawPointer?) {
        guard let keyPath = keyPath else {
          return
        }
        if tracker.isEqual(object) && monitoredTrackerProperties().contains(keyPath) {
            startStopPingTimerAccordingToTrackerState()
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    
    private func startStopPingTimerAccordingToTrackerState() {
        pingTimer?.invalidate()
        pingTimer = nil
        
        if let domain = tracker.domain,
            !domain.isEmpty,
            tracker.visitor != nil,
            tracker.pingEnabled {

            pingInterval = tracker.idleTimeout - 10.0
            pingTimer = Timer.scheduledTimer(timeInterval: pingInterval,
                                             target: self,
                                             selector: #selector(WPinger.pingTimerDidFire(timer:)),
                                             userInfo: nil,
                                             repeats: true)
            pingTimerDidFire(timer: pingTimer!)
        }
    }
    
    @objc func pingTimerDidFire(timer: Timer) {
        
        if let domain = tracker.domain, let visitor = tracker.visitor {
            let parameters = "?host=\(domain)&response=xml&cookie=\(visitor.cookie)&meta=VGhpcyBpcyBhIHRlc3Q&timeout=\(Int(tracker.idleTimeout * 1000))"
            
            if let url = URL(string: pingEndpoint.appending(parameters)) {
                let pingRequest = URLRequest(url: url)
                let task = URLSession.shared.dataTask(with: pingRequest, completionHandler: { (data, response, error) in
                    #if DEBUG
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
                    #endif
                })
                task.resume()
            }
        }
    }

    private func monitoredTrackerProperties() -> [String] {
        return ["pingEnabled", "idleTimeout", "visitor", "domain"]
    }
}
