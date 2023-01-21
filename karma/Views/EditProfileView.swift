//
//  EditProfileView.swift
//  karma
//
//  Created by Tommaso Bucaioni on 21/01/23.
//

import SwiftUI

struct EditProfileView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State private var fullname = ""
    @State private var username = ""
    @State private var email = ""
    
    @ObservedObject var viewModel = EditProfileViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                Circle()
                    .frame(width: 80, height: 80)
                    .padding()
                
                Divider()
                
                VStack {
                    HStack {
                        Text("Name:")
                            .padding(.trailing)
                        TextField("Name", text: $fullname)
  
                    }
                    Divider()
                        .padding(.bottom)
                    
                    HStack {
                        Text("Username:")
                            .padding(.trailing)
                        TextField("Username", text: $username)
                        
                    }
                    
                    Divider()
                        .padding(.bottom)
                    
//                    HStack {
//                        Text("Email:")
//                            .padding(.trailing)
//                        TextField("Email", text: $email)
//                    }
//                    
//                    Divider()
                }
                .padding()
                
                Spacer()
                
                
            }
            .toolbar {
                ToolbarItem(placement: ToolbarItemPlacement.principal) {
                    Text("Edit Profile")
                        .font(.title3)
                        .fontWeight(.semibold)
                }
                
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarLeading) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Cancel")
                            .foregroundColor(.black)
                    }
                }
                
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                    Button {
                        viewModel.updateUserData(fullname: fullname, username: username)
                    } label: {
                        Text("Done")
                            .bold()
                    }
                }
                
            }
            .navigationBarBackButtonHidden(true)
        }
        .onReceive(viewModel.$didEditProfile) { success in
            if success {
                presentationMode.wrappedValue.dismiss()
            }
        }
        
        
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
