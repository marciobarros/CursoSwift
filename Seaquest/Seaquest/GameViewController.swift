//
//  GameViewController.swift
//  Seaquest
//
//  Created by Marcio Barros on 11/26/14.
//  Copyright (c) 2014 UNIRIO. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
		
		// Configure the view to optimize rendering
		let skView = self.view as SKView
		skView.showsFPS = false
		skView.showsNodeCount = false
		skView.ignoresSiblingOrder = true
		
		// Set the scale mode to scale to fit the window
		let scene = GameScene()
		scene.size = skView.bounds.size
		scene.scaleMode = .AspectFill
		skView.presentScene(scene)
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> Int {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return Int(UIInterfaceOrientationMask.AllButUpsideDown.rawValue)
        } else {
            return Int(UIInterfaceOrientationMask.All.rawValue)
        }
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
