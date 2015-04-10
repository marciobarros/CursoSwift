//
//  GameScene.swift
//  MenuAcies
//
//  Created by Marcio Barros on 4/9/15.
//  Copyright (c) 2015 UNIRIO. All rights reserved.
//

import SpriteKit

//
// Cena principal do jogo
//
class GameScene: SKScene {
	var starship : SKSpriteNode!
	var lastMenuPosition = 0

	/*
	 * Cria os componentes do jogo
	 */
    override func didMoveToView(view: SKView) {
		createLabel("rotate_right")
		createLabel("rotate_left")
		createLabel("move_right")
		createLabel("move_left")
		createLabel("move_up")
		createLabel("move_down")
		createLabel("fade_out")
		createLabel("fade_in")
		createLabel("grow_x")
		createLabel("grow_y")
		createLabel("reduce_x")
		createLabel("reduce_y")
		createStarship()
    }
	
	/*
	 * Cria um item de menu do jogo
	 */
	func createLabel(title: String) {
        let myLabel = SKLabelNode(fontNamed: "AvenirNext")
        myLabel.text = title
		myLabel.name = title
        myLabel.fontSize = 20
		myLabel.verticalAlignmentMode = .Top
		myLabel.horizontalAlignmentMode = .Left
		
		let yPosition = self.frame.maxY - CGFloat(40 * lastMenuPosition)
        myLabel.position = CGPoint(x: self.frame.minX, y: yPosition)
		lastMenuPosition++;
		
		self.addChild(myLabel)
	}
	
	/*
	 * Cria a espaço-nave no centro da tela
	 */
	func createStarship() {
		starship = SKSpriteNode(imageNamed: "Spaceship")
		starship.position = CGPointMake(frame.midX, frame.midY)
		starship.anchorPoint = CGPointMake(0.5, 0.5)
		starship.xScale = 0.5
		starship.yScale = 0.5
		self.addChild(starship)
	}
	
	/*
	 * Identifica e executa os comandos
	 */
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            let touchLocation = touch.locationInNode(self)
			let touchedNode = self.nodeAtPoint(touchLocation)
			
			if let name = touchedNode.name {
				executeCommand(name)
			}
        }
    }
	
	/*
	 * Executa um comando sobre a espaço-nave
	 */
	func executeCommand(name: String) {
		switch name {
			case "rotate_right":
				starship.runAction(SKAction.rotateByAngle(CGFloat(M_PI_2), duration: 3.0))

			case "rotate_left":
				starship.runAction(SKAction.rotateByAngle(CGFloat(-M_PI_2), duration: 3.0))

			case "move_right":
				starship.runAction(SKAction.moveByX(50.0, y: 0.0, duration: 3.0))

			case "move_left":
				starship.runAction(SKAction.moveByX(-50.0, y: 0.0, duration: 3.0))

			case "move_up":
				starship.runAction(SKAction.moveByX(0.0, y: 25.0, duration: 3.0))

			case "move_down":
				starship.runAction(SKAction.moveByX(0.0, y: -25.0, duration: 3.0))

			case "fade_out":
				starship.runAction(SKAction.fadeAlphaBy(-0.25, duration: 3.0))

			case "fade_in":
				starship.runAction(SKAction.fadeAlphaBy(+0.25, duration: 3.0))

			case "grow_x":
				starship.runAction(SKAction.scaleXBy(1.5, y: 1.0, duration: 3.0))

			case "grow_y":
				starship.runAction(SKAction.scaleXBy(1.0, y: 1.5, duration: 3.0))

			case "reduce_x":
				starship.runAction(SKAction.scaleXBy(0.5, y: 1.0, duration: 3.0))

			case "reduce_y":
				starship.runAction(SKAction.scaleXBy(1.0, y: 0.5, duration: 3.0))
			
			default:
				break
		}
	}
}