//
//  GameScene.swift
//  Transitions
//
//  Created by Marcio Barros on 3/19/15.
//  Copyright (c) 2015 UNIRIO. All rights reserved.
//

import SpriteKit

class ThirdScene: SKScene {
    override func didMoveToView(view: SKView) {
        let myLabel = SKLabelNode(fontNamed: "Chalkduster")
        myLabel.text = "Terceira cena!";
        myLabel.fontSize = 65;
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        self.addChild(myLabel)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
			
			if location.x < CGRectGetMidX(self.frame) {
				let transition = TransitionFactory.createBackwardTransition()
				let skView = self.view as SKView!
				var scene = SecondScene(size: self.size)
                scene.scaleMode = .ResizeFill
                skView.presentScene(scene, transition: transition)
			}
		}
    }
}
