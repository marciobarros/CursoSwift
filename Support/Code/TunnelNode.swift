//
//  TunnelNode.swift
//  PGP
//
//  Created by Marcio Barros on 1/28/15.
//  Copyright (c) 2015 UNIRIO. All rights reserved.
//

import SpriteKit

//
// Custom shape node that presents a scrolling tunnel
//
class TunnelNode : SKShapeNode {
	let INCREMENT = CGFloat(8)
	var tunnel = TunnelPath()
	var lastY = CGFloat(0)
	var size : CGSize!
	
	// Required standard initializer for nodes
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	// Initializes the node to a given size
	required init(size: CGSize) {
		super.init()
		self.size = size
	}
	
	// Create an initial, random tunnel
	func createInitialTunnel() {
		lastY = size.height / 2 - 50.0
		
		for (var x : CGFloat = 0.0; x <= size.width; x += INCREMENT)
		{
			lastY = nextPosition()
			tunnel.add(x, y: lastY)
		}
		
		tunnel.add(size.width + INCREMENT, y: lastY)
		self.strokeColor = UIColor.whiteColor()
		self.fillColor = UIColor.blackColor()
		self.path = tunnel.getPath()
	}

	// Grabs the next position for the tunnel
	func nextPosition() -> CGFloat {
		var y = lastY + CGFloat.random() * 10.0 - 5.0
		
		if y < 30 {
			y = 30
		}
		else if y > size.height - 130 {
			y = size.height - 130
		}
		
		return y
	}

	// Shifts the tunnel by a certain ammount on every tick
	func update() {
		lastY = nextPosition()
		tunnel.removeFirst()
		tunnel.shift(-INCREMENT, dy: 0.0)
		tunnel.add(size.width + INCREMENT, y: lastY)
		self.path = tunnel.getPath()
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