//
//  GameScene.swift
//  Walk of Life
//
//  Created by Marcio Barros on 4/8/15.
//  Copyright (c) 2015 UNIRIO. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
	var walker : SKSpriteNode!
	var currentTexture = 0

    override func didMoveToView(view: SKView) {
		backgroundColor = UIColor.whiteColor()
		createWalker()
    }
	
	func createWalker() {
		var texture = SKTexture(imageNamed: "walk-00")
        walker = SKSpriteNode(texture: texture)
        walker.position = CGPointMake(frame.midX, frame.midY)
        walker.anchorPoint = CGPointMake(0.5, 0.5)
        addChild(walker)
	}
    
    override func update(currentTime: CFTimeInterval) {
		var name = String(format: "walk-%02d", currentTexture)
		walker.texture = SKTexture(imageNamed: name)
		currentTexture = (currentTexture + 1) % 30
    }
}
