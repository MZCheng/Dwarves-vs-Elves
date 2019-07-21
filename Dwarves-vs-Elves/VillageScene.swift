//
//  VillageScene.swift
//  Dwarves-vs-Elves
//
//  Created by 程明卓 on 7/21/19.
//  Copyright © 2019 程明卓. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit

class VillageScene: SKScene{
    
    let iconReturn = SKShapeNode()
    var gameScene: SKScene
    var reveal: SKTransition
    var taskBoardShowed = false
    var smithyShowed = false
    var villageHeadShowed = false
    var iconTaskBoard = SKShapeNode()
    var iconSmithy = SKShapeNode()
    var iconVillageHead = SKShapeNode()
    var taskBoard = SKShapeNode()
    var boxFirstTask = SKShapeNode()
    var boxSecondTask = SKShapeNode()
    var boxThirdTask = SKShapeNode()
    var smithy = SKShapeNode()
    var villageHead = SKShapeNode()
    var boxesGood: [SKShapeNode] = []
    let itemBox = SKShapeNode(rect: CGRect(x: 400, y: playableRect.minY + 50, width: playableRect.width - 800, height: playableRect.height - 100))
    var itemBoxShowed = false
    var boxesForItem: [SKShapeNode] = []
    var goodSelected = 0
    
    
    
    
    override init(size: CGSize) {
        gameScene = MapScene(size: size)
        reveal = SKTransition.fade(withDuration: 0.5)
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        shapeUI()
        shapeResouse(gameScene: self)
    }
    
    func shapeUI(){
        backgroundColor = .white
        let pathReturn = CGMutablePath()
        pathReturn.addRect(CGRect(x: 50, y: playableRect.minY + 50, width: 100, height: 100))
        iconReturn.path = pathReturn
        iconReturn.strokeColor = .black
        iconReturn.zPosition = 100
        iconReturn.lineWidth = 4.0
        addChild(iconReturn)
        
        let labelReturn = SKLabelNode(text: "Back Map")
        labelReturn.position = CGPoint(x: 50, y: playableRect.minY + 150)
        labelReturn.zPosition = 100
        labelReturn.fontSize = 100
        labelReturn.fontColor = SKColor.brown
        labelReturn.horizontalAlignmentMode = .left
        labelReturn.verticalAlignmentMode = .bottom
        addChild(labelReturn)
        
        let labelTaskBoard = SKLabelNode(text: """
                                                       Task Board
                                               Find Some Tasks to do~
                                               """)
        labelTaskBoard.lineBreakMode = .byClipping
        labelTaskBoard.numberOfLines = 0
        labelTaskBoard.position = CGPoint(x: 600, y: 1100)
        labelTaskBoard.zPosition = 110
        labelTaskBoard.horizontalAlignmentMode = .left
        labelTaskBoard.verticalAlignmentMode = .bottom
        labelTaskBoard.fontSize = 60
        labelTaskBoard.fontColor = .black
        addChild(labelTaskBoard)
        
        iconTaskBoard = SKShapeNode(rect: labelTaskBoard.frame)
        iconTaskBoard.zPosition = 100
        iconTaskBoard.strokeColor = .black
        iconTaskBoard.lineWidth = 4.0
        addChild(iconTaskBoard)
        
        let labelSmithy = SKLabelNode(text: """
                                                     Smithy's Smithy
                                            Sold weapon and armor here
                                            """)
        labelSmithy.lineBreakMode = .byClipping
        labelSmithy.numberOfLines = 0
        labelSmithy.position = CGPoint(x: 600, y: 800)
        labelSmithy.zPosition = 110
        labelSmithy.horizontalAlignmentMode = .left
        labelSmithy.verticalAlignmentMode = .bottom
        labelSmithy.fontSize = 60
        labelSmithy.fontColor = .black
        addChild(labelSmithy)
        
        iconSmithy = SKShapeNode(rect: labelSmithy.frame)
        iconSmithy.zPosition = 100
        iconSmithy.strokeColor = .black
        iconSmithy.lineWidth = 4.0
        addChild(iconSmithy)
        
        let labelVillageHead = SKLabelNode(text: """
                                                        Village Head's house
                                                 He would tell you some news
                                                 """)
        labelVillageHead.lineBreakMode = .byClipping
        labelVillageHead.numberOfLines = 0
        labelVillageHead.position = CGPoint(x: 600, y: 500)
        labelVillageHead.zPosition = 110
        labelVillageHead.horizontalAlignmentMode = .left
        labelVillageHead.verticalAlignmentMode = .bottom
        labelVillageHead.fontSize = 60
        labelVillageHead.fontColor = .black
        addChild(labelVillageHead)
        
        iconVillageHead = SKShapeNode(rect: labelVillageHead.frame)
        iconVillageHead.zPosition = 100
        iconVillageHead.strokeColor = .black
        iconVillageHead.lineWidth = 4.0
        addChild(iconVillageHead)
    }
    
