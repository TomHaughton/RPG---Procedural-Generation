//
//  Villager.swift
//  testAnimation
//
//  Created by Thomas Haughton on 29/01/2017.
//  Copyright © 2017 Thomas Haughton. All rights reserved.
//

import Foundation
import SpriteKit

class Villager2:QuestGiver{
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        dialogue = ["I can't keep bare living here much longer!","Every time I fix my hosue up, they just come back and ruin it again...","The mayor won't even do anything about it."]
        completeDialogue.append("Thank you")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
