//
//  WEvent.swift
//  WoopraSDK
//
//  Created by Woopra on 15.09.17.
//  Copyright © 2017 Woopra. All rights reserved.
//

import Foundation

class WEvent: WPropertiesContainer {
    
    init(name: String) {
        super.init()
        self.add(property: "~event", value: name)
    }
    
    static func event(name: String) -> WEvent {
        return WEvent(name: name)
    }
}
