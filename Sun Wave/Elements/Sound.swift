//
//  Sound.swift
//  Sun Wave
//
//  Created by VYSHNEVSKYI on 19.06.2020.
//  Copyright © 2020 _vyshnevskyi. All rights reserved.
//

import SpriteKit

class Sound {
    var scene: SKScene
    let scoreSound = SKAction.playSoundFileNamed("score - 2.mp3", waitForCompletion: false)
    let gameOverSound = SKAction.playSoundFileNamed("game over - 2.mp3", waitForCompletion: false)
    
    init(scene: SKScene) {
        self.scene = scene
    }
    
    func playScoreSound() {
        scene.run(scoreSound)
    }
    
    func playGameOverSound() {
        scene.run(gameOverSound)
    }
}
