//
//  Villager.swift
//  testAnimation
//
//  Created by Thomas Haughton on 29/01/2017.
//  Copyright © 2017 Thomas Haughton. All rights reserved.
//

import Foundation
import SpriteKit

class Villager:QuestGiver{
    
    init(){
        super.init(texture: nil, color: .blueColor(), size: CGSizeMake(100, 100))
        dialogue = ["Darn this lake!","I dropped my boot whilst trying to wash it...","It ain't easy to come by leather that good round here."]
        completeDialogue.append("Thank you")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
