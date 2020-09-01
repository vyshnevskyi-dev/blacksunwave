//
//  GameScene.swift
//  Sun Wave
//
//  Created by VYSHNEVSKYI on 19.06.2020.
//  Copyright © 2020 _vyshnevskyi. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var floor: Floor!
    var background: Background!
    var player: Player!
    var enemy: Enemy!
    var score: Score!
    var sound: Sound!
    var intro: SKSpriteNode!
    var timer: Timer!
    var gameViewController: GameViewController?
    var gameStarted = false
    var gameFinished = false
    var restart = false
    
    let flyForce: CGFloat = 30.0
    let playerCategory: UInt32 = 1
    let enemyCategory: UInt32 = 2
    let scoreCategory: UInt32 = 4
    let velocity: Double = 110.0
    
    var adCount: Int = 0
    
    var userDefaults = UserDefaults.standard
    
    func addHighscore() {
             if score.playerScore > score.recordScore {
                  score.recordScore = score.playerScore
              }
                  saveTopScore()
              }
          
    func loadTopScore() {
        if userDefaults.object(forKey: "record") != nil {
            score.recordScore = userDefaults.object(forKey: "record") as! Int
              }
          }
       
    func saveTopScore() {
        userDefaults.setValue(score.recordScore, forKey: "record")
        userDefaults.synchronize()
    }
    
    func loadAdCount() {
        if userDefaults.object(forKey: "adcount") != nil {
            adCount = userDefaults.object(forKey: "adcount") as! Int
              }
          }
       
    func saveAdCount() {
        userDefaults.setValue(adCount, forKey: "adcount")
        userDefaults.synchronize()
    }
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        
        floor = Floor(scene: self)
        floor.setup()
        
        background = Background(scene: self)
        background.setup()
        
        player = Player(scene: self)
        player.setup()
        
        enemy = Enemy(scene: self, player: player)
        score = Score(scene: self)
        sound = Sound(scene: self)
        
        addIntro()
        
        loadAdCount()
        
    }
    
    func addIntro() {
        // Устанавливает спрайт с заставкой.
        intro = SKSpriteNode(imageNamed: "intro5")
        
        // Определяет позиции элемента.
        intro.position  = CGPoint(x: size.width/2, y: size.height - 210)
        intro.zPosition = 3
        
        // Отображается на экране.
        addChild(intro)
    }
    
    func gameOver() {
        // Для игрового времени.
        timer.invalidate()
        
        // Изменяет информацию об элементе игрока.
        player.instance.zRotation = 0
        player.instance.texture = SKTexture(imageNamed: "circleDead2")
        
        // За все действия в игре.
        for node in self.children {
            node.removeAllActions()
        }
        
        // Отключает серьезность элемента игрока.
        player.instance.physicsBody?.isDynamic = false
        
        // Изменяет логическое управление игрой.
        gameFinished = true
        gameStarted = false
        
        adCount += 1
        saveAdCount()
        print(adCount)
        
        if adCount == AD_MOB_INTER_RATE {
            adCount = 0
            saveAdCount()
            NotificationCenter.default.post(name: NSNotification.Name("presentInterstitial"), object: nil)
        }
        
        // Применяет игру поверх экрана.
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { (timer) in
            
            let gameOverShow = SKSpriteNode(imageNamed: "gOver2")
            gameOverShow.size = CGSize(width: 200, height: 200)
            gameOverShow.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
            gameOverShow.zPosition = 5
            self.addChild(gameOverShow)
            
            self.score.showText()
            self.score.showNumber()
            self.score.showRecord()
            self.score.showRecordNumber()
            self.restart = true
            
            self.addHighscore()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !gameFinished {
            if !gameStarted {
                // Удалить вступление.
                intro.removeFromParent()
                
                // Добавляет метку счета игрока.
                self.score.setup()
                
                loadTopScore()
                // Определяет физику элемента.
                player.instance.physicsBody = SKPhysicsBody(circleOfRadius: player.instance.size.width / 2 - 12)
                player.instance.physicsBody?.isDynamic = true
                player.instance.physicsBody?.allowsRotation = true
                player.instance.physicsBody?.applyImpulse(CGVector(dx: 0, dy: flyForce))
                player.instance.physicsBody?.categoryBitMask = playerCategory
                player.instance.physicsBody?.contactTestBitMask = scoreCategory
                player.instance.physicsBody?.collisionBitMask = enemyCategory
                
                // Определяет, что игра началась.
                gameStarted = true
                
                // Добавляет врагов на экран.
                timer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true, block: { (timer) in
                    self.enemy.spawn()
                })
            } else {
                // Устанавливает скорость объекта на ноль. (У нас будет проблема с гравитацией, если мы не установим ее на ноль)
                player.instance.physicsBody?.velocity = CGVector.zero
                
                // Применяет усиление, когда игрок касается экрана.
                player.instance.physicsBody?.applyImpulse(CGVector(dx: 0, dy: flyForce))
            }
        } else {
            // Перезапустите игру.
            if restart {
                
                
                restart = false
                gameViewController?.presentScene()
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        if gameStarted {
            // Устанавливает скорость оси Y.
            let yVelocity = player.instance.physicsBody!.velocity.dy * 0.001 as CGFloat
            
            // Применяйте «анимацию» к объекту для поворота при падении / получении импульса.
            player.instance.zRotation = yVelocity
            
        }
    }
    
}


extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        if gameStarted {
            // Увеличьте счет, если игрок преодолел препятствие или применил игру снова.
            if contact.bodyA.categoryBitMask == scoreCategory || contact.bodyB.categoryBitMask == scoreCategory {
                score.playerScore += 1
                score.scoreLabel.text = "\(score.playerScore)"
                addHighscore()
                self.sound.playScoreSound()
            } else if contact.bodyA.categoryBitMask == enemyCategory || contact.bodyB.categoryBitMask == enemyCategory {
                gameOver()
                self.sound.playGameOverSound()
            }
        }
    }
}
