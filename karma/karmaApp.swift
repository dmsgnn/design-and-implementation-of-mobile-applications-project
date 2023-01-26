//
//  karmaApp.swift
//  karma
//
//  Created by Giovanni Demasi on 05/12/22.
//

import SwiftUI
import Firebase
import UserNotifications

@main
struct karmaApp: App {
    
    @StateObject var viewModel = AuthViewModel()
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    
//    init() {
//        FirebaseApp.configure()
//        
//    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
                
            }
            .environmentObject(viewModel)
        }
    
    }
}
