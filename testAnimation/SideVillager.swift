//
//  Villager.swift
//  testAnimation
//
//  Created by Thomas Haughton on 29/01/2017.
//  Copyright © 2017 Thomas Haughton. All rights reserved.
//

import Foundation
import SpriteKit

class SideVillager:QuestGiver{
    
    init(){
        super.init(texture: nil, color: .blueColor(), size: CGSizeMake(100, 100))
        dialogue = ["Hey, you look a little bare","Kill 3 wolves in the forest north-east for me","I promise there'll be something in it for you"]
        completeDialogue = ["You have the pelts? Excellent!","Here's something to keep that skull safe"]
        quest = WolfQuest()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
