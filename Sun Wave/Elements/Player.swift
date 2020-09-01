//
//  Player.swift
//  Sun Wave
//
//  Created by VYSHNEVSKYI on 19.06.2020.
//  Copyright © 2020 _vyshnevskyi. All rights reserved.
//

import SpriteKit

class Player {
    var scene: SKScene
    var instance: SKSpriteNode!
    var gameArea: CGFloat = 410.0
    
    init(scene: SKScene) {
        self.scene = scene
    }
    
    func setup() {
        // Определяет круг с изображением player1.
        instance = SKSpriteNode(imageNamed: "circle1")
        
        // Определяет позиции элемента.
        instance.position  = CGPoint(x: 60, y: scene.size.height - gameArea / 2)
        instance.zPosition = 4
        
        // Определяет массив текстур игрока.
        var playerTextures = [SKTexture]()
        
        // Накорми массив четырьмя текстурами игрока.
        for i in 1...12 {
            playerTextures.append(SKTexture(imageNamed: "circle\(i)"))
        }
        
        // Он анимируется с массивом текстур продолжительностью 0,009 с на кадр.
        let animationAction = SKAction.animate(with: playerTextures, timePerFrame: 0.09)
        
        // Повторите анимацию навсегда.
        let repeatAction = SKAction.repeatForever(animationAction)
        
        // Запустите анимацию.
        instance.run(repeatAction)
        
        // Отображается на экране.
        scene.addChild(instance)
    }
}

