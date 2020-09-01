//
//  Score.swift
//  Sun Wave
//
//  Created by VYSHNEVSKYI on 19.06.2020.
//  Copyright © 2020 _vyshnevskyi. All rights reserved.
//

import SpriteKit

class Score {
    var scene: SKScene
    var scoreLabel: SKLabelNode!
    var playerScore: Int = 0
    var recordScore: Int = 0
    
    init(scene: SKScene) {
        self.scene = scene
    }
    
    func setup() {
        // Определяет метку спрайта со шрифтом Chalkduster.
        scoreLabel = SKLabelNode(fontNamed: "Courier New Bold")
        
        // Форматирование текста метки.
        scoreLabel.fontSize = 58
        scoreLabel.fontColor = .black
        scoreLabel.text = "\(playerScore)"
        scoreLabel.alpha = 1.0
        
        // Определяет позиции элемента.
        scoreLabel.position = CGPoint(x: scene.size.width/2, y: scene.size.height - 80)
        scoreLabel.zPosition = 5
        
        // Отображается на экране.
        scene.addChild(scoreLabel)
    }
    
    func showText() {
        let showScoreLabel = SKLabelNode(fontNamed: "Courier New Bold")
        showScoreLabel.fontSize = 20
        showScoreLabel.fontColor = UIColor.black
        showScoreLabel.text = "SCORE"
        showScoreLabel.position = CGPoint(x: scene.size.width / 2, y: 300)
        showScoreLabel.zPosition = 6
        scene.addChild(showScoreLabel)
    }
    
    func showNumber() {
        let showScoreLabel = SKLabelNode(fontNamed: "Courier New Bold")
        showScoreLabel.fontSize = 35
        showScoreLabel.fontColor = UIColor.black
        showScoreLabel.text = "\(playerScore)"
        showScoreLabel.position = CGPoint(x: scene.size.width / 2, y: 270)
        showScoreLabel.zPosition = 6
        scene.addChild(showScoreLabel)
    }
    
    func showRecord() {
        let showScoreLabel = SKLabelNode(fontNamed: "Courier New Bold")
        showScoreLabel.fontSize = 20
        showScoreLabel.fontColor = UIColor.black
        showScoreLabel.text = "RECORD"
        showScoreLabel.position = CGPoint(x: scene.size.width / 2, y: 230)
        showScoreLabel.zPosition = 6
        scene.addChild(showScoreLabel)
    }
    
    func showRecordNumber() {
        let showScoreLabel = SKLabelNode(fontNamed: "Courier New Bold")
        showScoreLabel.fontSize = 35
        
        showScoreLabel.text = "\(recordScore)"
        showScoreLabel.fontColor = UIColor.black
        showScoreLabel.position = CGPoint(x: scene.size.width / 2, y: 200)
        showScoreLabel.zPosition = 6
        scene.addChild(showScoreLabel)
    }
    
}

