//
//  Player.swift
//  WingsStats
//
//  Created by Victor Fundberg on 2018-04-18.
//  Copyright © 2018 Victor Fundberg. All rights reserved.
//

import Foundation

class Player {
    let name : String
    var plus : Int = 0
    var minus : Int = 0
    var gamePlus : Int = 0
    var gameMinus : Int = 0
    var gameTotal : Int = 0
    var total : Int = 0

    
    init(name : String) {
        self.name = name
    }
}

func addPlusInGame(player : Player) {
    player.gamePlus = player.gamePlus + 1
    player.gameTotal = player.gameTotal + 1
}

func addMinusInGame(player : Player) {
    player.gameMinus = player.gameMinus + 1
    player.gameTotal = player.gameTotal - 1
}
func finishAGame(player : Player) {
    player.plus = player.plus + player.gamePlus
    player.minus = player.minus + player.gameMinus
    player.total = player.plus - player.minus
    player.gamePlus = 0
    player.gameMinus = 0
    player.gameTotal = 0
}
