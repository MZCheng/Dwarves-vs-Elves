//
//  MapScene.swift
//  Dwarves-vs-Elves
//
//  Created by 程明卓 on 7/21/19.
//  Copyright © 2019 程明卓. All rights reserved.
//

import SpriteKit
import UIKit

class MapScene: SKScene{
    
    let iconReturn = SKShapeNode(rect: CGRect(origin: CGPoint(x: 100, y: playableRect.minY + 100), size: CGSize(width: 100, height: 100)))
    let labelReturn = SKLabelNode()
    var iconVillage = SKShapeNode()
    var iconCave = SKShapeNode()
    var iconForest = SKShapeNode()
    var gameScene: SKScene
    var reveal: SKTransition
    
    override init(size: CGSize) {
        gameScene = GameScene(size: size)
        reveal = SKTransition.fade(withDuration: 0.5)
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        shapUI()
        shapeResouse(gameScene: self)
    }
    
    func shapUI(){
        
        backgroundColor = SKColor.white
        
        labelReturn.position = CGPoint(x: 100, y: playableRect.minY + 300)
        labelReturn.text = "RETURN"
        labelReturn.fontSize = 100
        labelReturn.fontColor = SKColor.brown
        labelReturn.horizontalAlignmentMode = .left
        labelReturn.verticalAlignmentMode = .top
        addChild(labelReturn)
        
        iconReturn.zPosition = 10
        iconReturn.lineWidth = 4.0
        iconReturn.strokeColor = SKColor.black
        addChild(iconReturn)
        
        iconVillage = SKShapeNode(rect: CGRect(origin: CGPoint(x: 300, y: size.height/2), size: CGSize(width: 300, height: 200)))
        iconVillage.fillColor = SKColor.gray
        addChild(iconVillage)
        let villageLabel = SKLabelNode(text: "Visit the village")
        villageLabel.position = CGPoint(x:300, y: size.height/2 - 50)
        villageLabel.fontColor = SKColor.black
        villageLabel.fontSize = 50
        villageLabel.horizontalAlignmentMode = .left
        villageLabel.verticalAlignmentMode = .bottom
        villageLabel.zPosition = 100
        addChild(villageLabel)
        
        iconCave = SKShapeNode(rect: CGRect(origin: CGPoint(x: 900, y: size.height/2), size: CGSize(width: 300, height: 200)))
        iconCave.fillColor = SKColor.brown
        addChild(iconCave)
        let caveLabel = SKLabelNode(text: "Get stone from cave")
        caveLabel.position = CGPoint(x:900, y: size.height/2 - 50)
        caveLabel.fontColor = SKColor.black
        caveLabel.fontSize = 50
        caveLabel.horizontalAlignmentMode = .left
        caveLabel.verticalAlignmentMode = .bottom
        caveLabel.zPosition = 100
        addChild(caveLabel)
        
        iconForest = SKShapeNode(rect: CGRect(origin: CGPoint(x: 1500, y: size.height/2), size: CGSize(width: 300, height: 200)))
        iconForest.fillColor = SKColor.green
        addChild(iconForest)
        let forestLabel = SKLabelNode(text: "Get woods from forest")
        forestLabel.position = CGPoint(x:1500, y: size.height/2 - 50)
        forestLabel.fontColor = SKColor.black
        forestLabel.fontSize = 50
        forestLabel.horizontalAlignmentMode = .left
        forestLabel.verticalAlignmentMode = .bottom
        forestLabel.zPosition = 100
        addChild(forestLabel)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        let touchLocation = touch.location(in: self)
        
        if iconReturn.contains(touchLocation){
            removeAllChildren()
            gameScene.scaleMode = scaleMode
            view?.presentScene(gameScene, transition: reveal)
        }
        
        if iconVillage.contains(touchLocation){
            removeAllChildren()
            let nextScene = VillageScene(size:size)
            let nextReveal = SKTransition.fade(withDuration: 0.5)
            nextScene.scaleMode = scaleMode
            view?.presentScene(nextScene, transition: nextReveal)
        }
        
        if iconCave.contains(touchLocation){
            time += 1
            if time >= 4 {
                days += 1
                time = 1
                firstTask = getRandomTask(id: 1)
                secondTask = getRandomTask(id: 2)
                thirdTask = getRandomTask(id: 3)
            }
            stone += 100
            
            labelNumOfStone.text = "Stone: \(stone)"
            
            if time == 1 {
                labelTime.text = "Time: Morning"
            }else if time == 2 {
                labelTime.text = "Time: Afternoon"
            }else if time == 3 {
                labelTime.text = "Time: Evening"
            }
            labelDays.text = "Day: \(days)"
            
            //
            //            removeAllChildren()
            //            gameScene.scaleMode = scaleMode
            //            view?.presentScene(gameScene, transition: reveal)
        }
        
        if iconForest.contains(touchLocation){
            time += 1
            if time >= 4 {
                days += 1
                time = 1
                firstTask = getRandomTask(id: 1)
                secondTask = getRandomTask(id: 2)
                thirdTask = getRandomTask(id: 3)
            }
            woods += 100
            labelNumOfWoods.text = "Woods: \(woods)"
            
            if time == 1 {
                labelTime.text = "Time: Morning"
            }else if time == 2 {
                labelTime.text = "Time: Afternoon"
            }else if time == 3 {
                labelTime.text = "Time: Evening"
            }
            labelDays.text = "Day: \(days)"
            
            //
            //            removeAllChildren()
            //            gameScene.scaleMode = scaleMode
            //            view?.presentScene(gameScene, transition: reveal)
        }
    }
}
