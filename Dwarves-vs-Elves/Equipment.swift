//
//  Equipment.swift
//  Dwarves-vs-Elves
//
//  Created by 程明卓 on 7/21/19.
//  Copyright © 2019 程明卓. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

var recipesYouHave:[Weapon] = []
var weaponsId: Int = 0

protocol Weapon {
    //recipe0 = stone recipe1 = wood
    var id: Int { get set }
    var name: String { get }
    var materials: [Int] { get }
    var recipe: String { get }
    var numOfWeapon: Int { get set }
    var isSelected: Bool { get set }
}

class Sword: Weapon{
    var isSelected: Bool = false
    var recipe: String
    var numOfWeapon: Int = 0
    var id: Int = 0
    var name: String = "Sword"
    var materials: [Int] = [0,0]
    init(levelName: String, levelRecipe: [Int]) {
        //        id = id + level * 3
        name = levelName + " " + name
        materials[0] += levelRecipe[0]
        materials[1] += levelRecipe[1]
        recipe = "You need \(materials[0]) stone and \(materials[1]) woods"
    }
}

class Shield: Weapon{
    var isSelected: Bool = false
    var recipe: String
    var numOfWeapon: Int = 0
    var id: Int = 1
    var name: String = "Shield"
    var materials: [Int] = [0,0]
    init(levelName: String, levelRecipe: [Int]) {
        //        id = id + level * 3
        name = levelName + " " + name
        materials[0] += levelRecipe[0]
        materials[1] += levelRecipe[1]
        recipe = "You need \(materials[0]) stone and \(materials[1]) woods"
    }
}

class Armor: Weapon{
    var isSelected: Bool = false
    //    func encode(with aCoder: NSCoder) {
    //        aCoder.encode(recipe, forKey: "recipe")
    //    }
    //
    
    
    var recipe: String
    var numOfWeapon: Int = 0
    var id: Int = 2
    var name: String = "Armor"
    var materials: [Int] = [0,0]
    
    
    init(levelName: String, levelRecipe: [Int]) {
        //        id = id + level * 3
        name = "\(levelName) \(name)"
        materials[0] += levelRecipe[0]
        materials[1] += levelRecipe[1]
        recipe = "You need \(materials[0]) stone and \(materials[1]) woods"
        //        save()
    }
    //
    //    required init?(coder aDecoder: NSCoder) {
    //
    //        recipe = aDecoder.decodeObject(forKey: "recipe") as! String
    //    }
    
    //
    //    func save() {
    //        let fileManager = FileManager.default
    //
    //        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    //
    //        let savedFile = url?.appendingPathComponent("properties.plist")
    //
    //        do {
    //            let data = try NSKeyedArchiver.archivedData(withRootObject: id, requiringSecureCoding: false)
    //
    //            try data.write(to: savedFile!)
    //        } catch let error {
    //            print(error)
    //        }
    //
    //        print(savedFile!.path)
    //    }
    //
    //    func load() {
    //        guard let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("properties.plist") else {
    //            return
    //        }
    //
    //        let data = NSData(contentsOf: path)!
    //
    //        id = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data as Data) as! Int
    //    }
    //
}



func gotRecipe(weapon:Weapon){
    recipesYouHave.append(weapon)
    recipesYouHave[weaponsId].id = weaponsId
    weaponsId += 1
}

func isItemMade(id:Int)->(Bool){
    if recipesYouHave[id].materials[1] <= woods {
        if recipesYouHave[id].materials[0] <= stone {
            woods -= recipesYouHave[id].materials[1]
            stone -= recipesYouHave[id].materials[0]
            recipesYouHave[id].numOfWeapon += 1
            time += 1
            if time >= 4 {
                days += 1
                time = 1
                firstTask = getRandomTask(id: 1)
                secondTask = getRandomTask(id: 2)
                thirdTask = getRandomTask(id: 3)
            }
            return true
        }
    }
    return false
}

var basicSword = Sword(levelName: "Basic", levelRecipe: [50,50])
var betterSword = Sword(levelName: "Better", levelRecipe: [100,100])
var goldSword = Sword(levelName: "Gold", levelRecipe: [10000,10000])
var basicShield = Shield(levelName: "Basic", levelRecipe: [100,0])
var basicArmor = Armor(levelName: "Basic", levelRecipe: [0,100])
