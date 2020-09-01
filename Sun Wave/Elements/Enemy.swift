//
//  Enemy.swift
//  Sun Wave
//
//  Created by VYSHNEVSKYI on 19.06.2020.
//  Copyright © 2020 _vyshnevskyi. All rights reserved.
//

import SpriteKit

class Enemy {
    var scene: SKScene
    var player: Player
    
    var playerCategory: UInt32 = 1
    var enemyCategory: UInt32 = 2
    var scoreCategory: UInt32 = 4
    
    var velocity: Double = 110.0
    
    init(scene: SKScene, player: Player) {
        self.scene = scene
        self.player = player
    }
    
    func spawn() {
        // Устанавливает стартовую позицию противника.
        let initialPosition = CGFloat(arc4random_uniform(132) + 74)
        
        // Устанавливает номер врага (для загрузки правильного изображения).
        let enemyNumber = Int(arc4random_uniform(4) + 1)
        
        // Устанавливает расстояние до врага на экране.
        let enemiesDistance = player.instance.size.height * 2.5
        
        // Создание вражеских узлов спрайтов.
        let enemyTop = SKSpriteNode(imageNamed: "enemytopBlack\(enemyNumber)")
        let enemyBottom = SKSpriteNode(imageNamed: "enemybottomBlack\(enemyNumber)")
        
        // Устанавливает размер врагов.
        let enemyWidth = enemyTop.size.width
        let enemyHeight = enemyTop.size.height
        
        // Определяет положения элементов.
        enemyTop.position = CGPoint(x: scene.size.width + enemyWidth/2, y: scene.size.height - initialPosition + enemyHeight/2)
        enemyBottom.position = CGPoint(x: scene.size.width + enemyWidth/2, y: enemyTop.position.y - enemyTop.size.height - enemiesDistance)
        enemyTop.zPosition = 1
        enemyBottom.zPosition = 1
        
        // Применить физику к элементам.
        enemyTop.physicsBody = SKPhysicsBody(rectangleOf: enemyTop.size)
        enemyTop.physicsBody?.isDynamic = false
        enemyTop.physicsBody?.categoryBitMask = enemyCategory
        enemyTop.physicsBody?.contactTestBitMask = playerCategory
        enemyBottom.physicsBody = SKPhysicsBody(rectangleOf: enemyBottom.size)
        enemyBottom.physicsBody?.isDynamic = false
        enemyBottom.physicsBody?.categoryBitMask = enemyCategory
        enemyBottom.physicsBody?.contactTestBitMask = playerCategory
        
        // Определяет лазер и его физику.
        let laser = SKNode()
        laser.position = CGPoint(x: enemyTop.position.x + enemyWidth/2, y: enemyTop.position.y - enemyTop.size.height/2 - enemiesDistance/2)
        laser.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 1, height: enemiesDistance))
        laser.physicsBody?.isDynamic = false
        laser.physicsBody?.categoryBitMask = scoreCategory
        
        // Устанавливает расстояние элемента.
        let distance = scene.size.width + enemyWidth
        
        // Устанавливает продолжительность элемента.
        let duration = Double(distance)/velocity
        
        // Начинает анимацию элемента.
        let moveAction = SKAction.moveBy(x: -distance, y: 0, duration: duration)
        
        // Удалить элемент с экрана.
        let removeAction = SKAction.removeFromParent()
        
        // Массив анимационных последовательностей.
        let sequenceAction = SKAction.sequence([moveAction, removeAction])
        
        // Запустите анимацию.
        enemyTop.run(sequenceAction)
        enemyBottom.run(sequenceAction)
        laser.run(sequenceAction)
        
        // Отображается на экране.
        scene.addChild(enemyTop)
        scene.addChild(enemyBottom)
        scene.addChild(laser)
    }
}

