//
//  GameScene.swift
//  LetsJump
//
//  Created by Le Tan Thang on 6/22/16.
//  Copyright (c) 2016 Le Tan Thang. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var jack: SKSpriteNode!
    var actionLabel: SKLabelNode!
    var walkAtlas: SKTextureAtlas!
    
    var jackAtlas: SKTextureAtlas!
    var walks, idles, runs, jumps, slides, dies: [SKTexture]!
    
    let acts = ["Walk", "Run", "Jump", "Slide", "Die", "Idle"]
    
    var actIndex = 0
    override func didMoveToView(view: SKView) {
        
        let bg = SKSpriteNode(imageNamed: "bg-1024x768.jpg")
        bg.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        bg.zPosition = -1
        addChild(bg)
        
        jackAtlas = SKTextureAtlas(named: "jack")
        walkAtlas = SKTextureAtlas(named: "jack_walk")
        
        walks = [SKTexture]()
        for i in 1...walkAtlas.textureNames.count {
            let textureName = "Walk(\(i))"
            walks.append(walkAtlas.textureNamed(textureName))
            
        }
        
        
        idles = [SKTexture]()
        for i in 1...10 {
            let textureName = "Idle(\(i))"
            //print(textureName)
            //print(jackAtlas.textureNamed(textureName))
            self.idles.append(jackAtlas.textureNamed(textureName))
        }

        runs = [SKTexture]()
        for i in 1...8 {
            let textureName = "Run(\(i))"
            //print(textureName)
            //print(jackAtlas.textureNamed(textureName))
            self.runs.append(jackAtlas.textureNamed(textureName))
        }

        jumps = [SKTexture]()
        for i in 1...10 {
            let textureName = "Jump(\(i))"
            //print(textureName)
            //print(jackAtlas.textureNamed(textureName))
            self.jumps.append(jackAtlas.textureNamed(textureName))
        }

        slides = [SKTexture]()
        for i in 1...10 {
            let textureName = "Slide(\(i))"
            //print(textureName)
            //print(jackAtlas.textureNamed(textureName))
            self.slides.append(jackAtlas.textureNamed(textureName))
        }
        
        dies = [SKTexture]()
        for i in 1...10 {
            let textureName = "Dead(\(i))"
            //print(textureName)
            //print(jackAtlas.textureNamed(textureName))
            self.dies.append(jackAtlas.textureNamed(textureName))
        }

        
        
        
        
        jack = SKSpriteNode(texture: walks[0])
        jack.zPosition = 10
        jack.xScale = 0.25
        jack.yScale = 0.25
        jack.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        
        addChild(jack)
        
        idleJack()
        
        
        self.actionLabel = SKLabelNode(fontNamed: "Chalkduster")
        actionLabel.zPosition = 10
        actionLabel.name = "actionLabel"
        actionLabel.text = "Walk"
        actionLabel.fontColor = SKColor.redColor()
        actionLabel.position = CGPoint(x: CGRectGetMidX(self.frame), y: 5)
        addChild(actionLabel)
        
        addGestureReg()
        
    }
    
    func addGestureReg() {
        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(GameScene.swipeDown))
        gesture.direction = .Up
        view?.addGestureRecognizer(gesture)
        
        let gestureLeft = UISwipeGestureRecognizer(target: self, action: #selector(GameScene.swipeLeft))
        gestureLeft.direction = .Left
        view?.addGestureRecognizer(gestureLeft)
        
        let gestureRight = UISwipeGestureRecognizer(target: self, action: #selector(GameScene.swipeLeft))
        gestureRight.direction = .Right
        view?.addGestureRecognizer(gestureRight)
        
        let gestureDown = UISwipeGestureRecognizer(target: self, action: #selector(GameScene.swipeDown))
        gestureDown.direction = .Down
        view?.addGestureRecognizer(gestureDown)

    }
    
    
    
    func swipeLeft(gesture: UISwipeGestureRecognizer){
        print(gesture.direction)
        changeAction(actionLabel)
    }
    
    func swipeDown(gesture: UISwipeGestureRecognizer) {
        let scene2 = Scene2(size: self.size)
        view?.presentScene(scene2)
    }
    func walkJack() {
        jack.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(walks, timePerFrame: 0.1)))
    }
    
    func idleJack() {
        jack.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(idles, timePerFrame: 0.1)))
    }
    func runJack() {
        jack.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(runs, timePerFrame: 0.1)))
    }
    func jumpJack() {
        jack.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(jumps, timePerFrame: 0.1)))
    }
    func slideJack() {
        jack.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(slides, timePerFrame: 0.1)))
    }
    func dieJack() {
        jack.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(dies, timePerFrame: 0.1)))
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first!
        for node in nodesAtPoint(touch.locationInNode(self)) {
            
            if let name = node.name where name == "actionLabel" {
                
                changeAction(node as! SKLabelNode)
            }
        }
    
        
    }
    func changeAction(node: SKLabelNode) {
        
        if let act = node.text {
            
            jack.removeAllActions()
            
            if act == "Walk" {
                walkJack()
            } else if act == "Idle" {
                idleJack()
            } else if act == "Run" {
                runJack()
            } else if act == "Jump" {
                jumpJack()
            } else if act == "Slide" {
                slideJack()
            } else if act == "Die" {
                dieJack()
            }
            
            actIndex += 1
            
            actIndex = actIndex % acts.count
            
            node.text = acts[actIndex]
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
