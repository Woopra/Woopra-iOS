//
//  WPropertiesContainer.swift
//  WoopraSDK
//
//  Created by Woopra on 15.09.17.
//  Copyright © 2017 Woopra. All rights reserved.
//

import Foundation

@objcMembers
public class WPropertiesContainer: NSObject {
    public private(set) var properties: [String: Any] = [:]

    public func add(property key: String, value: Any) {
        properties[key] = value
    }
    
    public func add(properties newDictionary: [String: Any]) {
        properties.update(with: newDictionary)
    }
}
