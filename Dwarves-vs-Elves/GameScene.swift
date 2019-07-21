//
//  GameScene.swift
//  Dwarves-vs-Elves
//
//  Created by 程明卓 on 7/21/19.
//  Copyright © 2019 程明卓. All rights reserved.
//

import SpriteKit
import UIKit

class GameScene: SKScene{
    
    let playableRect: CGRect
    var rectMan: CGRect
    var rectItem: CGRect
    var rectMap: CGRect
    var rectMake: CGRect
    var itemBoxShowed = false
    let itemBox = SKShapeNode()
    var iconTaskList = SKShapeNode()
    var taskBoxShowed = false
    var taskBox = SKShapeNode()
    var taskList: [SKShapeNode] = []
    var taskLabel: [SKLabelNode] = []
    var numOfTask = 0
    var iconEmployee = SKShapeNode()
    var employeeBoxShowed = false
    var employeeBox = SKShapeNode()
    
    var lastTouchPosition: CGPoint?
    var dt: TimeInterval = 0
    var lastUpdateTime: TimeInterval = 0
    
    override init(size:CGSize) {
        let maxAspectRatio: CGFloat = 16.0/9.0
        let playableHeight = size.width / maxAspectRatio
        let playableMargin = (size.height - playableHeight)/2.0
        playableRect = CGRect(x: 0, y: playableMargin, width: size.width, height: playableHeight)
        
        rectMan = CGRect(x: size.width/2, y: playableRect.minY + playableRect.height/2, width: 200, height: 200)
        rectItem = CGRect(x: 200, y: playableRect.minY + playableRect.height/10,
                          width: 100, height: 100)
        rectMap = CGRect(x: 400, y: playableRect.minY + playableRect.height/10,
                         width: 100, height: 100)
        rectMake = CGRect(x: 600, y: playableRect.minY + playableRect.height/10,
                          width: 100, height: 100)
        
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode()
        backgroundColor = SKColor.white
        background.position = CGPoint(x: size.width/2, y: size.height/2)
        background.zPosition = -10
        addChild(background)
        shapeUI()
        story(gameScene: self)
        shapeResouse(gameScene: self)
    }
    
    func shapeUI(){
        
        let man = SKShapeNode()
        let pathMan = CGMutablePath()
        pathMan.addRect(rectMan)
        man.path = pathMan
        man.strokeColor = SKColor.red
        man.lineWidth = 4.0
        addChild(man)
        
        let iconItem = SKShapeNode()
        let pathItem = CGMutablePath()
        pathItem.addRect(rectItem)
        iconItem.path = pathItem
        iconItem.strokeColor = SKColor.black
        iconItem.lineWidth = 4.0
        iconItem.zPosition = 10
        addChild(iconItem)
        
        let pathItemBox = CGMutablePath()
        pathItemBox.addRect(CGRect(origin: CGPoint(x: size.width*(2.0/3.0), y: playableRect.minY),
                                   size: CGSize(width: size.width*(2.0/3.0), height: playableRect.height)))
        itemBox.path = pathItemBox
        itemBox.zPosition = 10
        itemBox.strokeColor = SKColor.black
        itemBox.lineWidth = 4.0
        
        let labelItem = SKLabelNode()
        labelItem.text = "ITEM"
        labelItem.fontColor = SKColor.black
        labelItem.fontSize = 80
        labelItem.zPosition = 150
        labelItem.horizontalAlignmentMode = .left
        labelItem.verticalAlignmentMode = .top
        labelItem.position = CGPoint(
            x: 200,
            y: rectItem.height + playableRect.minY + playableRect.height/5)
        addChild(labelItem)
        
        let iconMap = SKShapeNode(rect: rectMap)
        iconMap.fillColor = SKColor.blue
        iconMap.zPosition = 10
        addChild(iconMap)
        
        let labelMap = SKLabelNode()
        labelMap.text = "MAP"
        labelMap.fontColor = SKColor.black
        labelMap.fontSize = 80
        labelMap.zPosition = 150
        labelMap.horizontalAlignmentMode = .left
        labelMap.verticalAlignmentMode = .top
        labelMap.position = CGPoint(
            x: 400,
            y: rectMap.height + playableRect.minY + playableRect.height/5)
        addChild(labelMap)
        
        let iconMake = SKShapeNode(rect: rectMake)
        iconMake.fillColor = .green
        iconMake.zPosition = 10
        addChild(iconMake)
        
        let labelMake = SKLabelNode()
        labelMake.text = "MAKE"
        labelMake.fontColor = SKColor.black
        labelMake.fontSize = 80
        labelMake.zPosition = 150
        labelMake.horizontalAlignmentMode = .left
        labelMake.verticalAlignmentMode = .top
        labelMake.position = CGPoint(
            x: 600,
            y: rectMap.height + playableRect.minY + playableRect.height/5)
        addChild(labelMake)
        
        let pathTaskList = CGMutablePath()
        pathTaskList.addRect(CGRect(x: 800, y: playableRect.minY + playableRect.height/10, width: 100, height: 100))
        iconTaskList.path = pathTaskList
        iconTaskList.fillColor = .yellow
        iconTaskList.zPosition = 10
        addChild(iconTaskList)
        
        let labelTaskList = SKLabelNode(text: "TASK")
        labelTaskList.fontColor = .black
        labelTaskList.fontSize = 80
        labelTaskList.zPosition = 150
        labelTaskList.horizontalAlignmentMode = .left
        labelTaskList.verticalAlignmentMode = .top
        labelTaskList.position = CGPoint(
            x: 800,
            y: rectMap.height + playableRect.minY + playableRect.height/5)
        addChild(labelTaskList)
        
        let pathTaskBox = CGMutablePath()
        pathTaskBox.addRect(CGRect(origin: CGPoint(x: size.width*(2.0/3.0), y: playableRect.minY),
                                   size: CGSize(width: size.width*(2.0/3.0), height: playableRect.height)))
        taskBox.path = pathTaskBox
        taskBox.zPosition = 10
        taskBox.strokeColor = SKColor.black
        taskBox.lineWidth = 4.0
        
        iconEmployee = SKShapeNode(rect: CGRect(x: 1000, y: playableRect.minY + playableRect.height/10,
                                                width: 100, height: 100))
        iconEmployee.fillColor = .black
        iconEmployee.zPosition = 10
        addChild(iconEmployee)
        
        let labelEmployee = SKLabelNode(text: "HIRE")
        labelEmployee.fontColor = .black
        labelEmployee.fontSize = 80
        labelEmployee.zPosition = 150
        labelEmployee.horizontalAlignmentMode = .left
        labelEmployee.verticalAlignmentMode = .top
        labelEmployee.position = CGPoint(
            x: 1000,
            y: rectMap.height + playableRect.minY + playableRect.height/5)
        addChild(labelEmployee)
        
        employeeBox = SKShapeNode(rect: CGRect(x: size.width*(2.0/3.0), y: playableRect.minY, width: size.width/3, height: playableRect.height))
        employeeBox.zPosition = 10
        employeeBox.strokeColor = SKColor.black
        employeeBox.lineWidth = 4.0
    }
    
