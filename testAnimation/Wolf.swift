//
//  Wolf.swift
//  testAnimation
//
//  Created by Thomas Haughton on 29/01/2017.
//  Copyright © 2017 Thomas Haughton. All rights reserved.
//

import Foundation
import SpriteKit

class Wolf: MeleeEnemy{
    
    init(){
        super.init(texture: nil, color: .whiteColor(), size: CGSizeMake(100, 100))
        attackSpeed = 0.5
        attack = 6
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
