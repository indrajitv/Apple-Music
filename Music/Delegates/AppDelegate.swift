//
//  AppDelegate.swift
//  Indrajit
//
//  Created by Indrajit Chavda on 20/12/20.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        Thread.sleep(forTimeInterval: 0.5) // Here we want to show splash screen for while before showing home/main screen.
        configureNavigationAppearance()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    /// It will set app navigation appearance on launch of the application.
    private func configureNavigationAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
    
        var titleTextAttributes:[NSAttributedString.Key:Any] =  [.foregroundColor: AppColor.theme.color1, .font:AppFont.get(font: .bold, size: .h3)]
        appearance.largeTitleTextAttributes = titleTextAttributes
        
        titleTextAttributes[.font] = AppFont.get(font: .bold, size: .h4)
        appearance.titleTextAttributes = titleTextAttributes
        
        UINavigationBar.appearance().tintColor = AppColor.theme.color2
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().prefersLargeTitles = true
    }

}
