//
//  VillageHouse.swift
//  testAnimation
//
//  Created by Thomas Haughton on 09/02/2017.
//  Copyright © 2017 Thomas Haughton. All rights reserved.
//

import Foundation
import SpriteKit

class LargeVillagerHouse:Scenery{
    init(){
        super.init(texture: SKTexture(imageNamed:"mayorHouse"), color: .clearColor(), size: CGSizeMake(500,400))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
