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
    
    @State var isPickerShowing = false
    @State var selectedImage: UIImage?

    var body: some View {
        VStack {
            if selectedImage != nil {
                Image(uiImage: selectedImage!)
                    .resizable()
                    .frame(width: 100, height: 100)
            }
            Button {
                isPickerShowing = true
                //show the image picker
            } label: {
                Text("select a photo")
            }
            
            if selectedImage != nil {
                Button {
                    uploadPhoto()
                } label: {
                    Text("Upload photo")
                }
            }
        }
        .sheet(isPresented: $isPickerShowing, onDismiss: nil) {
            //image picker
            ImagePicker(selectedImage: $selectedImage, isPickerShowing: $isPickerShowing)
        }
        
    }
    
    func uploadPhoto() {
        
        //Make sure that the selectede image property isn't nil
        guard selectedImage != nil else {
            return
        }
        //create storage reference
        let storageRef = Storage.storage().reference()
        
        //Turn our image into data
        let imageData = selectedImage?.jpegData(compressionQuality: 0.5)
        
        //check we were able to convert its to data
        guard imageData != nil else {
            return
        }
        
        //specify the file path and name
        
        let path = "images/\(UUID().uuidString).jpg"
        let fileRef = storageRef.child("images/\(UUID().uuidString).jpg")
        
        //Upload that data
        let uploadTask = fileRef.putData(imageData!, metadata: nil) {
            metadata, error in
            
            if error == nil && metadata != nil {
                
                //Save a reference to the file in Firestore DB
                let db = Firestore.firestore()
                db.collection("images").document().setData(["url":path])
            }
        }
    
    }
    
   
    
    
}

struct ImageUploaderView_Previews: PreviewProvider {
    static var previews: some View {
        ImageUploaderView()
    }
}
