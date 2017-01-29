//
//  WolfQuest.swift
//  testAnimation
//
//  Created by Thomas Haughton on 29/01/2017.
//  Copyright © 2017 Thomas Haughton. All rights reserved.
//

class WolfQuest:Quest{
    
    override init() {
        super.init()
        reward = TestHelmet()
        objectives.append(Objective(description: "Kill 3 wolves", toKill: Wolf(), numToKill: 3))
    }
}
