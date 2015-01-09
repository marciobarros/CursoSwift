//
//  GameScene.swift
//  Seaquest
//
//  Created by Marcio Barros on 11/26/14.
//  Copyright (c) 2014 UNIRIO. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    let startLabel = SKLabelNode(fontNamed:"Chalkduster")

    override func didMoveToView(view: SKView) {
        startLabel.text = "Começar!"
        startLabel.fontSize = 65;
        startLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        self.addChild(startLabel)
        self.backgroundColor = UIColor(hex: 0x80D9FF)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            
            if self.nodeAtPoint(location) == self.startLabel {
                var scene = PlayScene(size: self.size)
                let skView = self.view as SKView!
                skView.ignoresSiblingOrder = true
                scene.scaleMode = .ResizeFill
                scene.size = skView.bounds.size
                skView.presentScene(scene)
            }
        }
    }
}