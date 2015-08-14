//
//  GameViewController.swift
//  Test
//
//  Created by Dennis Möller on 11/08/15.
//  Copyright (c) 2015 Dennis Möller. All rights reserved.
//

import UIKit
import SpriteKit

extension SKNode {
    class func unarchiveFromFile(file : String) -> SKNode? {
        if let path = NSBundle.mainBundle().pathForResource(file, ofType: "sks") {
            var sceneData = NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe, error: nil)!
            var archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
            
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as! GameScene
            archiver.finishDecoding()
            return scene
        } else {
            return nil
        }
    }
}

class GameViewController: UIViewController, SceneTransitionDelegate {

    var skView:SKView { return view as! SKView }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //load first scene (e.g. MainMenu)
        transitionToScene(MainMenuScene.self)
    }
    
    //SceneTransitionDelegate method
    func transitionToScene(sceneClass:Scene.Type) {
        let scene = sceneClass(size: skView.bounds.size)
        scene.scaleMode = .AspectFill
        scene.sceneDelegate = self
        skView.presentScene(scene)
    }
    
    func transitionToScene(sceneClass: Scene.Type, transitionAnimation: SKTransition) {
        let scene = sceneClass(size: skView.bounds.size)
        scene.scaleMode = .AspectFill
        scene.sceneDelegate = self
        skView.presentScene(scene, transition: transitionAnimation)
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
