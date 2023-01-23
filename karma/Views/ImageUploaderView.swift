//
//  ImageUploaderView.swift
//  karma
//
//  Created by Tommaso Bucaioni on 29/12/22.
//

import SwiftUI
import FirebaseStorage
import FirebaseFirestore

struct ImageUploaderView: View {
    
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var profileImage: Image?
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        
        VStack {
            Button {
                showImagePicker.toggle()
            } label: {
                if let profileImage = profileImage {
                    profileImage
                        .resizable()
                        .scaledToFill()
                        .frame(width: 180, height: 180)
                        .clipShape(Circle())
                } else {
                    VStack {
                        Image(systemName: "plus.circle")
                            .resizable()
                            .renderingMode(.template)
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .padding(.bottom)
                        Text("select a photo")
                    }
                }
            }
            .sheet(isPresented: $showImagePicker, onDismiss: loadImage) {
                ImagePicker(selectedImage: $selectedImage)
            }
            
            if let selectedImage = selectedImage {
                Button {
                    viewModel.uploadImage(selectedImage)
                } label: {
                    Text("Continue")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.size.width*0.8, height: 50)
                        .background(Color.theme.dark)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                }
            }
        }
    }
    
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        profileImage = Image(uiImage: selectedImage)
        
    }

}

struct ImageUploaderView_Previews: PreviewProvider {
    static var previews: some View {
        ImageUploaderView()
    }
}
