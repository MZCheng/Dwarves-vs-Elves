//
//  MakeSystem.swift
//  Dwarves-vs-Elves
//
//  Created by 程明卓 on 7/21/19.
//  Copyright © 2019 程明卓. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit

class MakeSystem: SKScene {
    let iconReturn = SKShapeNode(rect: CGRect(x: 50, y: playableRect.minY+10, width: 100, height: 100))
    let labelReturn = SKLabelNode(text: "RETURN")
    var gameScene: SKScene
    var reveal: SKTransition
    var labelItems:[SKLabelNode] = []
    var labelItemToMake:[SKLabelNode] = []
    var iconMakeShowed = false
    var boxItemMadeShowed = false
    var boxItemMade = SKShapeNode()
    var itemToMake = 0
    
    override init(size: CGSize) {
        gameScene = GameScene(size: size)
        reveal = SKTransition.fade(withDuration: 0.5)
        for _ in 0...3{
            labelItemToMake.append(SKLabelNode())
        }
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        gameScene.scaleMode = scaleMode
        shapeUI()
        shapeResourse()
        showRecipe()
    }
    
    func shapeUI(){
        iconReturn.zPosition = 100
        iconReturn.strokeColor = SKColor.black
        iconReturn.lineWidth = 4.0
        addChild(iconReturn)
        
        labelReturn.position = CGPoint(x: 50, y: playableRect.minY+220)
        labelReturn.fontColor = SKColor.brown
        labelReturn.fontSize = 100
        labelReturn.horizontalAlignmentMode = .left
        labelReturn.verticalAlignmentMode = .top
        addChild(labelReturn)
        
        let rectItemBox = CGRect(x: 10, y: playableRect.minY+300, width: playableRect.width/2-20, height: playableRect.height-350)
        let pathItemBox = CGMutablePath()
        pathItemBox.addRect(rectItemBox)
        let itemBox = SKShapeNode(path: pathItemBox)
        itemBox.strokeColor = SKColor.black
        itemBox.lineWidth = 4.0
        itemBox.zPosition = 10
        addChild(itemBox)
        
        let rectMakeBox = CGRect(x: playableRect.width/2 + 20, y: playableRect.minY + 300, width: playableRect.width/2 - 20, height: playableRect.height - 350)
        let pathMakeBox = CGMutablePath()
        pathMakeBox.addRect(rectMakeBox)
        let makeBox = SKShapeNode(path: pathMakeBox)
        makeBox.strokeColor = SKColor.black
        makeBox.lineWidth = 4.0
        makeBox.zPosition = 10
        addChild(makeBox)
    }
    
    func shapeResourse(){
        labelDays.position = CGPoint(x: 450, y: playableRect.minY + 250)
        labelDays.fontColor = SKColor.red
        labelDays.text = "Day: \(days)"
        labelDays.fontSize = 100
        labelDays.horizontalAlignmentMode = .left
        labelDays.verticalAlignmentMode = .top
        labelDays.zPosition = 100
        addChild(labelDays)
        
        labelTime.position = CGPoint(x: 900, y: playableRect.minY + 250)
        labelTime.fontColor = SKColor.red
        if time == 1 {
            labelTime.text = "Time: Morning"
        }else if time == 2 {
            labelTime.text = "Time: Afternoon"
        }else if time == 3 {
            labelTime.text = "Time: Evening"
        }
        labelTime.fontSize = 100
        labelTime.horizontalAlignmentMode = .left
        labelTime.verticalAlignmentMode = .top
        labelTime.zPosition = 100
        addChild(labelTime)
        
        labelNumOfMoney.position = CGPoint(x: 450, y: playableRect.minY + 100)
        labelNumOfMoney.fontColor = SKColor.red
        labelNumOfMoney.text = "Coins: \(coins)"
        labelNumOfMoney.fontSize = 100
        labelNumOfMoney.horizontalAlignmentMode = .left
        labelNumOfMoney.verticalAlignmentMode = .top
        labelNumOfMoney.zPosition = 100
        addChild(labelNumOfMoney)
        
        labelNumOfStone.position = CGPoint(x: 900, y: playableRect.minY +  100)
        labelNumOfStone.fontColor = SKColor.red
        labelNumOfStone.text = "Stone: \(stone)"
        labelNumOfStone.fontSize = 100
        labelNumOfStone.horizontalAlignmentMode = .left
        labelNumOfStone.verticalAlignmentMode = .top
        labelNumOfStone.zPosition = 100
        addChild(labelNumOfStone)
        
        labelNumOfWoods.position = CGPoint(x: 1350, y: playableRect.minY + 100)
        labelNumOfWoods.fontColor = SKColor.red
        labelNumOfWoods.text = "Woods: \(woods)"
        labelNumOfWoods.fontSize = 100
        labelNumOfWoods.horizontalAlignmentMode = .left
        labelNumOfWoods.verticalAlignmentMode = .top
        labelNumOfWoods.zPosition = 100
        addChild(labelNumOfWoods)
    }
    
