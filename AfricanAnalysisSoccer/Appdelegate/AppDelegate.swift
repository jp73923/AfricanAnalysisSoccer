//
//  AppDelegate.swift
//  YoungSportEvent
//
//  Created by VinMac on 29/05/22.
//

import UIKit
import AVFoundation

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    //MARK: - IBOutlets
    var window: UIWindow?
    var appNavigation:UINavigationController?
    var player:AVAudioPlayer?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        Thread.sleep(forTimeInterval: 3.0)
        self.initialVC()
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        hideLoaderHUD()
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        
    }

    //MARK: - InitialVC Method
    func initialVC() {
        APP_DELEGATE.appNavigation = UINavigationController(rootViewController: loadVC(strStoryboardId: SB_MAIN, strVCId: idLeagueVC))
        APP_DELEGATE.appNavigation?.isNavigationBarHidden = true
        APP_DELEGATE.window?.rootViewController = APP_DELEGATE.appNavigation
        self.playBGAudio()
    }
    
    func playBGAudio() {
        if let path = Bundle.main.path(forResource: "BG", ofType: "mp3") {
            let filePath = NSURL(fileURLWithPath:path)
            self.player = try! AVAudioPlayer.init(contentsOf: filePath as URL)
            self.player?.numberOfLoops = -1 //logic for infinite loop
            self.player?.prepareToPlay()
            self.player?.play()
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        try!audioSession.setCategory(AVAudioSession.Category.playback, options: .mixWithOthers)
    }
}

