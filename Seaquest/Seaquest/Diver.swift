//
//  Diver.swift
//  Represents a diver chased by a hungry shark
//
//  Created by Marcio Barros on 12/4/14.
//  Copyright (c) 2014 UNIRIO. All rights reserved.
//

import Foundation
import SpriteKit

enum Direction : Int {
    case Right = 1
    case Left = -1
}

class Diver {
    
    var shark = SKSpriteNode(imageNamed: "shark1")
    
    var diver = SKSpriteNode(imageNamed: "diver1")
	
	var diverRunAction : SKAction!
    
    var index : Int!
    
    var distanceToShark : Float!
    
    var direction : Direction!
    
    init(index: Int) {
        self.index = index
        reset()
    }
    
    func reset() {
        distanceToShark = 5 + random() * 10
        direction = (random() > 0.5) ? Direction.Left : Direction.Right
    }
    
    func random() -> Float {
        return Float(arc4random()) / Float(UINT32_MAX)
    }
}