//
//  Path.swift
//  PGP
//
//  Created by Marcio Barros on 1/23/15.
//  Copyright (c) 2015 UNIRIO. All rights reserved.
//

import SpriteKit

class Path {
	var points : [Point] = []
	
	init() {
	}
	
	func add(p: Point) {
		points += [p]
	}
	
	func add(x: CGFloat, y: CGFloat) {
		points += [Point(x: x, y: y)]
	}
	
	func removeFirst() {
		points.removeAtIndex(0)
	}
	
	func shift(dx: CGFloat, dy: CGFloat) {
		for point in points {
			point.x += dx
			point.y += dy
		}
	}
	
	func getMutablePath() -> CGMutablePathRef {
		var path = CGPathCreateMutable()
		CGPathMoveToPoint(path, nil, points[0].x, points[0].y)
		
		for (var i = 1; i < points.count; i++) {
			CGPathAddLineToPoint(path, nil, points[i].x, points[i].y)
		}
		
		return path
	}
}