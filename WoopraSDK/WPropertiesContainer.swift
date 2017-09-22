//
//  WPropertiesContainer.swift
//  WoopraSDK
//
//  Created by Woopra on 15.09.17.
//  Copyright © 2017 Woopra. All rights reserved.
//

import Foundation

class WPropertiesContainer: NSObject {
    var properties = Dictionary<String, String>()
    
    func add(property key: String, value: String) {
            properties["key"] = value
        }
    
    func add(properties newDictionary: Dictionary<String, String>) {
        properties.update(other: newDictionary)
    }
}

// MARK: - Dictionary extention
extension Dictionary {
    mutating func update(other:Dictionary) {
        for (key,value) in other {
            self.updateValue(value, forKey:key)
        }
    }
}




