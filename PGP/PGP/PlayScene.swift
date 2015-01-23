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
	var downwardWall = Path()
	var upwardWallDrawing : SKShapeNode!
	var downwardWallDrawing : SKShapeNode!
	var lastPosition: CGPoint!
	var lastHeight : Float = 0.0

    override func didMoveToView(view: SKView) {
		backgroundColor = UIColor.whiteColor()
		drawMovingWalls()
    }
	
	func drawMovingWalls() {
		upwardWallDrawing = SKShapeNode()
		upwardWallDrawing.strokeColor = UIColor.blackColor()
		upwardWallDrawing.lineWidth = 4
		self.addChild(upwardWallDrawing)
		
		downwardWallDrawing = SKShapeNode()
		downwardWallDrawing.strokeColor = UIColor.blackColor()
		downwardWallDrawing.lineWidth = 4
		self.addChild(downwardWallDrawing)
		
		createInitialPath()
	}
	
	func createInitialPath() {
		lastPosition = CGPointMake(frame.minX, CGRectGetMidY(frame))
		lastHeight = 100.0
		
		for (var x = frame.minX; x <= frame.maxX; x += 4)
		{
			var y = lastPosition.y + CGFloat(random() * 10.0 - 5.0)
			lastHeight += random() * 10.0 - 5.0
			
			if (lastHeight > 200) {
				lastHeight = 200
			}
			
			if (lastHeight < 40) {
				lastHeight = 40
			}
			
			lastPosition = CGPointMake(x, y)
			upwardWall.add(x, y: y)
			downwardWall.add(x, y: y - CGFloat(lastHeight))
		}
		
		updateWalls()
	}
	
	func updateWalls() {
		updateWall(upwardWall, shape: upwardWallDrawing)
		updateWall(downwardWall, shape: downwardWallDrawing)
	}
	
	func updateWall(path: Path, shape: SKShapeNode) {
		shape.removeFromParent()
		shape.path = path.getMutablePath()
		shape.strokeColor = UIColor.blackColor()
		shape.lineWidth = 4
		self.addChild(shape)
	}
	
	func shiftWalls() {
		var y = lastPosition.y + CGFloat(random() * 10.0 - 5.0)
		lastHeight += random() * 10.0 - 5.0
		
		upwardWall.removeFirst()
		upwardWall.shift(-4.0, dy: 0.0)
		upwardWall.add(lastPosition.x + 4, y: y)
		
		downwardWall.removeFirst()
		downwardWall.shift(-4.0, dy: 0.0)
		downwardWall.add(lastPosition.x + 4, y: y - CGFloat(lastHeight))
		
		lastPosition = CGPointMake(lastPosition.x + 4.0, y)
		updateWalls()
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
	}
}