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
        Group{
            if viewModel.userSession == nil {
                LoginView()
            } else if let user = viewModel.currentUser {
                MainView(user: user)
            }
            
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let myEnvObject = AuthViewModel()
        ContentView().environmentObject(myEnvObject)
    }
}
