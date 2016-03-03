import Foundation

var data : [Double] = []

for i in 0...100 {
	let π = M_PI
	let angle = Double(i) * π / 16.0
	let value = sin(angle)
	data.append(value)
}

data
