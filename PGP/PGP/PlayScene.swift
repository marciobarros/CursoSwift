//
//  PlayScene.swift
//  PGP
//
//  Created by Marcio Barros on 1/23/15.
//  Copyright (c) 2015 UNIRIO. All rights reserved.
//

import Foundation
import SpriteKit

class PlayScene: SKScene {
	var tunnelNode : TunnelNode!
	var starfieldNode : ParallaxStarfieldNode!
	var spaceshipNode : SKSpriteNode!

    override func didMoveToView(view: SKView) {
		backgroundColor = UIColor.blackColor()
		physicsWorld.gravity = CGVectorMake(0.0, 0.0)

		createStarfield(view)
		createTunnel(view)
		createSpaceship()
    }
	
	func createStarfield(view: SKView) {
		starfieldNode = ParallaxStarfieldNode(size: view.bounds.size)
		starfieldNode.zPosition = 0
		starfieldNode.addStarfield(50, color: UIColor.whiteColor(), speed: 5.0)
		starfieldNode.addStarfield(33, color: UIColor.yellowColor(), speed: 3.0)
		starfieldNode.addStarfield(15, color: UIColor.redColor(), speed: 1.0)
		self.addChild(starfieldNode)
	}
	
	func createTunnel(view: SKView) {
		tunnelNode = TunnelNode(size: view.bounds.size)
		tunnelNode.zPosition = 10
		tunnelNode.createInitialTunnel()
		self.addChild(tunnelNode)
	}
	
	func createSpaceship() {
		spaceshipNode = SKSpriteNode(imageNamed: "Spaceship")
		spaceshipNode.anchorPoint = CGPointMake(0, 0.5)
		spaceshipNode.position = CGPointMake(5.0, frame.midY)
		spaceshipNode.setScale(0.05)
		spaceshipNode.zRotation = CGFloat(-M_PI_2)
		spaceshipNode.zPosition = 20
		self.addChild(spaceshipNode)
		
		var center = CGPointMake(spaceshipNode.frame.width * (0.5 - spaceshipNode.anchorPoint.x), spaceshipNode.frame.height * (0.5 - spaceshipNode.anchorPoint.y))
		var borderBody = SKPhysicsBody(circleOfRadius: spaceshipNode.frame.width / 2, center: center)
		spaceshipNode.physicsBody = borderBody
	}
	
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
//        for touch: AnyObject in touches {
//            let location = touch.locationInNode(self)
//            
//        }
    }
	
	override func update(currentTime: NSTimeInterval) {
		tunnelNode.update()
		starfieldNode.update()
	}
}