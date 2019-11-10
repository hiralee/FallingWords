//
//  AppDelegate.swift
//  FallingWordsApp
//
//  Created by hiralee malaviya on 09.11.19.
//  Copyright © 2019 hiralee malaviya. All rights reserved.
//

import UIKit
import GameEngine

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var game: Game<NavigationControllerRouter>?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let wordsFactory = WordsFactory()
        let wordWrapper = wordsFactory.fetchQuestions(count: 5, fetch: .local)
        
        let navigationController = UINavigationController()
        let factory = ViewControllerFactory(questions: wordWrapper.questions, correctAnswers: wordWrapper.correctAnswers)
        let router = NavigationControllerRouter(navigationController, factory: factory)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        game = startGame(questions: wordWrapper.questions, router: router, correctAnswers: wordWrapper.correctAnswers)
        
        return true
    }

}

