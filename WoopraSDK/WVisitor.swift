//
//  WVisitor.swift
//  WoopraSDK
//
//  Created by Woopra on 18.09.17.
//  Copyright © 2017 Woopra. All rights reserved.
//

import UIKit


class WVisitor: WPropertiesContainer {
    
    public var cookie: String = ""
    private static let WoopraCookieKey = "woopra_cookie"
    
    static func visitor(withCookie cookie: String) -> WVisitor {
        let visitor = WVisitor()
        visitor.cookie = cookie
        return visitor
    }
    
    static func visitor(withEmail email: String) -> WVisitor {
        let visitor = WVisitor()
        visitor.cookie = visitor.hash(string: email)
        visitor.add(property: "email", value: email)
        return visitor
    }
    
    static func anonymousVisitor() -> WVisitor {
        let visitor =  WVisitor()
        if let anonymousCookie = UserDefaults.standard.string(forKey: WoopraCookieKey) {
            visitor.cookie = anonymousCookie
        } else {
            let anonymousCookie = NSUUID().uuidString.replacingOccurrences(of: "-", with: "").lowercased()
            UserDefaults.standard.setValue(anonymousCookie, forKey: WoopraCookieKey)
            UserDefaults.standard.synchronize()
            visitor.cookie = anonymousCookie
        }
        
        return visitor
    }
    
    // MARK: - Private
    private func hash(string: String) -> String {
        let key = "woopra_ios"
        let str = string.cString(using: String.Encoding.utf8)
        let strLen = Int(string.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        let keyStr = key.cString(using: String.Encoding.utf8)
        let keyLen = Int(key.lengthOfBytes(using: String.Encoding.utf8))
        
        CCHmac(CCHmacAlgorithm(kCCHmacAlgMD5), keyStr!, keyLen, str!, strLen, result)
        
        let digest = stringFromResult(result: result, length: digestLen)
        
        result.deallocate(capacity: digestLen)
        
        return digest
    }
    
    private func stringFromResult(result: UnsafeMutablePointer<CUnsignedChar>, length: Int) -> String {
        let hash = NSMutableString()
        for i in 0..<length {
            hash.appendFormat("%02x", result[i])
        }
        return String(hash)
    }
}
