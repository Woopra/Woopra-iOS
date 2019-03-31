//
//  DictionaryExtension.swift
//  WoopraSDK
//
//  Created by Woopra on 23.09.17.
//  Copyright © 2017 Woopra. All rights reserved.
//

extension Dictionary {

    mutating func update(with dictionary: Dictionary) {
        for (key, value) in dictionary {
            updateValue(value, forKey: key)
        }
    }
}
