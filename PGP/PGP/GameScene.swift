//
//  GameScene.swift
//  PGP
//
//  Created by Marcio Barros on 1/23/15.
//  Copyright (c) 2015 UNIRIO. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {

    override func didMoveToView(view: SKView) {
        let mainTitle = SKLabelNode(fontNamed:"Chalkduster")
        mainTitle.text = "Playmobil"
        mainTitle.fontSize = 65
        mainTitle.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame) + 70)
        self.addChild(mainTitle)
		
        let subTitle = SKLabelNode(fontNamed:"Chalkduster")
        subTitle.text = "God of Physics"
        subTitle.fontSize = 32
        subTitle.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        self.addChild(subTitle)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
		let skView = self.view as SKView!
		//skView.showsFPS = true
		//skView.showsNodeCount = true
		//skView.showsPhysics = true
		
		var scene = PlayScene(size: skView.bounds.size)
		scene.scaleMode = .AspectFill
		skView.presentScene(scene)
    }
}