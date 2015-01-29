//
//  StarfieldLayer.swift
//  PGP
//
//  Created by Marcio Barros on 1/28/15.
//  Copyright (c) 2015 UNIRIO. All rights reserved.
//

import Foundation
import SpriteKit

//
// Custom layer that presents a parallax scrolling starfield
//
class StarfieldLayer : CALayer {
	var starfields : [Starfield] = []
	var horizontalGravity = CGFloat(0.0)
	var verticalGravity = CGFloat(1.0)
	
	// Required standard initializer for layers
	required init(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	// Standard initializer for layers with no parameter
	override init() {
		super.init()
	}
	
	// Adds a starfield to the layer
	func addStarfield(starCount: Int, color: CGColor, speed: CGFloat) {
		var width = bounds.width
		var height = bounds.height
		starfields += [Starfield(width: width, height: height, starCount: starCount, color: color, speed: speed)]
		setNeedsDisplay()
	}
	
	// Draws a given starfield
	func drawStarfield(context: CGContext!, field: Starfield) {
		CGContextSetStrokeColorWithColor(context, field.color)

		for star in field.stars {
			CGContextAddRect(context, CGRectMake(star.x, star.y, 0.5, 0.5))
		}
		
		CGContextStrokePath(context)
	}
	
	// Draws all starfields in the layer
	override func drawInContext(context: CGContext!) {
		for field in starfields {
			drawStarfield(context, field: field)
		}
	}
	
	// Update the position of stars in all starfields
	func update() {
		for field in starfields {
			field.move(horizontalGravity, dy: verticalGravity, width: bounds.width, height: bounds.height)
		}

		setNeedsDisplay()
	}
}

//
// Class that represents a starfield
//
class Starfield {
	var speed = CGFloat(0.0)
	var color : CGColor!
	var stars : [Star] = []

	// Initializes a starfield
	init(width: CGFloat, height: CGFloat, starCount: Int, color: CGColor, speed: CGFloat) {
		self.color = color
		self.speed = speed

		for (var i = 0; i < starCount; i++) {
			self.stars += [Star(width: width, height: height)]
		}
	}

	// Moves the starfield
	func move(dx: CGFloat, dy: CGFloat, width: CGFloat, height: CGFloat) {
		for star in stars {
			star.move(dx * speed, dy: dy * speed, width: width, height: height)
		}
	}
}

//
// Class that represents a star in a starfield
//
class Star {
	var x = CGFloat(0.0)
	var y = CGFloat(0.0)
	
	// Initializes the star in a given position
	init(x: CGFloat, y: CGFloat) {
		self.x = x
		self.y = y
	}
	
	// Initializes the star in a random position
	init(width: CGFloat, height: CGFloat) {
		self.x = width * CGFloat.random()
		self.y = height * CGFloat.random()
	}

	// Moves the star by a certain degree
	func move(dx: CGFloat, dy: CGFloat, width: CGFloat, height: CGFloat) {
		x += dx
		y += dy
		
		if x > width {
			x = x - width
		}
		else if x < 0.0 {
			x = width - x
		}
		
		if y > height {
			y = y - height
		}
		else if y < 0.0 {
			y = height - y
		}
	}
}