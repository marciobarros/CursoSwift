//
//  GameScene.swift
//  Starfield
//
//  Created by Marcio Barros on 3/4/15.
//  Copyright (c) 2015 UNIRIO. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
	var starfield: ParallaxStarfieldNode!
	
	/*
	 * Creates the parallax starfield
	 */
    override func didMoveToView(view: SKView) {
		starfield = ParallaxStarfieldNode(size: view.bounds.size)
		starfield.addStarfield(50, color: UIColor.redColor(), speed: 0.25)
		starfield.addStarfield(75, color: UIColor.yellowColor(), speed: 0.50)
		starfield.addStarfield(100, color: UIColor.whiteColor(), speed: 1.0)
		starfield.position = CGPointMake(0.0, 0.0)
		self.addChild(starfield)
    }
	
	/*
	 * Changes gravity according to touch
	 */
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
			
			var hg = (location.x - frame.midX) / (frame.maxX - frame.midX)
			starfield.horizontalGravity += hg

			var vg = -(location.y - frame.midY) / (frame.maxY - frame.midY)
			starfield.verticalGravity += vg
		}
    }
	
	/*
	 * Updates the starfield
	 */
    override func update(currentTime: CFTimeInterval) {
		starfield.update()
	}
}
