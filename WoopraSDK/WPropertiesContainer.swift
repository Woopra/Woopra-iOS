//
//  WPropertiesContainer.swift
//  WoopraSDK
//
//  Created by Woopra on 15.09.17.
//  Copyright © 2017 Woopra. All rights reserved.
//

import Foundation

public class WPropertiesContainer: NSObject {
    var properties = Dictionary<String, String>()
    
    public func add(property key: String, value: String) {
            properties[key] = value
        }
    
    public func add(properties newDictionary: Dictionary<String, String>) {
        properties.update(other: newDictionary)
    }
}




