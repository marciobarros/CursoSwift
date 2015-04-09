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
		
        let animationTexture = SKAction.animateWithTextures(createTextures(), timePerFrame: 0.016)
        var walkerAnimation = SKAction.repeatActionForever(animationTexture)
        walker.runAction(walkerAnimation)
	}
	
	func createTextures() -> [SKTexture] {
		var textures : [SKTexture] = []
		
		for i in 0...29 {
			var name = String(format: "walk-%02d", i)
			var texture = SKTexture(imageNamed: name)
			textures += [texture]
		}
		
		return textures
	}
}