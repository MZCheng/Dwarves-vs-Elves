//
//  TaskSystem.swift
//  Dwarves-vs-Elves
//
//  Created by 程明卓 on 7/21/19.
//  Copyright © 2019 程明卓. All rights reserved.
//

import Foundation
import SpriteKit
var tasksYouHave:[ItemTask] = []
var taskId : Int = 1
var firstTask: ItemTask = getRandomTask(id: 1)
var secondTask: ItemTask = getRandomTask(id: 2)
var thirdTask: ItemTask = getRandomTask(id: 3)

class ItemTask {
    var need: Int = 0
    var needId: Int = 0
    var needDescribe: String = ""
    var reward: [Int] = [0,0,0]
    var id = 0
    var rewardDescribe = ""
    var position: Int = 0
    var isTaken: Bool = false
    var isDone: Bool = false
    var isFinished: Bool = false
    
    init(Item: String, Num: Int){
        need = Num
        needDescribe = "I need \(need) \(Item)"
    }
}

func getRandomTask(id: Int) -> (ItemTask){
    let randomItem = CGFloat.random(min: 1, max: CGFloat(recipesYouHave.count) + 0.99)
    let randomWeapon = recipesYouHave[Int(randomItem)-1]
    let randomNum = CGFloat.random(min: 1, max: CGFloat(randomWeapon.id + 2) + 0.99)
    let randomTask = ItemTask(Item: randomWeapon.name, Num: Int(randomNum))
    randomTask.reward = [randomWeapon.materials[0], randomWeapon.materials[1], (randomWeapon.id/3 + 1) * 100 * randomTask.need]
    randomTask.rewardDescribe = "You could get \(randomTask.reward[2]) coins!"
    randomTask.position = id
    randomTask.needId = randomWeapon.id
    return randomTask
}

func addTask(task: ItemTask){
    task.id = taskId
    taskId += 1
    tasksYouHave.append(task)
}

func isTaskDone(){
    guard tasksYouHave.count-1 >= 0 else {
        return
    }
    
    for task in 0...(tasksYouHave.count-1){
        if recipesYouHave[tasksYouHave[task].needId].numOfWeapon >= tasksYouHave[task].need{
            tasksYouHave[task].isDone = true
        }else{
            tasksYouHave[task].isDone = false
        }
    }
}

func completeTheTask(task:Int){
    recipesYouHave[tasksYouHave[task].needId].numOfWeapon -= tasksYouHave[task].need
    coins += tasksYouHave[task].reward[2]
    labelNumOfMoney.text = "Coins: \(coins)"
    tasksYouHave[task].isFinished = true
    tasksYouHave.remove(at: task)
    isTaskDone()
}
