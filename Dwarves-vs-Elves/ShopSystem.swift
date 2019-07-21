//
//  ShopSystem.swift
//  Dwarves-vs-Elves
//
//  Created by 程明卓 on 7/21/19.
//  Copyright © 2019 程明卓. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

var goods: [goodsToSell] = []

class goodsToSell{
    var isContained: Bool = false
    var position: Int = 0
    var weaponId: Int = 999
    var price: Int = 0
    
    init(position: Int) {
        self.position = position
    }
}

var good0 = goodsToSell(position: 0)
var good1 = goodsToSell(position: 1)
var good2 = goodsToSell(position: 2)
var good3 = goodsToSell(position: 3)
var good4 = goodsToSell(position: 4)
var good5 = goodsToSell(position: 5)
