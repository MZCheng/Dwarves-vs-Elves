//
//  MainMenuScene.swift
//  Dwarves-vs-Elves
//
//  Created by 程明卓 on 7/21/19.
//  Copyright © 2019 程明卓. All rights reserved.
//

import Foundation
import SpriteKit

class MainMenuScene: SKScene{
    let labelStart = SKLabelNode(text: "PLAY")
    
    override func didMove(to view: SKView) {
        
        let labelMenu = SKLabelNode(text: "Dwarves VS Elves")
        labelMenu.position = CGPoint(x: size.width/2, y: size.height/2)
        labelMenu.fontColor = SKColor.red
        labelMenu.fontSize = 200
        labelMenu.zPosition = 10
        addChild(labelMenu)
        
        labelStart.position = CGPoint(x: size.width/2, y: size.height/3)
        labelStart.fontColor = .red
        labelStart.fontSize = 150
        labelStart.zPosition = 10
        labelStart.color = .white
        addChild(labelStart)
        
        gotRecipe(weapon: basicSword)
        gotRecipe(weapon: basicArmor)
        gotRecipe(weapon: basicShield)
        goods.append(good0)
        goods.append(good1)
        goods.append(good2)
        goods.append(good3)
        goods.append(good4)
        goods.append(good5)
        
        let background = SKSpriteNode()
        background.position = CGPoint(x: size.width/2, y: size.height/2)
        backgroundColor = SKColor.gray
        addChild(background)
    }
    
    func sceneTapped(){
        let myscene = GameScene(size: size)
        myscene.scaleMode = scaleMode
        let reveal = SKTransition.fade(withDuration: 0.5)
        removeAllChildren()
        view?.presentScene(myscene, transition: reveal)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return  }
        
        let touchLocation = touch.location(in: self)
        
        if labelStart.contains(touchLocation){
            sceneTapped()
        }
    }
    
}
