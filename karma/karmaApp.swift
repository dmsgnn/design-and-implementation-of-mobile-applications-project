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
            //NavigationView {
                ImageUploaderView() //Replace it with dashboardView
                
            }
            //.environmentObject(viewModel)
        }
    //}
}