    override func update(_ currentTime: TimeInterval) {
        if lastUpdateTime > 0 {
            dt = currentTime - lastUpdateTime
        }else{
            dt = 0
        }
        lastUpdateTime = currentTime
    }
    
    func iconItemTouched(){
        var numOfItemToShow: Int = 0
        var itemInBox: [SKShapeNode] = []
        addChild(itemBox)
        itemBoxShowed = true
        for i in 0...4{
            for j in 0...2{
                let itemShapenode = SKShapeNode()
                let itemPath = CGMutablePath()
                let itemRect = CGRect(origin: CGPoint(x: size.width*(2.0/3.0) + CGFloat(50) + CGFloat(j * 200), y: playableRect.minY + CGFloat(100) + CGFloat((4 - i) * 200)),
                                      size: CGSize(width: 150, height: 150))
                itemShapenode.name = "\(i * 3 + j)"
                itemPath.addRect(itemRect)
                itemShapenode.path = itemPath
                itemShapenode.strokeColor = SKColor.brown
                itemShapenode.lineWidth = 4.0
                itemShapenode.zPosition = 20
                itemBox.addChild(itemShapenode)
                itemInBox.append(itemShapenode)
            }
        }
        for weapon in recipesYouHave {
            if weapon.numOfWeapon != 0 {
                itemInBox[numOfItemToShow].fillColor = .blue
                numOfItemToShow += 1
            }
        }
    }
    
    func itemTouched(touchLocation:CGPoint){
        //        var itemx: CGFloat = 0
        //        var itemy: CGFloat = 0
        //        var itemNum: CGFloat = 0
        //        var item: [CGFloat] = []
        //
        //        for i in 1...60{
        //            item.append(CGFloat(i))
        //        }
        //
        //        lastTouchPosition = touchLoaction
        //
        //        for i in 1...6{
        //            if lastTouchPosition?.x ?? 0 >= size.width*(2.0/3.0) + CGFloat(50) + CGFloat((i-1) * (100))
        //                && lastTouchPosition?.x ?? 0 <= size.width*(2.0/3.0) + CGFloat(50) + CGFloat(i * (100)){
        //                itemx = CGFloat( i )
        //            }
        //        }
        //        for j in 1...10{
        //            if lastTouchPosition?.y ?? 0 >= playableRect.minY + CGFloat(50) + CGFloat((j-1) * 100) &&
        //                lastTouchPosition?.y ?? 0 <= playableRect.minY + CGFloat(50) + CGFloat(j * 100) {
        //                itemy = CGFloat( j )
        //            }
        //        }
        //
        //        itemNum = 6 * (itemy - 1) + itemx - 1
        //        print("\(item[Int(itemNum)])")
    }
    
