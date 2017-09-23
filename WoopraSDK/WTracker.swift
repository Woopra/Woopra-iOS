//
//  WTracker.swift
//  WoopraSDK
//
//  Created by Woopra on 15.09.17.
//  Copyright © 2017 Woopra. All rights reserved.
//

import UIKit

public class WTracker: WPropertiesContainer {
    
    // MARK: - Public properties
    // Identifies which project environment your sending this tracking request to.
    dynamic public var domain: String?
    dynamic public var visitor: WVisitor!
    
    // In seconds, defaults to 30, after which the event will expire and the visitor will considered offline.
    dynamic public var idleTimeout: TimeInterval {
        get { return _idleTimeout }
        set(aNewValue) {
            if aNewValue > 60.0 {
                _idleTimeout = aNewValue - 5.0
            } else {
                _idleTimeout = aNewValue
            }
        }
    }

    private var _idleTimeout: TimeInterval = 30.0
   
    // ping requests can be periodically sent to Woopra servers to refresh the visitor timeout counter. This is used if it’s important to keep a visitor status ‘online’ when he’s inactive for a long time (for cases such as watching a long video).
    dynamic public var pingEnabled = false
    
    // visit’s referring URL, Woopra servers will match the URL against a database of referrers and will generate a referrer type and search terms when applicable. The referrers data will be automatically accessible from the Woopra clients.
    public var referer: String?
    
    // MARK: - Private properties
    private let WEventEndpoint = "https://www.woopra.com/track/ce/"
    private var gPinger: WPinger? = nil
    
    // MARK: - Shared instance
    public static let shared: WTracker = {
        let instance = WTracker()
        
        // default timeout value for Woopra service
        instance.idleTimeout = 30.0
        
        // initialize system needed properties
        instance.add(property: "device", value: UIDevice.current.model)
        instance.add(property: "os", value: "\(UIDevice.current.systemName) \(UIDevice.current.systemVersion)")
        let bundleName = (Bundle.main.object(forInfoDictionaryKey: kCFBundleNameKey as String))
        instance.add(property: "browser", value: bundleName as! String)
        
        instance.gPinger = WPinger(tracker: instance)
        // create dummy visitor object to track 'anonymous' events
        instance.visitor = WVisitor.anonymousVisitor()
        
        return instance
    }()
    
    private override init() {
        super.init()
    }
    
    // MARK: - Methods
    public func trackEvent(_ event: WEvent) {
        // check parameters
        if (self.domain == nil)
        {
            print("WTracker.domain property must be set before WTracker.trackEvent: invocation. Ex.: tracker.domain = mywebsite.com");
        }
        
        if (self.visitor == nil)
        {
            print("WTracker.visitor property must be set before WTracker.trackEvent: invocation");
        }
        
        let url = URL(string: WEventEndpoint)
        let components = NSURLComponents(url: url!, resolvingAgainstBaseURL: true)
        var queryItems: [NSURLQueryItem] = [
            NSURLQueryItem(name: "app", value: "ios"),
            NSURLQueryItem(name: "host", value: self.domain),
            NSURLQueryItem(name: "cookie", value: self.visitor!.cookie),
            NSURLQueryItem(name: "response", value: "xml"),
            NSURLQueryItem(name: "timeout", value: Int(self.idleTimeout * 1000).description)
        ]
        
        if (self.referer != nil) {
            queryItems.append(NSURLQueryItem(name: "referer", value: self.referer))
        }
        
        // Add system properties e.g. device, os, browser
        for (key, value) in self.properties {
            queryItems.append(NSURLQueryItem(name: "\(key)", value: value))
        }
        
        // Add visitors properties
        let visitorProperties = self.visitor!.properties
        for (key, value) in visitorProperties {
            queryItems.append(NSURLQueryItem(name: "cv_\(key)", value: value));
        }
        
        // Add Event Properties
        let eventProperties = event.properties
        for (key, value) in eventProperties {
            if key.hasPrefix("~") {
                // Parsing of required system event properties. For example ~event – custom event type. e.g. event=purchase, event=signup etc…
                let index = key.index(key.startIndex, offsetBy: 1)
                queryItems.append(NSURLQueryItem(name: key.substring(from: index), value: value))
            } else {
                // Parsing of optional event properties
                queryItems.append(NSURLQueryItem(name: "ce_\(key)", value: value))
            }
        }
        
        components?.queryItems = queryItems as [URLQueryItem]
        let requestUrl = components?.url
        
        if let url = requestUrl {
            let request = URLRequest(url: url)
            let session = URLSession.shared
            let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
                
                // check for errors
                guard error == nil else {
                    print("error")
                    print(error!)
                    return
                }
                
                guard let responseData = data else {
                    print("Error: did not receive data")
                    return
                }
                
                print(responseData.debugDescription)
            })
            task.resume()
        }
    }
    
    public func trackEvent(named: String) {
        self.trackEvent(WEvent(name: named))
    }
}