    func showTaskBoard(){
        taskBoard = SKShapeNode(rect: CGRect(x: 600, y: playableRect.minY+100, width: 1400, height: playableRect.height-200))
        taskBoard.zPosition = 120
        taskBoard.strokeColor = .black
        taskBoard.fillColor = .white
        taskBoard.lineWidth = 4.0
        addChild(taskBoard)
        
        let pathFirstTask = CGMutablePath()
        pathFirstTask.addRect(CGRect(x: 700, y:playableRect.maxY - 400, width: 1200, height: 200))
        boxFirstTask.path = pathFirstTask
        boxFirstTask.strokeColor = .black
        boxFirstTask.lineWidth = 4.0
        boxFirstTask.zPosition = taskBoard.zPosition + 10
        if firstTask.isTaken == false{
            boxFirstTask.fillColor = .blue
        }else{
            boxFirstTask.fillColor = .red
        }
        taskBoard.addChild(boxFirstTask)
        
        let labelFirstTask = SKLabelNode(text: """
            \(firstTask.needDescribe)
            \(firstTask.rewardDescribe)
            """)
        labelFirstTask.lineBreakMode = .byClipping
        labelFirstTask.numberOfLines = 0
        labelFirstTask.position = CGPoint(x: 700, y: playableRect.maxY - 350)
        labelFirstTask.zPosition = boxFirstTask.zPosition + 10
        labelFirstTask.horizontalAlignmentMode = .left
        labelFirstTask.verticalAlignmentMode = .bottom
        labelFirstTask.fontSize = 60
        labelFirstTask.fontColor = .yellow
        boxFirstTask.addChild(labelFirstTask)
        
        let pathSecondTask = CGMutablePath()
        pathSecondTask.addRect(CGRect(x: 700, y: playableRect.maxY - 700, width: 1200, height: 200))
        boxSecondTask.path = pathSecondTask
        boxSecondTask.strokeColor = .black
        boxSecondTask.lineWidth = 4.0
        boxSecondTask.zPosition = taskBoard.zPosition + 10
        if secondTask.isTaken == false{
            boxSecondTask.fillColor = .blue
        }else{
            boxSecondTask.fillColor = .red
        }
        taskBoard.addChild(boxSecondTask)
        
        let labelSecondTask = SKLabelNode(text: """
            \(secondTask.needDescribe)
            \(secondTask.rewardDescribe)
            """)
        labelSecondTask.lineBreakMode = .byClipping
        labelSecondTask.numberOfLines = 0
        labelSecondTask.position = CGPoint(x: 700, y: playableRect.maxY - 650)
        labelSecondTask.zPosition = boxSecondTask.zPosition + 10
        labelSecondTask.horizontalAlignmentMode = .left
        labelSecondTask.verticalAlignmentMode = .bottom
        labelSecondTask.fontSize = 60
        labelSecondTask.fontColor = .yellow
        boxFirstTask.addChild(labelSecondTask)
        
        let pathThirdTask = CGMutablePath()
        pathThirdTask.addRect(CGRect(x: 700, y: playableRect.maxY - 1000, width: 1200, height: 200))
        boxThirdTask.path = pathThirdTask
        boxThirdTask.strokeColor = .black
        boxThirdTask.lineWidth = 4.0
        boxThirdTask.zPosition = taskBoard.zPosition + 10
        if thirdTask.isTaken == false{
            boxThirdTask.fillColor = .blue
        }else{
            boxThirdTask.fillColor = .red
        }
        taskBoard.addChild(boxThirdTask)
        
        let labelThirdTask = SKLabelNode()
        labelThirdTask.text = """
        \(thirdTask.needDescribe)
        \(thirdTask.rewardDescribe)
        """
        labelThirdTask.lineBreakMode = .byClipping
        labelThirdTask.numberOfLines = 0
        labelThirdTask.zPosition = boxSecondTask.zPosition + 10
        labelThirdTask.horizontalAlignmentMode = .left
        labelThirdTask.verticalAlignmentMode = .bottom
        labelThirdTask.fontSize = 60
        labelThirdTask.fontColor = .yellow
        labelThirdTask.position = CGPoint(x: 700, y: playableRect.maxY - 950)
        taskBoard.addChild(labelThirdTask)
    }
    
