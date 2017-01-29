//
//  DungeonRoom.swift
//  testAnimation
//
//  Created by Thomas Haughton on 15/01/2017.
//  Copyright © 2017 Thomas Haughton. All rights reserved.
//

import Foundation
import SpriteKit

class DungeonRoom:Equatable{
    var location:CGPoint!
    var enemiesClear: Bool!
    var itemsClear: Bool!
    
    init(location: CGPoint, enemiesClear: Bool, itemsClear: Bool) {
        self.location = location
        self.enemiesClear = enemiesClear
        self.itemsClear = itemsClear
    }
}

func == (lhs: DungeonRoom, rhs: DungeonRoom) -> Bool {
    return lhs.location == rhs.location && lhs.enemiesClear == rhs.enemiesClear && lhs.itemsClear == rhs.itemsClear
}