    func showRecipe(){
        for recipeNum in 0...(recipesYouHave.count-1){
            labelItems.append(SKLabelNode(text: recipesYouHave[recipeNum].name))
            labelItems[recipeNum].position = CGPoint(x: 50, y: playableRect.maxY - CGFloat(recipeNum+1)*100)
            labelItems[recipeNum].fontColor = SKColor.red
            labelItems[recipeNum].fontSize = 100
            labelItems[recipeNum].zPosition = 20
            labelItems[recipeNum].verticalAlignmentMode = .top
            labelItems[recipeNum].horizontalAlignmentMode = .left
            addChild(labelItems[recipeNum])
        }
    }
    
    func showMake(){
        // 0 is the name for the item
        labelItemToMake[0] = SKLabelNode(text: recipesYouHave[itemToMake].name)
        labelItemToMake[0].position = CGPoint(x: playableRect.width*3.0/4.0, y: playableRect.maxY - 200)
        labelItemToMake[0].fontSize = 100
        labelItemToMake[0].zPosition = 20
        labelItemToMake[0].fontColor = .red
        labelItemToMake[0].horizontalAlignmentMode = .center
        labelItemToMake[0].verticalAlignmentMode = .center
        addChild(labelItemToMake[0])
        
        //1 is the recipe for the item
        labelItemToMake[1] = SKLabelNode(text: recipesYouHave[itemToMake].recipe)
        labelItemToMake[1].position = CGPoint(x: playableRect.width*3.0/4.0, y: playableRect.maxY - 400)
        labelItemToMake[1].fontSize = 50
        labelItemToMake[1].zPosition = 20
        labelItemToMake[1].fontColor = .red
        labelItemToMake[1].horizontalAlignmentMode = .center
        labelItemToMake[1].verticalAlignmentMode = .center
        addChild(labelItemToMake[1])
        
        //2 is the iconMake for the item
        iconMakeShowed = true
        labelItemToMake[2] = SKLabelNode(text: "Make it!")
        labelItemToMake[2].position = CGPoint(x: playableRect.width*3.0/4.0, y: playableRect.maxY - 600)
        labelItemToMake[2].fontSize = 100
        labelItemToMake[2].zPosition = 20
        labelItemToMake[2].fontColor = .red
        labelItemToMake[2].horizontalAlignmentMode = .center
        labelItemToMake[2].verticalAlignmentMode = .center
        addChild(labelItemToMake[2])
    }
    
    func itemMake(itemNum:Int){
        let isSucceed = isItemMade(id: itemNum)
        
        let pathItemMade = CGMutablePath()
        pathItemMade.addRect(CGRect(x: playableRect.width/2 - 900, y: playableRect.minY + playableRect.height/2 - 200, width: 1800, height: 400))
        boxItemMade.path = pathItemMade
        boxItemMade.fillColor = .white
        boxItemMade.strokeColor = .black
        boxItemMade.lineWidth = 4.0
        boxItemMade.zPosition = 30
        boxItemMadeShowed = true
        addChild(boxItemMade)
        
        if isSucceed{
            labelItemToMake[3] = SKLabelNode(text: "Congratulation! You get a \(recipesYouHave[itemToMake].name)!")
            labelItemToMake[3].position = CGPoint(x: playableRect.width/2, y: playableRect.minY + playableRect.height/2)
            labelItemToMake[3].fontSize = 100
            labelItemToMake[3].zPosition = 40
            labelItemToMake[3].fontColor = .red
            labelItemToMake[3].horizontalAlignmentMode = .center
            labelItemToMake[3].verticalAlignmentMode = .center
            addChild(labelItemToMake[3])
            labelDays.text = "Day: \(days)"
            if time == 1 {
                labelTime.text = "Time: Morning"
            }else if time == 2 {
                labelTime.text = "Time: Afternoon"
            }else if time == 3 {
                labelTime.text = "Time: Evening"
            }
            labelNumOfMoney.text = "Coins: \(coins)"
            labelNumOfStone.text = "Stone: \(stone)"
            labelNumOfWoods.text = "Woods: \(woods)"
            isTaskDone()
        }else{
            labelItemToMake[3] = SKLabelNode(text: "Sorry, you do not have enough resourses")
            labelItemToMake[3].position = CGPoint(x: playableRect.width/2, y: playableRect.minY + playableRect.height/2)
            labelItemToMake[3].fontSize = 100
            labelItemToMake[3].zPosition = 40
            labelItemToMake[3].fontColor = .red
            labelItemToMake[3].horizontalAlignmentMode = .center
            labelItemToMake[3].verticalAlignmentMode = .center
            addChild(labelItemToMake[3])
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let touchPosition = touch.location(in: self)
        if boxItemMadeShowed{
            boxItemMade.removeFromParent()
            labelItemToMake[3].removeFromParent()
            boxItemMadeShowed = false
        }else{
            if iconReturn.contains(touchPosition){
                removeAllChildren()
                view?.presentScene(gameScene, transition: reveal)
            }
            
            for itemNum in 0...(labelItems.count-1){
                if labelItems[itemNum].contains(touchPosition){
                    for i in 0...(labelItemToMake.count-1){
                        labelItemToMake[i].removeFromParent()
                    }
                    itemToMake = itemNum
                    showMake()
                }
            }
            if iconMakeShowed{
                if labelItemToMake[2].contains(touchPosition){
                    itemMake(itemNum:itemToMake)
                }
            }
        }
    }
    
    
}