    func iconMapTouched(){
        let mapScene = MapScene(size: size)
        mapScene.scaleMode = scaleMode
        let reveal = SKTransition.fade(withDuration: 0.5)
        removeAllChildren()
        view?.presentScene(mapScene, transition: reveal)
    }
    
    func iconMakeTouched(){
        let makeScene = MakeSystem(size: size)
        makeScene.backgroundColor = SKColor.white
        makeScene.scaleMode = scaleMode
        let reveal = SKTransition.fade(withDuration: 0.5)
        removeAllChildren()
        view?.presentScene(makeScene, transition: reveal)
    }
    
    func iconTaskListTouched(){
        taskList = []
        taskLabel = []
        numOfTask = 0
        taskBoxShowed = true
        for num in 1...5{
            let task = SKShapeNode(rect: CGRect(x: playableRect.width*(2.0/3.0) + 50, y: playableRect.maxY - CGFloat(num * 200) - 100, width: 500, height: 150))
            task.strokeColor = .black
            task.lineWidth = 2.0
            task.zPosition = taskBox.zPosition + 10
            taskList.append(task)
        }
        
        for taskGot in tasksYouHave{
            if numOfTask < 5 {
                let taskDescribe = SKLabelNode()
                taskLabel.append(taskDescribe)
                taskLabel[numOfTask] = SKLabelNode(text: "\(taskGot.needDescribe)")
                taskLabel[numOfTask].zPosition = taskList[numOfTask].zPosition + 10
                taskLabel[numOfTask].fontColor = .black
                taskLabel[numOfTask].fontSize = 55
                taskLabel[numOfTask].position = CGPoint(x: playableRect.width*(2.0/3.0) + 70, y: playableRect.maxY - CGFloat((numOfTask+1) * 200) - 50)
                taskLabel[numOfTask].verticalAlignmentMode = .bottom
                taskLabel[numOfTask].horizontalAlignmentMode = .left
                taskBox.addChild(taskLabel[numOfTask])
                if taskGot.isDone == true {
                    taskList[numOfTask].fillColor = .green
                    taskBox.addChild(taskList[numOfTask])
                }else{
                    taskList[numOfTask].fillColor = .yellow
                    taskBox.addChild(taskList[numOfTask])
                }
                numOfTask += 1
            }
        }
    }
    
    func taskTouched(touchLocation: CGPoint){
        for i in 0...(taskList.count-1){
            if i < numOfTask{
                if taskList[i].contains(touchLocation){
                    if tasksYouHave[i].isFinished == false{
                        if tasksYouHave[i].isDone {
                            taskLabel[i].run(labelAction)
                            
                            let closureAction = SKAction.run {
                                completeTheTask(task:i)
                                self.taskBox.removeAllChildren()
                                self.iconTaskListTouched()
                            }
                            
                            taskList[i].run(SKAction.sequence([labelAction, closureAction]))
                        }
                    }
                    
                }
            }
        }
    }
    
