//
//  Region.swift
//  Seaquest
//
//  Created by Marcio Barros on 1/13/15.
//  Copyright (c) 2015 UNIRIO. All rights reserved.
//

import Foundation
import SpriteKit

class Region {
	var minX: CGFloat!
	var minY: CGFloat!
	var maxX: CGFloat!
	var maxY: CGFloat!
	
	init(minX: CGFloat, minY: CGFloat, maxX: CGFloat, maxY: CGFloat) {
		self.minX = minX
		self.minY = minY
		self.maxX = maxX
		self.maxY = maxY
	}
}