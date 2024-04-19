//
//  WTracker.swift
//  WoopraSDK
//
//  Created by Woopra on 15.09.17.
//  Copyright © 2017 Woopra. All rights reserved.
//

@objcMembers
public class WTracker: WPropertiesContainer {
    
    // MARK: - Public properties
    // Identifies which project environment your sending this tracking request to. E.g. http://yourproject.com
    @objc dynamic public var domain: String?
    @objc dynamic public var visitor: WVisitor = WVisitor.anonymousVisitor()
    
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
    
    // visit’s referring URL, Woopra servers will match the URL against a database of referrers and will generate a referrer type and search terms when applicable. The referrers data will be automatically accessible from the Woopra clients.
    public var referer: String?
    
    // MARK: - Private properties
    private let wEventEndpoint = "https://www.woopra.com/track/ce/"
    
    // MARK: - Shared instance
    public static let shared: WTracker = {
        let instance = WTracker()
        
        // initialize system needed properties
        instance.add(property: "device", value: UIDevice.current.model)
        instance.add(property: "os", value: "\(UIDevice.current.systemName) \(UIDevice.current.systemVersion)")
        if case let key = kCFBundleNameKey as String,
           let bundleName = Bundle.main.object(forInfoDictionaryKey: key) as? String {
            instance.add(property: "browser", value: bundleName)
        }
        
        // create dummy visitor object to track 'anonymous' events
        instance.visitor = WVisitor.anonymousVisitor()
        
        return instance
    }()
    
    internal override init() {
        super.init()
    }
    
    // MARK: - Methods
    public func trackEvent(_ event: WEvent) {
        // check parameters
        guard let domain = domain else {
            #if DEBUG
            print("WTracker.domain property must be set before WTracker.trackEvent: invocation. Ex.: tracker.domain = mywebsite.com")
            #endif
            return
        }
        
        guard let url = URL(string: wEventEndpoint) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        var requestBody: [String: Any] = [
            "app": "ios",
            "host": domain,
            "cookie": visitor.cookie,
            "response": "xml",
            "timeout": Int(idleTimeout * 1000)
        ]
        
        if let referer = referer {
            requestBody["referer"] = referer
        }
        
        // Add system properties e.g. device, os, browser
        for (key, value) in properties {
            requestBody[key] = value
        }
        
        // Add visitors properties
        let visitorProperties = visitor.properties
        for (key, value) in visitorProperties {
            requestBody["cv_\(key)"] = value
        }
        
        // Add Event Properties
        for (key, value) in event.properties {
            if key.hasPrefix("~") {
                // Parsing of required system event properties. For example ~event – custom event type. e.g. event=purchase, event=signup etc…
                let index = key.index(key.startIndex, offsetBy: 1)
                requestBody[String(key[index...])] = value
            } else {
                // Parsing of optional event properties
                requestBody["ce_\(key)"] = value
            }
        }
        
        if JSONSerialization.isValidJSONObject(requestBody) == false {
            print("Error: Request body contains invalid values for JSON serialization.")
            return
        }
        
        // Convert requestBody to JSON data
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: requestBody, options:[])
            request.httpBody = jsonData
            
            #if DEBUG
            if let requestBodyString = String(data: jsonData, encoding: .utf8) {
                print("Request Body: \(requestBodyString)")
            }
            #endif
        } catch {
            print("Error converting request body to JSON:\(error.localizedDescription)")
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
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
        }
        task.resume()
    }
    
    public func trackEvent(named: String) {
        self.trackEvent(WEvent(name: named))
    }
    
    // MARK: - Methods
    public func push() {
        let identify = WIdentify(tracker: self)
        DispatchQueue.global(qos: .utility).async {
            identify.run()
        }
    }
}
