//
//  EditProfileView.swift
//  karma
//
//  Created by Tommaso Bucaioni on 21/01/23.
//

import SwiftUI
import Kingfisher

struct EditProfileView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State private var fullname = ""
    @State private var username = ""
    @State private var email = ""
    
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var profileImage: Image?

    @EnvironmentObject var authVM: AuthViewModel
    @ObservedObject var viewModel: EditProfileViewModel
    
    
    init(user: User) {
        self.viewModel = EditProfileViewModel(user: user, service: UserService(), uploader: ImageUploader())
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Button {
                    showImagePicker.toggle()
                } label: {
                    if let profileImage = profileImage {
                        profileImage
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                    } else {
                        KFImage(URL(string: viewModel.user.profileImageUrl))
                            .resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                            .frame(width: 100, height: 100)
                    }
                }
                .sheet(isPresented: $showImagePicker, onDismiss: loadImage) {
                    ImagePicker(selectedImage: $selectedImage)
                }

                Divider()
                
                VStack {
                    HStack {
                        Text("Name:")
                            .padding(.trailing)
                        TextField(viewModel.user.fullname, text: $fullname)
  
                    }
                    Divider()
                        .padding(.bottom)
                    
                    HStack {
                        Text("Username:")
                            .padding(.trailing)
                        TextField(viewModel.user.username, text: $username).textInputAutocapitalization(.never).textCase(.lowercase)
                        
                    }
                    
                    Divider()
                        .padding(.bottom)
                    
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
                            if let selectedImage = selectedImage {
                                viewModel.editImage(selectedImage)
                                viewModel.updateUserData(fullname: fullname, username: username)
                            } else {
                                viewModel.updateUserData(fullname: fullname, username: username)
                            }
                        
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
    
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        profileImage = Image(uiImage: selectedImage)
        
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView(user: User(
            id: NSUUID().uuidString,
            username: "tombucaioni",
            fullname: "Tommaso Bucaioni",
            profileImageUrl: "",
            email: "tbucaioni@virgilio.it"))
    }
}
