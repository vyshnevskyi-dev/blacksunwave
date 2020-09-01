//
//  Floor.swift
//  Sun Wave
//
//  Created by VYSHNEVSKYI on 19.06.2020.
//  Copyright © 2020 _vyshnevskyi. All rights reserved.
//

import SpriteKit

class Floor {
    var scene: SKScene
    var floor: SKSpriteNode!
    var gameArea: CGFloat = 410.0
    var velocity: Double = 110.0
    var enemyCategory: UInt32 = 2
    var playerCategory: UInt32 = 1
    
    init(scene: SKScene) {
        self.scene = scene
    }
    
    func setup() {
        // Определяет спрайт с изображением пола.
        floor = SKSpriteNode(imageNamed: "floorNew7")
        
        // Определяет позиции элемента.
        floor.position  = CGPoint(x: floor.size.width / 2, y: scene.size.height - gameArea - floor.size.height / 2)
        floor.zPosition = 2
        
        // Рассчитывает продолжительность анимации.
        let duration = Double(floor.size.width/2) / velocity
        
        // Анимация для перемещения пола вправо.
        let moveFloorAction = SKAction.moveBy(x: -floor.size.width/2, y: 0, duration: duration)
        
        // Возвращает пол в исходное местоположение.
        let resetXAction = SKAction.moveBy(x: floor.size.width/2, y: 0, duration: 0)
        
        // Массив анимационных последовательностей.
        let sequenceAction = SKAction.sequence([moveFloorAction, resetXAction])
        
        // Повторите анимацию навсегда.
        let repeatAction = SKAction.repeatForever(sequenceAction)
        
        // Запустите анимацию.
        floor.run(repeatAction)
        
        // Отображается на экране.
        scene.addChild(floor)
        
        // Добавляет невидимые границы сценария.
        invisibleRoof()
        invisibleFloor()
    }
    
    func invisibleFloor() {
        // Определяет узел спрайта.
        let invisibleFloor = SKNode()
        
        // Определяет физику элемента.
        invisibleFloor.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: scene.size.width, height: 1))
        invisibleFloor.physicsBody?.isDynamic = false
        invisibleFloor.physicsBody?.categoryBitMask = enemyCategory
        invisibleFloor.physicsBody?.contactTestBitMask = playerCategory
        
        // Определяет позиции элемента.
        invisibleFloor.position = CGPoint(x: scene.size.width/2, y: scene.size.height - gameArea)
        invisibleFloor.zPosition = 2
        
        // Отображается на экране.
        scene.addChild(invisibleFloor)
    }
    
    func invisibleRoof() {
        // Определяет узел спрайта.
        let invisibleRoof = SKNode()
        
        // Определяет физику элемента.
        invisibleRoof.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: scene.size.width, height: 1))
        invisibleRoof.physicsBody?.isDynamic = false
        
        // Определяет позиции элемента.
        invisibleRoof.position = CGPoint(x: scene.size.width/2, y: scene.size.height)
        invisibleRoof.zPosition = 2
        
        // Отображается на экране.
        scene.addChild(invisibleRoof)
    }
}

