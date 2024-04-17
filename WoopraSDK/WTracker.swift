//
//  WTracker.swift
//  WoopraSDK
//
//  Created by Woopra on 15.09.17.
//  Copyright © 2017 Woopra. All rights reserved.
//

public class WTracker: WPropertiesContainer {
    
    // MARK: - Public properties
    // Identifies which project environment your sending this tracking request to. E.g. http://yourproject.com
    @objc dynamic public var domain: String?
    @objc dynamic public var visitor: WVisitor!
    
    // In seconds, defaults to 60, after which the event will expire and the visitor will considered offline.
    // when idleTimeout changes – pingInterval = idleTimeout - 10.0 (but minimum is 30.0 for both)
    @objc dynamic public var idleTimeout: TimeInterval {
        get { return _idleTimeout }
        set(aNewValue) {
            if aNewValue < WTracker.defaultIdleTimeout {
                _idleTimeout = WTracker.defaultIdleTimeout
            } else {
                _idleTimeout = aNewValue
            }
        }
    }

    private static let defaultIdleTimeout: TimeInterval = 60.0
    private var _idleTimeout: TimeInterval = defaultIdleTimeout
   
    // ping requests can be periodically sent to Woopra servers to refresh the visitor timeout counter. This is used if it’s important to keep a visitor status ‘online’ when he’s inactive for a long time (for cases such as watching a long video).
    @objc dynamic public var pingEnabled = false
    
    // visit’s referring URL, Woopra servers will match the URL against a database of referrers and will generate a referrer type and search terms when applicable. The referrers data will be automatically accessible from the Woopra clients.
    public var referer: String?
    
    // MARK: - Private properties
    private let wEventEndpoint = "https://www.woopra.com/track/ce/"
    private var wPinger: WPinger?
    
    // MARK: - Shared instance
    public static let shared: WTracker = {
        let instance = WTracker()
        
        // initialize system needed properties
        instance.add(property: "device", value: UIDevice.current.model)
        instance.add(property: "os", value: "\(UIDevice.current.systemName) \(UIDevice.current.systemVersion)")
        let bundleName = Bundle.main.object(forInfoDictionaryKey: kCFBundleNameKey as String)
        instance.add(property: "browser", value: bundleName as! String)
        
        instance.wPinger = WPinger(tracker: instance)
        // create dummy visitor object to track 'anonymous' events
        instance.visitor = WVisitor.anonymousVisitor()
        
        return instance
    }()

    // MARK: - Methods
    public func trackEvent(_ event: WEvent) {
        // check parameters
        guard let domain = domain else {
            #if DEBUG
            print("WTracker.domain property must be set before WTracker.trackEvent: invocation. Ex.: tracker.domain = mywebsite.com")
            #endif
            return
        }

        guard let visitor = visitor else {
            #if DEBUG
            print("WTracker.visitor property must be set before WTracker.trackEvent: invocation")
            #endif
            return
        }
        
        guard let url = URL(string: wEventEndpoint) else {
             print("Invalid URL")
             return
         }
        
        var queryItems: [NSURLQueryItem] = [
            NSURLQueryItem(name: "app", value: "ios"),
            NSURLQueryItem(name: "host", value: domain),
            NSURLQueryItem(name: "cookie", value: visitor.cookie),
            NSURLQueryItem(name: "response", value: "xml"),
            NSURLQueryItem(name: "timeout", value: Int(idleTimeout * 1000).description)
        ]
        
        if let referer = referer {
            queryItems.append(NSURLQueryItem(name: "referer", value: referer))
        }
        
        // Add system properties e.g. device, os, browser
        for (key, value) in properties {
            queryItems.append(NSURLQueryItem(name: "\(key)", value: value))
        }
        
        // Add visitors properties
        let visitorProperties = visitor.properties
        for (key, value) in visitorProperties {
            queryItems.append(NSURLQueryItem(name: "cv_\(key)", value: value));
        }
        
        // Add Event Properties
        for (key, value) in event.properties {
            if key.hasPrefix("~") {
                // Parsing of required system event properties. For example ~event – custom event type. e.g. event=purchase, event=signup etc…
                let index = key.index(key.startIndex, offsetBy: 1)
                queryItems.append(NSURLQueryItem(name: String(key[index...]), value: value))
            } else {
                // Parsing of optional event properties
                queryItems.append(NSURLQueryItem(name: "ce_\(key)", value: value))
            }
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Convert queryItems to a dictionary
        let parameters = queryItems.reduce(into: [String: String]()) { result, item in
            result[item.name] = item.value
        }
        if let jsonString = try? JSONSerialization.data(withJSONObject: parameters, options: []) {
            request.httpBody = jsonString
            #if DEBUG
            // Print the request body
            if let requestBody = String(data: jsonString, encoding: .utf8) {
                print("Request Body: \(requestBody)")
            } else {
                print("Failed to convert request body to string")
            }
            #endif
        } else {
            print("Failed to serialize parameters to JSON")
            return
        }
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard data != nil else {
                print("Error: No response data")
                return
            }
            
            #if DEBUG
            if let httpResponse = response as? HTTPURLResponse {
                print("Response: \(httpResponse.statusCode)")
            }
            #endif
        })
        task.resume()
    }
    
    public func trackEvent(named: String) {
        self.trackEvent(WEvent(name: named))
    }
}
