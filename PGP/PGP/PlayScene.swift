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
	var globeNode : SKShapeNode!
	var spaceshipNode : SKSpriteNode!
	var niceGodNode : SKSpriteNode!
	var cruelGodNode : SKSpriteNode!
	var preparingToChange = false
	var nextTimeChanged : NSTimeInterval!
	var startGameTime : NSTimeInterval!
	var scoreLabel : SKLabelNode!
	var gravityLabel : SKLabelNode!
	var frictionLabel : SKLabelNode!
	var currentRadius = CGFloat(0)
	var gamePaused = false

    override func didMoveToView(view: SKView) {
		backgroundColor = UIColor.blackColor()
		physicsWorld.gravity = CGVectorMake(0.0, 0.1)

		var bgImage = SKSpriteNode(imageNamed: "background")
		bgImage.position = CGPointMake(self.size.width/2, self.size.height/2)
		bgImage.zPosition = 0
		self.addChild(bgImage)

		createGlobe(view)
		createNiceGod(view)
		createCruelGod(view)
		createSpaceship(view)
		createDataPanel(view)
    }

	func createGlobe(view: SKView) {
		currentRadius = view.bounds.height * 0.45
		globeNode = SKShapeNode(circleOfRadius: currentRadius)
		globeNode.position = CGPointMake(view.bounds.height * 0.5, view.bounds.height * 0.5)
		globeNode.fillColor = UIColor.blackColor()
		globeNode.strokeColor = UIColor.whiteColor()
		globeNode.zPosition = 10
		globeNode.lineWidth = 2.0
		self.addChild(globeNode)
	}

	func createNiceGod(view: SKView) {
		niceGodNode = SKSpriteNode(imageNamed: "niceGod")
		niceGodNode.position = CGPointMake(view.bounds.width + 10.0, -10.0)
		niceGodNode.anchorPoint = CGPointMake(1.0, 0.0)
		niceGodNode.zPosition = 10
		self.addChild(niceGodNode)
	}

	func createCruelGod(view: SKView) {
		cruelGodNode = SKSpriteNode(imageNamed: "cruelGod")
		cruelGodNode.position = CGPointMake(view.bounds.width, 0)
		cruelGodNode.anchorPoint = CGPointMake(1.0, 0.0)
		cruelGodNode.zPosition = 10
		cruelGodNode.alpha = 0.0
		self.addChild(cruelGodNode)
	}
	
	func createSpaceship(view: SKView) {
		spaceshipNode = SKSpriteNode(imageNamed: "Spaceship")
		spaceshipNode.anchorPoint = CGPointMake(0.5, 0.5)
		spaceshipNode.position = CGPointMake(view.bounds.height * 0.5, view.bounds.height * 0.5)
		spaceshipNode.setScale(0.05)
		spaceshipNode.zRotation = CGFloat(-M_PI_2)
		spaceshipNode.zPosition = 20
		self.addChild(spaceshipNode)
		
		var center = CGPointMake(spaceshipNode.frame.width * (0.5 - spaceshipNode.anchorPoint.x), spaceshipNode.frame.height * (0.5 - spaceshipNode.anchorPoint.y))
		var borderBody = SKPhysicsBody(circleOfRadius: spaceshipNode.frame.width / 2, center: center)
		spaceshipNode.physicsBody = borderBody
	}
	
	func createDataPanel(view: SKView) {
		let scoreTitleLabel = SKLabelNode(fontNamed: "Arial-BoldMT")
		scoreTitleLabel.text = "Score:"
		scoreTitleLabel.fontColor = UIColor.yellowColor()
		scoreTitleLabel.fontSize = 14
		scoreTitleLabel.position = CGPointMake(view.bounds.width * 0.7, view.bounds.height * 0.9)
		addChild(scoreTitleLabel)
		
		scoreLabel = SKLabelNode(fontNamed: "Arial-BoldMT")
		scoreLabel.text = "10000"
		scoreLabel.fontColor = UIColor.whiteColor()
		scoreLabel.fontSize = 10
		scoreLabel.position = CGPointMake(view.bounds.width * 0.7, view.bounds.height * 0.85)
		addChild(scoreLabel)

		let gravityTitleLabel = SKLabelNode(fontNamed: "Arial-BoldMT")
		gravityTitleLabel.text = "Gravity:"
		gravityTitleLabel.fontColor = UIColor.yellowColor()
		gravityTitleLabel.fontSize = 14
		gravityTitleLabel.position = CGPointMake(view.bounds.width * 0.85, view.bounds.height * 0.9)
		addChild(gravityTitleLabel)
		
		gravityLabel = SKLabelNode(fontNamed: "Arial-BoldMT")
		gravityLabel.text = "(10%, 50%)"
		gravityLabel.fontColor = UIColor.whiteColor()
		gravityLabel.fontSize = 10
		gravityLabel.position = CGPointMake(view.bounds.width * 0.85, view.bounds.height * 0.85)
		addChild(gravityLabel)

		let frictionTitleLabel = SKLabelNode(fontNamed: "Arial-BoldMT")
		frictionTitleLabel.text = "Friction:"
		frictionTitleLabel.fontColor = UIColor.yellowColor()
		frictionTitleLabel.fontSize = 14
		frictionTitleLabel.position = CGPointMake(view.bounds.width * 0.85, view.bounds.height * 0.7)
		addChild(frictionTitleLabel)
		
		frictionLabel = SKLabelNode(fontNamed: "Arial")
		frictionLabel.text = "50%"
		frictionLabel.fontColor = UIColor.whiteColor()
		frictionLabel.fontSize = 10
		frictionLabel.position = CGPointMake(view.bounds.width * 0.85, view.bounds.height * 0.65)
		addChild(frictionLabel)
		
		updatePhysicsLabels()
	}
	
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
			var verticalImpulse = CGFloat(0.0)
			var horizontalImpulse = CGFloat(0.0)

			if (location.y < spaceshipNode.position.y - spaceshipNode.size.height/2) {
				verticalImpulse = -1.0
			}
			else if (location.y > spaceshipNode.position.y + spaceshipNode.size.height/2) {
				verticalImpulse = 1.0
			}

			if (location.x < spaceshipNode.position.x + spaceshipNode.size.width / 2) {
				horizontalImpulse = -1.0
			}
			else if (location.x > spaceshipNode.position.x - spaceshipNode.size.width / 2) {
				horizontalImpulse = 1.0
			}
		
			spaceshipNode.zRotation = -horizontalImpulse * CGFloat(M_PI) * (2.0 - verticalImpulse) / 4
			
			spaceshipNode.physicsBody?.applyImpulse(CGVectorMake(horizontalImpulse, verticalImpulse))
        }
    }
	
	func showCruelGod() {
		cruelGodNode.alpha = 1.0
		niceGodNode.alpha = 0.0
	}
	
	func showNiceGod() {
		cruelGodNode.alpha = 0.0
		niceGodNode.alpha = 1.0
	}
	
	func randomizePhysics() {
		var verticalGravity = CGFloat.random() - 0.5
		var horizontalGravity = CGFloat.random() - 0.5
		physicsWorld.gravity = CGVectorMake(horizontalGravity, verticalGravity)
		
		var friction = CGFloat.random()
		spaceshipNode.physicsBody?.friction = friction
		
		updatePhysicsLabels()
	}
	
	func updatePhysicsLabels() {
		var dx = physicsWorld.gravity.dx
		var dy = physicsWorld.gravity.dy
		gravityLabel.text = NSString(format: "%.0f%%, %.0f%%", Double(dx) * 100, Double(dy) * 100)
		
		var friction = spaceshipNode.physicsBody?.friction
		frictionLabel.text = NSString(format: "%.0f%%", Double(friction!) * 100)
	}
	
	override func update(currentTime: NSTimeInterval) {
		if gamePaused {
			return
		}
		
		if nextTimeChanged == nil {
			nextTimeChanged = currentTime + 10.0 + Double(arc4random_uniform(15))
		}
		
		if startGameTime == nil {
			startGameTime = currentTime
		}
		
		let score = currentTime - startGameTime
		scoreLabel.text = NSString(format: "%.0f", score)
		
		var newRadius = view!.bounds.height * 0.45 * (200.0 - CGFloat(score)) / 200.0
		
		if currentRadius - newRadius > 10 {
			globeNode.removeFromParent()
			currentRadius = newRadius
			globeNode = SKShapeNode(circleOfRadius: currentRadius)
			globeNode.position = CGPointMake(view!.bounds.height * 0.5, view!.bounds.height * 0.5)
			globeNode.fillColor = UIColor.blackColor()
			globeNode.strokeColor = UIColor.whiteColor()
			globeNode.zPosition = 10
			globeNode.lineWidth = 2.0
			self.addChild(globeNode)
		}
		
		var distance = sqrt(pow(view!.bounds.height * 0.5 - spaceshipNode.position.x, 2) + pow(view!.bounds.height * 0.5 - spaceshipNode.position.y, 2))
		
		if (distance > currentRadius - 5) {
			die()
			return
		}
		
		if currentTime > nextTimeChanged {
			let this = self
			showCruelGod()
			
			nextTimeChanged = currentTime + 10.0 + Double(arc4random_uniform(15))
			randomizePhysics()

			let waitAction = SKAction.waitForDuration(CFTimeInterval(2.0))
			
			spaceshipNode.runAction(waitAction, completion: {
				this.showNiceGod()
			});
		}
	}
	
    func die() {
		gamePaused = true
		spaceshipNode.removeAllActions()
		spaceshipNode.physicsBody?.dynamic = false
		
		spaceshipNode.runAction(SKAction.fadeOutWithDuration(1))
		runAction(SKAction.playSoundFileNamed("button-10.wav", waitForCompletion: true))
		
		var alert = UIAlertController(title: "Game Over", message: "", preferredStyle: UIAlertControllerStyle.Alert)
		
		alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { _ in
			self.spaceshipNode.position = CGPointMake(self.view!.bounds.height * 0.5, self.view!.bounds.height * 0.5)
			self.nextTimeChanged = nil
			self.startGameTime = nil
			self.globeNode.removeFromParent()
			self.createGlobe(self.view!)
			self.spaceshipNode.alpha = 1.0
			self.spaceshipNode.physicsBody?.dynamic = true
			self.gamePaused = false
		})
			
		self.view?.window?.rootViewController?.presentViewController(alert, animated: true, completion: nil)
   }
}