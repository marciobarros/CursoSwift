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
	var tunnelLayer = TunnelLayer()
	var starfieldLayer = StarfieldLayer()
	var spaceship = SKSpriteNode(imageNamed: "Spaceship")

    override func didMoveToView(view: SKView) {
		backgroundColor = UIColor.blackColor()
		createStarfield(view)
		createTunnel(view)
		createSpaceship()
    }
	
	func createStarfield(view: SKView) {
		starfieldLayer.frame = CGRectInset(view.frame, 0, 0)
		starfieldLayer.zPosition = 0
		starfieldLayer.addStarfield(50, color: UIColor.whiteColor().CGColor, speed: 5.0)
		starfieldLayer.addStarfield(33, color: UIColor.yellowColor().CGColor, speed: 3.0)
		starfieldLayer.addStarfield(15, color: UIColor.redColor().CGColor, speed: 1.0)
		view.layer.addSublayer(starfieldLayer)
	}
	
	func createTunnel(view: SKView) {
		tunnelLayer.frame = CGRectInset(view.frame, 0, 0)
		tunnelLayer.zPosition = 10
		tunnelLayer.createInitialTunnel()
		self.view?.layer.addSublayer(tunnelLayer)
	}
	
	func createSpaceship() {
		spaceship.anchorPoint = CGPointMake(0, 0.5)
		spaceship.position = CGPointMake(5.0, frame.midY)
		spaceship.xScale = 0.1
		spaceship.yScale = 0.1
		spaceship.zPosition = 20
		self.addChild(spaceship)
	}
	
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
//        for touch: AnyObject in touches {
//            let location = touch.locationInNode(self)
//            
//        }
    }
	
	override func update(currentTime: NSTimeInterval) {
		tunnelLayer.update()
		starfieldLayer.update()
	}
}