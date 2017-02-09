//
//  VillageHouse.swift
//  testAnimation
//
//  Created by Thomas Haughton on 09/02/2017.
//  Copyright © 2017 Thomas Haughton. All rights reserved.
//

import Foundation
import SpriteKit

class VillagerHouse:Scenery{
    init(){
        super.init(texture: SKTexture(imageNamed:"villageHouse"), color: .clearColor(), size: CGSizeMake(300,200))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
