//
//  GameViewController.swift
//  Sun Wave
//
//  Created by VYSHNEVSKYI on 19.06.2020.
//  Copyright © 2020 _vyshnevskyi. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import AVFoundation
import GoogleMobileAds

class GameViewController: UIViewController, GADBannerViewDelegate, GADInterstitialDelegate {
    
    var musicPlayer: AVAudioPlayer!
    var stage: SKView!
    
    var bannerView: GADBannerView!
    var interstitial: GADInterstitial!
    
    override func viewDidLoad() {
           super.viewDidLoad()
        
        stage = (view as! SKView)
        stage.ignoresSiblingOrder = true
        stage.showsFPS = false
        stage.showsNodeCount = false
           
        presentScene()
        playMusic()
        
        createBanner ()
        
        interstitial = createAndLoadInterstitial()
        
        NotificationCenter.default.addObserver(self, selector: #selector(GameViewController.presentInterstitial) , name: NSNotification.Name("presentInterstitial"), object: nil)
        
        }
    
    func presentScene() {
        // Применить игровой экран.
        let scene = GameScene(size: CGSize(width: 320, height: 568))
        scene.scaleMode = .aspectFill
        scene.gameViewController = self
        stage.presentScene(scene, transition: .flipHorizontal(withDuration: 0.5))
    }
    
    func playMusic() {
           // Применяет фоновую музыку.
        let pathToSound = Bundle.main.path(forResource: "sound", ofType: "mp3")
        
        let url = URL(fileURLWithPath: pathToSound!)
        
        do {
               musicPlayer = try! AVAudioPlayer(contentsOf: url)
               musicPlayer.numberOfLoops = -1
               musicPlayer.volume = 0.5
               musicPlayer.play()
            
        } 
       }
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
         bannerView.alpha = 0
         UIView.animate(withDuration: 1, animations: {
           bannerView.alpha = 1
         })
       }
       
    func createBanner () {
           bannerView = GADBannerView(frame: CGRect(x: view.center.x / kGADAdSizeBanner.size.width, y: view.frame.size.height - kGADAdSizeBanner.size.height, width: kGADAdSizeBanner.size.width, height: kGADAdSizeBanner.size.height))
           bannerView.adUnitID = AD_MOB_SUNWAVE
           bannerView.rootViewController = self
           bannerView.delegate = self

           let request = GADRequest()
           bannerView.load(request)

           view.addSubview(bannerView)
       }
    
    
    @objc func presentInterstitial() {
         if interstitial.isReady {
           interstitial.present(fromRootViewController: self)
         } else {
           print("Ad wasn't ready")
         }
    }
    
    func createAndLoadInterstitial() -> GADInterstitial {
        let interstitial = GADInterstitial(adUnitID: AD_MOB_INTER_SUNVAWE)
        interstitial.delegate = self
        interstitial.load(GADRequest())
      return interstitial
    }

    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
      interstitial = createAndLoadInterstitial()
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}

