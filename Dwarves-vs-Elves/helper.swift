//
//  helper.swift
//  Dwarves-vs-Elves
//
//  Created by 程明卓 on 7/21/19.
//  Copyright © 2019 程明卓. All rights reserved.
//

import Foundation
import SpriteKit
import CoreGraphics
import AVFoundation

let size = CGSize(width: 2048, height: 1536)
let maxAspectRatio: CGFloat = 16.0/9.0
let playableHeight = size.width / maxAspectRatio
let playableMargin = (size.height - playableHeight)/2.0
let playableRect = CGRect(x: 0, y: playableMargin, width: size.width, height: playableHeight)
var days = 1
var time = 1
var coins = 0
var stone = 0
var woods = 0
let labelAction  = SKAction.fadeOut(withDuration: 1)

let labelDays = SKLabelNode()
let labelTime = SKLabelNode()
let labelNumOfWoods = SKLabelNode()
let labelNumOfMoney = SKLabelNode()
let labelNumOfStone = SKLabelNode()

func shapeResouse(gameScene: SKScene){
    labelDays.position = CGPoint(x: 50, y: 1300)
    labelDays.fontColor = SKColor.red
    labelDays.text = "Day: \(days)"
    labelDays.fontSize = 80
    labelDays.horizontalAlignmentMode = .left
    labelDays.verticalAlignmentMode = .top
    labelDays.zPosition = 100
    gameScene.addChild(labelDays)
    
    labelTime.position = CGPoint(x: 50, y: 1200)
    labelTime.fontColor = SKColor.red
    if time == 1 {
        labelTime.text = "Time: Morning"
    }else if time == 2 {
        labelTime.text = "Time: Afternoon"
    }else if time == 3 {
        labelTime.text = "Time: Evening"
    }
    labelTime.fontSize = 80
    labelTime.horizontalAlignmentMode = .left
    labelTime.verticalAlignmentMode = .top
    labelTime.zPosition = 100
    gameScene.addChild(labelTime)
    
    labelNumOfMoney.position = CGPoint(x: 50, y: 1100)
    labelNumOfMoney.fontColor = SKColor.red
    labelNumOfMoney.text = "Coins: \(coins)"
    labelNumOfMoney.fontSize = 80
    labelNumOfMoney.horizontalAlignmentMode = .left
    labelNumOfMoney.verticalAlignmentMode = .top
    labelNumOfMoney.zPosition = 100
    gameScene.addChild(labelNumOfMoney)
    
    labelNumOfStone.position = CGPoint(x: 50, y: 1000)
    labelNumOfStone.fontColor = SKColor.red
    labelNumOfStone.text = "Stone: \(stone)"
    labelNumOfStone.fontSize = 80
    labelNumOfStone.horizontalAlignmentMode = .left
    labelNumOfStone.verticalAlignmentMode = .top
    labelNumOfStone.zPosition = 100
    gameScene.addChild(labelNumOfStone)
    
    labelNumOfWoods.position = CGPoint(x: 50, y: 900)
    labelNumOfWoods.fontColor = SKColor.red
    labelNumOfWoods.text = "Woods: \(woods)"
    labelNumOfWoods.fontSize = 80
    labelNumOfWoods.horizontalAlignmentMode = .left
    labelNumOfWoods.verticalAlignmentMode = .top
    labelNumOfWoods.zPosition = 100
    gameScene.addChild(labelNumOfWoods)
}










func + (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

func += (left: inout CGPoint, right: CGPoint) {
    left = left + right
}

func - (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

func -= (left: inout CGPoint, right: CGPoint) {
    left = left - right
}

func * (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x * right.x, y: left.y * right.y)
}

func *= (left: inout CGPoint, right: CGPoint) {
    left = left * right
}

func * (point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x * scalar, y: point.y * scalar)
}

func *= (point: inout CGPoint, scalar: CGFloat) {
    point = point * scalar
}

func / (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x / right.x, y: left.y / right.y)
}

func /= ( left: inout CGPoint, right: CGPoint) {
    left = left / right
}

func / (point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x / scalar, y: point.y / scalar)
}

func /= (point: inout CGPoint, scalar: CGFloat) {
    point = point / scalar
}

#if !(arch(x86_64) || arch(arm64))
func atan2(y: CGFloat, x: CGFloat) -> CGFloat {
    return CGFloat(atan2f(Float(y), Float(x)))
}

func sqrt(a: CGFloat) -> CGFloat {
    return CGFloat(sqrtf(Float(a)))
}
#endif

extension CGPoint {
    
    func length() -> CGFloat {
        return sqrt(x*x + y*y)
    }
    
    func normalized() -> CGPoint {
        return self / length()
    }
    
    var angle: CGFloat {
        return atan2(y, x)
    }
}

let π = CGFloat.pi

func shortestAngleBetween(angle1: CGFloat,
                          angle2: CGFloat) -> CGFloat {
    let twoπ = π * 2.0
    var angle = (angle2 - angle1)
        .truncatingRemainder(dividingBy: twoπ)
    if angle >= π {
        angle = angle - twoπ
    }
    if angle <= -π {
        angle = angle + twoπ
    }
    return angle
}

extension CGFloat {
    func sign() -> CGFloat {
        return self >= 0.0 ? 1.0 : -1.0
    }
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / Float(UInt32.max))
    }
    
    static func random(min: CGFloat, max: CGFloat) -> CGFloat {
        assert(min < max)
        return CGFloat.random() * (max - min) + min
    }
}

extension Int {
    static func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / Float(UInt32.max))
    }
    
    static func random(min: Int, max: Int) -> Int {
        assert(min < max)
        return Int(Int.random() * CGFloat(max - min)) + min
    }
}

var backgroundMusicPlayer: AVAudioPlayer!

func playBackgroundMusic(filename: String) {
    let resourceUrl = Bundle.main.url(forResource:
        filename, withExtension: nil)
    guard let url = resourceUrl else {
        print("Could not find file: \(filename)")
        return
    }
    
    do {
        try backgroundMusicPlayer =
            AVAudioPlayer(contentsOf: url)
        backgroundMusicPlayer.numberOfLoops = -1
        backgroundMusicPlayer.prepareToPlay()
        backgroundMusicPlayer.play()
    } catch {
        print("Could not create audio player!")
        return
    }
}
