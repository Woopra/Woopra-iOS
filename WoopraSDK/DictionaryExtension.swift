//
//  DictionaryExtension.swift
//  WoopraSDK
//
//  Created by Woopra on 23.09.17.
//  Copyright © 2017 Woopra. All rights reserved.
//

import UIKit

extension Dictionary {
    mutating func update(other:Dictionary) {
        for (key,value) in other {
            self.updateValue(value, forKey:key)
        }
    }
}
