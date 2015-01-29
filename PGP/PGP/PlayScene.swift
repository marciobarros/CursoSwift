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
	var preparingToChange = false

    override func didMoveToView(view: SKView) {
		backgroundColor = UIColor.blackColor()
		physicsWorld.gravity = CGVectorMake(0.0, 0.1)

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
		spaceshipNode.position = CGPointMake(10.0, frame.midY)
		spaceshipNode.setScale(0.05)
		spaceshipNode.zRotation = CGFloat(-M_PI_2)
		spaceshipNode.zPosition = 20
		self.addChild(spaceshipNode)
		
		var center = CGPointMake(spaceshipNode.frame.width * (0.5 - spaceshipNode.anchorPoint.x), spaceshipNode.frame.height * (0.5 - spaceshipNode.anchorPoint.y))
		var borderBody = SKPhysicsBody(circleOfRadius: spaceshipNode.frame.width / 2, center: center)
		spaceshipNode.physicsBody = borderBody
	}
	
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)

			if (location.y < spaceshipNode.position.y) {
				spaceshipNode.physicsBody?.applyImpulse(CGVectorMake(0.0, -1.0))
			}
			else if (location.y > spaceshipNode.position.y) {
				spaceshipNode.physicsBody?.applyImpulse(CGVectorMake(0.0, 1.0))
			}
        }
    }
	
	override func update(currentTime: NSTimeInterval) {
		tunnelNode.update()
		starfieldNode.update()
		
		if CGFloat.random() < 0.05 && !preparingToChange {
			backgroundColor = UIColor.redColor()
			let this = self
			
			var interval = CFTimeInterval(2.0)
			let diverWait = SKAction.waitForDuration(interval)
			preparingToChange = true
			
			spaceshipNode.runAction(diverWait, completion: {
				this.physicsWorld.gravity = CGVectorMake(0.0, CGFloat.random() * 0.5)
				this.spaceshipNode.physicsBody?.friction = CGFloat.random() * 0.5
				this.spaceshipNode.physicsBody?.linearDamping = CGFloat.random() * 0.5
				this.starfieldNode.verticalGravity = this.physicsWorld.gravity.dy
				this.backgroundColor = UIColor.blackColor()
				this.preparingToChange = false
			});
		}
	}
}