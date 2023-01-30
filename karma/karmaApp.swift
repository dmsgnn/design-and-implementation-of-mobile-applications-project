//
//  karmaApp.swift
//  karma
//
//  Created by Giovanni Demasi on 05/12/22.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseStorage

@main
struct karmaApp: App {
    
    @StateObject var viewModel = AuthViewModel(service: UserService(), uploader: ImageUploader())
    
    init() {
        FirebaseApp.configure()
        // Checking if unit tests are running
#if EMULATORS
          print("Setting up Firebase emulator localhost:8080")
          Auth.auth().useEmulator(withHost: "127.0.0.1", port: 9099)
          Storage.storage().useEmulator(withHost: "127.0.0.1", port: 9199)
          //Firestore.firestore().useEmulator(withHost: "127.0.0.1", port: 8080)
          let settings = Firestore.firestore().settings
          settings.host = "127.0.0.1:8080"
          settings.isPersistenceEnabled = false
          settings.isSSLEnabled = false
          Firestore.firestore().settings = settings
#endif
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