    func taskTouched(task: ItemTask, box: SKShapeNode){
        if task.isTaken == true{
            let labelWanning = SKLabelNode(text: "Task has got!")
            labelWanning.position = CGPoint(x: playableRect.width/2, y: playableRect.minY + playableRect.height/2)
            labelWanning.zPosition = box.zPosition + 100
            labelWanning.verticalAlignmentMode = .center
            labelWanning.horizontalAlignmentMode = .center
            labelWanning.fontColor = .black
            labelWanning.fontSize = 100
            box.addChild(labelWanning)
            labelWanning.run(labelAction)
        }else{
            task.isTaken = true
            box.fillColor = .red
            addTask(task: task)
            print("\(task.needDescribe)")
            let labelWanning = SKLabelNode(text: "You pick the task!")
            labelWanning.position = CGPoint(x: playableRect.width/2, y: playableRect.minY + playableRect.height/2)
            labelWanning.zPosition = box.zPosition + 100
            labelWanning.verticalAlignmentMode = .center
            labelWanning.horizontalAlignmentMode = .center
            labelWanning.fontColor = .black
            labelWanning.fontSize = 100
            box.addChild(labelWanning)
            let labelAction  = SKAction.fadeOut(withDuration: 1)
            labelWanning.run(labelAction)
        }
    }
    
    func showSmithy(){
        smithy = SKShapeNode(rect: CGRect(x: 600, y: playableRect.minY+100, width: 1400, height: playableRect.height-200))
        smithy.zPosition = 120
        smithy.strokeColor = .black
        smithy.fillColor = .white
        smithy.lineWidth = 4.0
        addChild(smithy)
        boxesGood = []
        for i in 0...5{
            let boxGood = SKShapeNode(rect: CGRect(
                x: 750 + CGFloat(i % 3) * 400,
                y: playableRect.minY + playableRect.height - CGFloat(Int(i / 3) + 1) * 450,
                width: 300, height: 300))
            boxesGood.append(boxGood)
            boxGood.lineWidth = 4.0
            boxGood.strokeColor = .black
            boxGood.zPosition = smithy.zPosition + 10
            if goods[i].isContained{
                if goods[i].weaponId == 0{
                    boxGood.fillColor = .yellow
                }else if goods[i].weaponId == 1{
                    boxGood.fillColor = .red
                }else{
                    boxGood.fillColor = .blue
                }
            }else{
                boxGood.fillColor = .gray
            }
            smithy.addChild(boxGood)
        }
    }
    
    func goodsTouched(){
        var numToShow = 0
        var numOfLines = 0
        var numOfRows = 0
        boxesForItem = []
        for weaponToSold in recipesYouHave{
            if weaponToSold.numOfWeapon != 0 {
                let boxForItem = SKShapeNode(rect: CGRect(
                    x: CGFloat(500 + 400 * numOfRows),
                    y: playableRect.minY + playableRect.height - 500 - CGFloat(400 * numOfLines),
                    width: 300, height: 300))
                boxForItem.zPosition = itemBox.zPosition + 10
                boxForItem.lineWidth = 4.0
                boxForItem.strokeColor = .black
                if weaponToSold.isSelected{
                    boxForItem.fillColor = .gray
                }else if weaponToSold.id == 0{
                    boxForItem.fillColor = .yellow
                }else if weaponToSold.id == 1{
                    boxForItem.fillColor = .red
                }else{
                    boxForItem.fillColor = .blue
                }
                boxesForItem.append(boxForItem)
                itemBox.addChild(boxForItem)
                numToShow += 1
                numOfRows += 1
                if numOfRows >= 3{
                    numOfLines += 1
                    numOfRows = 0
                }
            }
        }
    }
    
