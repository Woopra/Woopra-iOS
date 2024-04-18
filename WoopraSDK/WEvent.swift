//
//  WEvent.swift
//  WoopraSDK
//
//  Created by Woopra on 15.09.17.
//  Copyright © 2017 Woopra. All rights reserved.
//

import Foundation

@objcMembers
public class WEvent: WPropertiesContainer {
    
    public init(name: String) {
        super.init()
        add(property: "~event", value: name)
    }
    
    public static func event(name: String) -> WEvent {
        return WEvent(name: name)
    }
}
