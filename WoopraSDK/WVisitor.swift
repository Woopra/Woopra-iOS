//
//  WVisitor.swift
//  WoopraSDK
//
//  Created by Woopra on 18.09.17.
//  Copyright © 2017 Woopra. All rights reserved.
//

import UIKit

public class WVisitor: WPropertiesContainer {
    
    public var cookie: String = ""
    private static let WoopraCookieKey = "woopra_cookie"
    
    public static func visitor(withCookie cookie: String) -> WVisitor {
        let visitor = WVisitor()
        visitor.cookie = cookie
        return visitor
    }
    
    public static func visitor(withEmail email: String) -> WVisitor {
        let visitor = WVisitor()
        visitor.cookie = generateCookie()
        visitor.add(property: "email", value: email)
        return visitor
    }
    
    public static func anonymousVisitor() -> WVisitor {
        return visitor(withCookie: generateCookie())
    }
    
    // MARK: - Private
    private static func generateCookie() -> String {
        guard let anonymousCookie = UserDefaults.standard.string(forKey: WoopraCookieKey) else {
            let anonymousCookie = NSUUID().uuidString.replacingOccurrences(of: "-", with: "").lowercased()
            UserDefaults.standard.setValue(anonymousCookie, forKey: WoopraCookieKey)
            UserDefaults.standard.synchronize()
            return anonymousCookie
        }
        
        return anonymousCookie
    }
}
