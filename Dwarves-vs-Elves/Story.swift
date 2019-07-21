//
//  Story.swift
//  Dwarves-vs-Elves
//
//  Created by 程明卓 on 7/21/19.
//  Copyright © 2019 程明卓. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit

var storyViewShowed = false
let storyView = UIView(frame: CGRect(origin: CGPoint(x: 150, y: 100), size: CGSize(width: 400, height: 150)))
let centerPoint = CGPoint(x: size.width/(2.79*2.0), y: size.height/(2.79*3.0))
let storyLabel = UILabel()
let storyButton = UILabel()


func story(gameScene: SKScene){
    
    storyView.backgroundColor = SKColor.gray
    storyView.center = centerPoint
    
    storyLabel.frame = CGRect(origin: CGPoint(x: 100, y: -10), size: CGSize(width: 400, height: 150))
    storyLabel.textColor = SKColor.red
    storyLabel.font.withSize(2000)
    storyView.addSubview(storyLabel)
    
    storyButton.backgroundColor = SKColor.black
    storyButton.frame = CGRect(x: 150, y: 100, width: 100, height: 30)
    storyButton.text = "      Get it"
    storyButton.textColor = .white
    storyButton.font.withSize(100)
    storyView.addSubview(storyButton)
    
    if days >= 2 && (recipesYouHave.count == 3){
        gameScene.view?.addSubview(storyView)
        storyViewShowed = true
        storyLabel.numberOfLines = 0
        storyLabel.lineBreakMode = .byClipping
        storyLabel.text = """
        Dog occupied the village!!!
        But villagers give you a recipe~
        You could make a Better Sword!
        """
        gotRecipe(weapon: betterSword)
    }
}
