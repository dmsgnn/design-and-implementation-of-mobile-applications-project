//
//  karmaApp.swift
//  karma
//
//  Created by Giovanni Demasi on 05/12/22.
//

import SwiftUI
import Firebase

@main
struct karmaApp: App {
    
    @StateObject var viewModel = AuthViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            // MARK: iPad
            if UIDevice.isIPad {
                NavigationView {
                    ContentView()
                }
                .environmentObject(viewModel)
                .navigationViewStyle(StackNavigationViewStyle())
                
            }
            // MARK: iPhone
            else{
                NavigationView {
                    ContentView()
                }
                .environmentObject(viewModel)
            }
        }
    }
}

extension UIDevice {
    static var isIPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
    
    static var isIPhone: Bool {
        UIDevice.current.userInterfaceIdiom == .phone
    }
}

