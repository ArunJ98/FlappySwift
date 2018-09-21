//
//  AppDelegate.swift
//  FlappyBird
//
//  Created by Nate Murray on 6/2/14.
//  Copyright (c) 2014 Fullstack.io. All rights reserved.
//

import UIKit
import Skillz
import SpriteKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, SkillzDelegate {
                            
    var window: UIWindow?
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        //If your app uses portrait:
        return .portrait
    }

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // INITIALIZE SKILLZ HERE
        
        // This class will depend on where the SkillzDelegate is implemented
        // In this case, it's AppDelegate
        let delegate: AppDelegate? = self
        
        // 156 is the game ID that was given to us by the Skillz Developer Portal.
        // SkillzSandbox specifies that we will use the sandbox server since we
        // are still developing the game.
        // SkillzProduction specifies that we will use the production server since
        // the game is ready for release to the AppStore
        
        Skillz.skillzInstance().initWithGameId("5226", for: delegate, with: SkillzEnvironment.sandbox, allowExit: false)
        Skillz.skillzInstance().launch()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        print("Player is quitting the game.")
        if Skillz.skillzInstance().tournamentIsInProgress {
            // We are in a Skillz tournament, so abort the game using Skillz API
            // This will report an auto-loss to the Skillz server,
            // and return the player to the Skillz portal.
            Skillz.skillzInstance().notifyPlayerAbort(completion: {
                // Code in this block is run when Skillz aborts the game,
                // reports a forfeiture to the server,
                // and returns to the Skillz portal.
                // This can typically be used to clean up/reset the game.
                print("Player is forfeiting the game")
            })
        }

    }
    
    
    func tournamentWillBegin(_ gameParameters: [AnyHashable : Any]?, with: SKZMatchInfo?) {
        // This code is called when a player starts a game in the Skillz portal.
        if let aParameters = gameParameters {
            print("Game Parameters: \(aParameters)")
        }
        print("Now starting a game…")
        // INCLUDE CODE HERE TO START YOUR GAME
        let viewController = GameViewController()
        viewController.startGame()
        // END OF CODE TO START GAME
    }
    
    func skillzWillExit() {
        // This code is called when exiting the Skillz portal
        //back to the normal game.
        print("Skillz exited.")
    }


}

