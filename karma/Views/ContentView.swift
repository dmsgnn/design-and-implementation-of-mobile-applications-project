//
//  ContentView.swift
//  karma
//
//  Created by Giovanni Demasi on 05/12/22.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        Group {
            if viewModel.userSession == nil {
                
                //TODO: Remember to change to LoginView()
                RegistrationView()
            } else {
                //MainPageView()
                VStack {
                    Image(systemName: "globe")
                        .imageScale(.large)
                        .foregroundColor(.accentColor)
                    Text("Hello, world!")
                    
                    Button {
                        viewModel.signOut()
                    } label: {
                        Text("Sign Out")
                    }
                }
                .padding()
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
