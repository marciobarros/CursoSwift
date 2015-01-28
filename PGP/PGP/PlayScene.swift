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
	var upwardWall = Path()
	var upwardWallDrawing : SKSpriteNode!
	var lastPosition = CGFloat(0)
	var tunnelLayer = CAShapeLayer()
	var starfieldLayer = StarfieldLayer()

    override func didMoveToView(view: SKView) {
		backgroundColor = UIColor.blackColor()

		tunnelLayer.frame = CGRectInset(view.frame, 0, 0)
		tunnelLayer.anchorPointZ = 10
		tunnelLayer.strokeColor = UIColor.whiteColor().CGColor
		tunnelLayer.fillColor = UIColor.blackColor().CGColor
		self.view?.layer.addSublayer(tunnelLayer)
		
		starfieldLayer.frame = CGRectInset(view.frame, 0, 0)
		starfieldLayer.anchorPointZ = 20
		starfieldLayer.addStarfield(50, color: UIColor.whiteColor().CGColor, speed: 5.0)
		starfieldLayer.addStarfield(33, color: UIColor.yellowColor().CGColor, speed: 3.0)
		starfieldLayer.addStarfield(15, color: UIColor.redColor().CGColor, speed: 1.0)
		view.layer.addSublayer(starfieldLayer)
	
		createInitialPath()
		drawMovingWalls()
    }
	
	func drawMovingWalls() {
		tunnelLayer.path = upwardWall.getMutablePath()
	}
	
	func createInitialPath() {
		lastPosition = tunnelLayer.bounds.midY
		
		for (var x : CGFloat = 0.0; x <= tunnelLayer.bounds.maxX; x += 4)
		{
			lastPosition = lastPosition + CGFloat(random() * 10.0 - 5.0)
			upwardWall.add(x, y: lastPosition)
		}
	}
	
	func shiftWalls() {
		lastPosition = max(min(lastPosition + CGFloat(random() * 10.0 - 5.0), tunnelLayer.bounds.midY + 30), tunnelLayer.bounds.midY - 160)
		upwardWall.removeFirst()
		upwardWall.shift(-4.0, dy: 0.0)
		upwardWall.add(tunnelLayer.bounds.maxX + 4, y: lastPosition)
		drawMovingWalls()
	}
	
	/*
	 * Returns a uniform [0, 1] random number
	 */
    func random() -> Float {
        return Float(arc4random()) / Float(UINT32_MAX)
    }
	
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
//        for touch: AnyObject in touches {
//            let location = touch.locationInNode(self)
//            
//        }
    }
	
	override func update(currentTime: NSTimeInterval) {
		shiftWalls()
		starfieldLayer.update()
	}
}