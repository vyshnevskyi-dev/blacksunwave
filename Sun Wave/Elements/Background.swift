//
//  Background.swift
//  Sun Wave
//
//  Created by VYSHNEVSKYI on 19.06.2020.
//  Copyright © 2020 _vyshnevskyi. All rights reserved.
//

import SpriteKit

class Background {
    var scene: SKScene
    
    init(scene: SKScene) {
        self.scene = scene
    }
    
    func setup() {
        // Устанавливает спрайт с фоновым изображением.
        let background = SKSpriteNode(imageNamed: "backgroundSun")
        
        // Определяет позиции элемента.
        background.position  = CGPoint(x: scene.size.width/2, y: scene.size.height/2)
        background.zPosition = 0
        
        // Отображается на экране.
        scene.addChild(background)
    }
}

