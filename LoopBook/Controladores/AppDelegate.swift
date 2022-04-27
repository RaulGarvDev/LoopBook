//
//  AppDelegate.swift
//  LoopBook
//
//  Created by raul gonzalez de la aleja ruiz valdepeñas on 26/4/21.
//

import UIKit
import Firebase
import GoogleSignIn
import FacebookCore


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        FirebaseApp.configure()
        
        ApplicationDelegate.shared.application(
            application,
            didFinishLaunchingWithOptions: launchOptions
        )

        return true
    }
          
    func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {
      
        var handled: Bool

         handled = GIDSignIn.sharedInstance.handle(url)
         if handled {
           return true
         }

        
        ApplicationDelegate.shared.application(
            app,
            open: url,
            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
            annotation: options[UIApplication.OpenURLOptionsKey.annotation]
        )
        
        return true
    }
    
    
}

   