    func iconEmployeeTouched(){
        employeeBoxShowed = true
        let labelWoodWorker = SKLabelNode(text: "WoodWorker")
        labelWoodWorker.fontSize = 60
        labelWoodWorker.fontColor = SKColor.black
        labelWoodWorker.zPosition = employeeBox.zPosition + 10
        labelWoodWorker.horizontalAlignmentMode = .left
        labelWoodWorker.verticalAlignmentMode = .top
        labelWoodWorker.position = CGPoint(
            x: playableRect.width * (2/3) + 50,
            y: playableRect.minY + playableRect.height * 0.9 )
        employeeBox.addChild(labelWoodWorker)
        
        let labelWoodGet = SKLabelNode()
        labelWoodGet.fontSize = 60
        labelWoodGet.fontColor = SKColor.black
        labelWoodGet.zPosition = employeeBox.zPosition + 10
        labelWoodGet.horizontalAlignmentMode = .left
        labelWoodGet.verticalAlignmentMode = .top
        labelWoodGet.position = CGPoint(
            x: playableRect.width * (2/3) + 50,
            y: playableRect.minY + playableRect.height * 0.85 )
        labelWoodGet.numberOfLines = 0
        labelWoodGet.lineBreakMode = .byClipping
        labelWoodGet.text = """
        You could get
        \(woodGet) wood
        everyday
        """
        employeeBox.addChild(labelWoodGet)
        
        let labelStoneWorker = SKLabelNode(text: "StoneWorker")
        labelStoneWorker.fontSize = 60
        labelStoneWorker.fontColor = SKColor.black
        labelStoneWorker.zPosition = employeeBox.zPosition + 10
        labelStoneWorker.horizontalAlignmentMode = .left
        labelStoneWorker.verticalAlignmentMode = .top
        labelStoneWorker.position = CGPoint(
            x: playableRect.width * (2/3) + 50,
            y: playableRect.minY + playableRect.height * 0.6 )
        employeeBox.addChild(labelStoneWorker)
        
        let labelStoneGet = SKLabelNode()
        labelStoneGet.fontSize = 60
        labelStoneGet.fontColor = SKColor.black
        labelStoneGet.zPosition = employeeBox.zPosition + 10
        labelStoneGet.horizontalAlignmentMode = .left
        labelStoneGet.verticalAlignmentMode = .top
        labelStoneGet.position = CGPoint(
            x: playableRect.width * (2/3) + 50,
            y: playableRect.minY + playableRect.height * 0.55 )
        labelStoneGet.numberOfLines = 0
        labelStoneGet.lineBreakMode = .byClipping
        labelStoneGet.text = """
        You could get
        \(stoneGet) stone
        everyday
        """
        employeeBox.addChild(labelStoneGet)
        
        let labelHarmerWorker = SKLabelNode(text: "HarmerWorker")
        labelHarmerWorker.fontSize = 60
        labelHarmerWorker.fontColor = SKColor.black
        labelHarmerWorker.zPosition = employeeBox.zPosition + 10
        labelHarmerWorker.horizontalAlignmentMode = .left
        labelHarmerWorker.verticalAlignmentMode = .top
        labelHarmerWorker.position = CGPoint(
            x: playableRect.width * (2/3) + 50,
            y: playableRect.minY + playableRect.height * 0.3 )
        employeeBox.addChild(labelHarmerWorker)
        
        let labelWeaponGet = SKLabelNode()
        labelWeaponGet.fontSize = 60
        labelWeaponGet.fontColor = SKColor.black
        labelWeaponGet.zPosition = employeeBox.zPosition + 10
        labelWeaponGet.horizontalAlignmentMode = .left
        labelWeaponGet.verticalAlignmentMode = .top
        labelWeaponGet.position = CGPoint(
            x: playableRect.width * (2/3) + 50,
            y: playableRect.minY + playableRect.height * 0.25 )
        labelWeaponGet.numberOfLines = 0
        labelWeaponGet.lineBreakMode = .byClipping
        labelWeaponGet.text = """
        You could get
        \(woodGet) weapon
        everyday
        """
        employeeBox.addChild(labelWeaponGet)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else{
            return
        }
        
        let touchLocation = touch.location(in: self)
        
        if employeeBoxShowed{
            if (touchLocation.x <= size.width*(2.0/3.0)){
                employeeBox.removeAllChildren()
                employeeBox.removeFromParent()
                employeeBoxShowed = false
            }else{
                
            }
        }else{
            if storyViewShowed {
                if touchLocation.x <= 1167 &&
                    touchLocation.x >= 883 &&
                    touchLocation.y >= 674 &&
                    touchLocation.y <= 760{
                    storyView.removeFromSuperview()
                    storyViewShowed = false
                }
            }else{
                if itemBoxShowed {
                    if (touchLocation.x <= size.width*(2.0/3.0)) {
                        itemBox.removeAllChildren()
                        itemBox.removeFromParent()
                        itemBoxShowed = false
                    }else{
                        itemTouched(touchLocation: touchLocation)
                    }
                }else{
                    if taskBoxShowed{
                        if (touchLocation.x <= size.width*(2.0/3.0)) {
                            taskBox.removeAllChildren()
                            taskBox.removeFromParent()
                            taskBoxShowed = false
                        }else{
                            taskTouched(touchLocation: touchLocation)
                        }
                    }else{
                        if (rectItem.contains(touchLocation)) {
                            iconItemTouched()
                        }
                        
                        if(rectMap.contains(touchLocation)){
                            iconMapTouched()
                        }
                        
                        if(rectMake.contains(touchLocation)){
                            iconMakeTouched()
                        }
                        
                        if iconTaskList.contains(touchLocation){
                            addChild(taskBox)
                            iconTaskListTouched()
                        }
                        
                        if iconEmployee.contains(touchLocation){
                            addChild(employeeBox)
                            iconEmployeeTouched()
                        }
                        
                    }
                }
            }
        }
    }
}
