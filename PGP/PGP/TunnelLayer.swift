//
//  StarfieldLayer.swift
//  PGP
//
//  Created by Marcio Barros on 1/28/15.
//  Copyright (c) 2015 UNIRIO. All rights reserved.
//

import SpriteKit

//
// Custom layer that presents a scrolling tunnel
//
class TunnelLayer : CAShapeLayer {
	let INCREMENT = CGFloat(8)
	var tunnel = TunnelPath()
	var lastY = CGFloat(0)
	
	// Required standard initializer for layers
	required init(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		self.strokeColor = UIColor.whiteColor().CGColor
		self.fillColor = UIColor.blackColor().CGColor
	}
	
	// Standard initializer for layers with no parameter
	override init() {
		super.init()
		self.strokeColor = UIColor.whiteColor().CGColor
		self.fillColor = UIColor.blackColor().CGColor
	}
	
	// Create an initial, random tunnel
	func createInitialTunnel() {
		lastY = self.bounds.midY - 50.0
		
		for (var x : CGFloat = 0.0; x <= self.bounds.maxX; x += INCREMENT)
		{
			lastY = nextPosition()
			tunnel.add(x, y: lastY)
		}
		
		tunnel.add(self.bounds.maxX + INCREMENT, y: lastY)
		self.path = tunnel.getPath()
		setNeedsDisplay()
	}

	// Grabs the next position for the tunnel
	func nextPosition() -> CGFloat {
		var y = lastY + CGFloat.random() * 10.0 - 5.0
		
		if y < self.bounds.minY + 30 {
			y = self.bounds.minY + 30
		}
		else if y > self.bounds.maxY - 130 {
			y = self.bounds.maxY - 130
		}
		
		return y
	}

	// Shifts the tunnel by a certain ammount on every tick
	func update() {
		lastY = nextPosition()
		tunnel.removeFirst()
		tunnel.shift(-INCREMENT, dy: 0.0)
		tunnel.add(self.bounds.maxX + INCREMENT, y: lastY)
		self.path = tunnel.getPath()
		setNeedsDisplay()
	}
}

//
// Class that represents the tunnel itself
//
class TunnelPath {
	var points : [TunnelPoint] = []
	
	// Adds a segment to the tunnel
	func add(x: CGFloat, y: CGFloat) {
		points += [TunnelPoint(x: x, y: y)]
	}
	
	// Removes the first segment of the tunnel
	func removeFirst() {
		points.removeAtIndex(0)
	}
	
	// Shifts the tunnel by a certain amount
	func shift(dx: CGFloat, dy: CGFloat) {
		for point in points {
			point.x += dx
			point.y += dy
		}
	}
	
	// Creates a path to represent the tunnel
	func getPath() -> CGMutablePathRef {
		var path = CGPathCreateMutable()
		CGPathMoveToPoint(path, nil, points[0].x, points[0].y)
		
		for (var i = 1; i < points.count; i++) {
			CGPathAddLineToPoint(path, nil, points[i].x, points[i].y)
		}
		
		for (var i = points.count-1; i >= 0; i--) {
			CGPathAddLineToPoint(path, nil, points[i].x, points[i].y + 100.0)
		}
		
		return path
	}
}

//
// Class that represents a point in the tunnel path
//
class TunnelPoint {
	var x : CGFloat
	var y : CGFloat
	
	// Initializes a point, given its position
	init(x: CGFloat, y: CGFloat) {
		self.x = x
		self.y = y
	}
}