    func goodsToSell(position: Int){
        var weaponId = 0
        for weapon in recipesYouHave{
            if weapon.numOfWeapon != 0 {
                if weaponId == position{
                    if goods[goodSelected].weaponId <= recipesYouHave.count{
                        recipesYouHave[goods[goodSelected].weaponId].isSelected = false
                        print(goods[goodSelected].weaponId)
                    }
                    goods[goodSelected].weaponId = weapon.id
                    goods[goodSelected].isContained = true
                    //                    recipesYouHave[weapon.id].isSelected = true
                }
                weaponId += 1
            }
        }
        if goods[goodSelected].weaponId == 0{
            boxesGood[goodSelected].fillColor = .yellow
        }else if goods[goodSelected].weaponId == 1{
            boxesGood[goodSelected].fillColor = .red
        }else{
            boxesGood[goodSelected].fillColor = .blue
        }
        for good in goods{
            if good.weaponId == goods[goodSelected].weaponId{
                if good.position != goods[goodSelected].position{
                    //                    recipesYouHave[goods[good.position].weaponId].isSelected = false
                    //                    print(goods[good.position].weaponId)
                    goods[good.position].isContained = false
                    goods[good.position].weaponId = 999
                    boxesGood[good.position].fillColor = .gray
                }
            }
        }
        recipesYouHave[goods[goodSelected].weaponId].isSelected = true
        print(goods[goodSelected].weaponId)
        
        itemBox.removeAllChildren()
        itemBox.removeFromParent()
        itemBoxShowed = false
    }
    
    
    func showVillageHead(){
        villageHead = SKShapeNode(rect: CGRect(x: 600, y: playableRect.minY+100, width: 1400, height: playableRect.height-200))
        villageHead.zPosition = 120
        villageHead.strokeColor = .black
        villageHead.fillColor = .white
        villageHead.lineWidth = 4.0
        addChild(villageHead)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        let touchLocation = touch.location(in: self)
        
        if villageHeadShowed{
            if villageHead.contains(touchLocation){
                
            }else{
                villageHeadShowed = false
                villageHead.removeAllChildren()
                villageHead.removeFromParent()
            }
        }else if smithyShowed{
            
            if itemBoxShowed {
                if itemBox.contains(touchLocation){
                    guard boxesForItem.count-1 >= 0 else {
                        return
                    }
                    
                    for i in 0...boxesForItem.count-1{
                        if boxesForItem[i].contains(touchLocation){
                            goodsToSell(position: i)
                        }
                    }
                }else{
                    itemBox.removeAllChildren()
                    itemBox.removeFromParent()
                    itemBoxShowed = false
                }
                
            }else{
                if smithy.contains(touchLocation){
                    for i in 0...5{
                        if boxesGood[i].contains(touchLocation){
                            itemBoxShowed = true
                            boxesGood[i].addChild(itemBox)
                            itemBox.zPosition = boxesGood[i].zPosition + 10
                            itemBox.lineWidth = 4.0
                            itemBox.strokeColor = .black
                            itemBox.fillColor = .white
                            goodSelected = i
                            goodsTouched()
                        }
                    }
                }else{
                    smithyShowed = false
                    smithy.removeAllChildren()
                    smithy.removeFromParent()
                }
            }
            
        }else if taskBoardShowed{
            if taskBoard.contains(touchLocation){
                if boxFirstTask.contains(touchLocation){
                    taskTouched(task: firstTask, box: boxFirstTask)
                }
                if boxSecondTask.contains(touchLocation){
                    taskTouched(task: secondTask, box: boxSecondTask)
                }
                if boxThirdTask.contains(touchLocation){
                    taskTouched(task: thirdTask, box: boxThirdTask)
                }
            }else{
                taskBoard.removeAllChildren()
                taskBoard.removeFromParent()
                taskBoardShowed = false
            }
        }else{
            if iconReturn.contains(touchLocation){
                removeAllChildren()
                gameScene.scaleMode = scaleMode
                view?.presentScene(gameScene, transition: reveal)
            }
            
            if iconVillageHead.contains(touchLocation){
                villageHeadShowed = true
                showVillageHead()
            }
            
            if iconSmithy.contains(touchLocation){
                smithyShowed = true
                showSmithy()
            }
            if iconTaskBoard.contains(touchLocation){
                taskBoardShowed = true
                showTaskBoard()
            }
        }
    }
}
