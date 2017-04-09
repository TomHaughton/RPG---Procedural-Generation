//
//  Villager.swift
//  testAnimation
//
//  Created by Thomas Haughton on 29/01/2017.
//  Copyright © 2017 Thomas Haughton. All rights reserved.
//

import Foundation
import SpriteKit

class OasisDweller:QuestGiver{
    
    init(){
        super.init(texture: SKTexture(imageNamed: "mayor"), color: .clearColor(), size: CGSizeMake(100, 100))
        dialogue = ["Ah yes, that pod landed just west of here.","A guy dressed like you was in here earlier,","I think he headed into the temple.","There are some treasure hunters waiting to go in,","If you can take them out then I have a small reward."]
        completeDialogue = ["Your soul be blessed,","Some may have already gotten in though.","It'd be great if you could stop them too!"]
        quest = TreasureQuest()
        help = LargePotion()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
