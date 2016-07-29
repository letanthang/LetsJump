//
//  Scene2.swift
//  LetsJump
//
//  Created by Le Tan Thang on 6/27/16.
//  Copyright © 2016 Le Tan Thang. All rights reserved.
//

import SpriteKit

class Scene2: SKScene {
    
    var hero: SKSpriteNode!
    var heroAtlas: SKTextureAtlas!
    var runAtlas: SKTextureAtlas!
    var runs, attacks, idles, walks, jumps, slides, dies: [SKTexture]!
    let acts = ["Walk", "Run", "Jump","Attack", "Slide", "Die", "Idle"]
    
    var actIndex = 0
    
    var actionLabel: SKLabelNode!
    override func didMoveToView(view: SKView) {
        buildAtlasAndFrame()
        
        
        hero = SKSpriteNode(texture: runs.first!)
        hero.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        addChild(hero)
        
        walk()
        
        
        
        
        self.actionLabel = SKLabelNode(fontNamed: "Chalkduster")
        actionLabel.zPosition = 10
        actionLabel.name = "actionLabel"
        actionLabel.text = "Walk"
        actionLabel.fontColor = SKColor.redColor()
        actionLabel.position = CGPoint(x: CGRectGetMidX(self.frame), y: 5)
        addChild(actionLabel)
        
        addGestureReg()
    }
    
    func buildAtlasAndFrame() {
        heroAtlas = SKTextureAtlas(named: "hero")
        
        runAtlas = SKTextureAtlas(named: "run")
        
        runs = [SKTexture]()
        for i in 1...runAtlas.textureNames.count {
            runs.append(runAtlas.textureNamed("\(i-1)"))
        }
        
        idles = [SKTexture]()
        for i in 1...10 {
            let name = String(format: "run_%02d", i-1)
            
            idles.append(heroAtlas.textureNamed(name))
        }
        
        walks = [SKTexture]()
        for i in 1...10 {
            let name = String(format: "walk_%02d", i-1)
            
            walks.append(heroAtlas.textureNamed(name))
        }
        
        slides = [SKTexture]()
        for i in 1...10 {
            let name = String(format: "slide_%02d", i-1)
            
            slides.append(heroAtlas.textureNamed(name))
        }
        
        jumps = [SKTexture]()
        for i in 1...10 {
            let name = String(format: "jump_%02d", i-1)
            
            jumps.append(heroAtlas.textureNamed(name))
        }
        
        dies = [SKTexture]()
        for i in 1...10 {
            let name = String(format: "death_%02d", i-1)
            
            dies.append(heroAtlas.textureNamed(name))
        }
        
        attacks = [SKTexture]()
        for i in 1...10 {
            let name = String(format: "attack_%02d", i-1)
            
            attacks.append(heroAtlas.textureNamed(name))
        }
    }
    
    func addGestureReg() {
        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(Scene2.changeAction))
        gesture.direction = .Left
        view!.addGestureRecognizer(gesture)
        
        let gestureRight = UISwipeGestureRecognizer(target: self, action: #selector(Scene2.changeAction))
        gestureRight.direction = .Right
        view!.addGestureRecognizer(gestureRight)
        
        let gestureUp = UISwipeGestureRecognizer(target: self, action: #selector(Scene2.changeScene))
        gestureUp.direction = .Up
        view!.addGestureRecognizer(gestureUp)
        
        let gestureDown = UISwipeGestureRecognizer(target: self, action: #selector(Scene2.changeScene))
        gestureDown.direction = .Down
        view!.addGestureRecognizer(gestureDown)
    }
    
    func changeScene() {
        let scene1 = GameScene(size: self.size)
        view?.presentScene(scene1)
    }
    
    func idleHero() {
        hero.removeAllActions()
        hero.texture = idles.first!
        //hero.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(idles, timePerFrame: 0.12, resize: true, restore: true)))
        hero.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(idles, timePerFrame: 0.12)))
        print("idle")
    }
    
    
    
    func swipeDown(gesture: UISwipeGestureRecognizer) {
        let scene2 = Scene2(size: self.size)
        view?.presentScene(scene2)
    }
    func walk() {
        hero.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(walks, timePerFrame: 0.1)))
    }
    
    func idle() {
        hero.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(idles, timePerFrame: 0.1)))
    }
    func run() {
        hero.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(runs, timePerFrame: 0.1)))
    }
    func jump() {
        hero.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(jumps, timePerFrame: 0.1)))
    }
    func slide() {
        hero.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(slides, timePerFrame: 0.1)))
    }
    func attack() {
        hero.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(attacks, timePerFrame: 0.1)))
    }
    func die() {
        hero.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(dies, timePerFrame: 0.1)))
    }
    
    
    
    func changeAction() {
        
        let node = actionLabel
        actIndex += 1
        actIndex = actIndex % acts.count
        
        let act = acts[actIndex]
        node.text = acts[actIndex]
        hero.removeAllActions()
        
        if act == "Walk" {
            walk()
        } else if act == "Idle" {
            idle()
        } else if act == "Run" {
            run()
        } else if act == "Jump" {
            jump()
        } else if act == "Slide" {
            slide()
        } else if act == "Die" {
            die()
        } else if act == "Attack" {
            attack()
        }

        
        
        
        
        
            
        
        
    }
    
}
