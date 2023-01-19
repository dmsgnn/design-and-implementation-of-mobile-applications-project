//
//  NewCollectionView.swift
//  karma
//
//  Created by Tommaso Bucaioni on 28/12/22.
//

import SwiftUI

struct UploadCollectionView: View {
    @State private var title = ""
    @State private var description = ""
    
    @State private var eurosSel = 0
    
    private var euros = [Int](0..<10000)
    
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var profileImage: Image?
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var viewModel = UploadCollectionViewModel()
    @EnvironmentObject var collectionVM: CollectionViewModel
    
   
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Cancel")
                        .foregroundColor(Color(.systemBlue))
                }
                Spacer()
                
                Button {
                    viewModel.uploadCollection(withTitle: title, withCaption: description, withAmount: Float(eurosSel), withImage: selectedImage!)
                    
                } label: {
                    Text("Publish")
                        .bold()
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                        .background(Color(.systemBlue))
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                }
                
            }
            .padding()
            
            VStack {
                Button {
                    showImagePicker.toggle()
                } label: {
                    if let profileImage = profileImage {
                        profileImage
                            .resizable()
                            .scaledToFill()
                            .frame(width: 180, height: 180)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    } else {
                        VStack{
                            Image(systemName: "plus.circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .foregroundColor(Color(.systemGray))
                            
                            Text("Add photo")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(Color(.systemGray))
                        }
                        .padding(.bottom, 20)
                        
                    }
                }
                .sheet(isPresented: $showImagePicker, onDismiss: loadImage) {
                    ImagePicker(selectedImage: $selectedImage)
                }
                
            }
            .padding(.bottom, 10)
            
            VStack(alignment: .leading) {
                Text("Title")
                    .font(.headline)
                    .fontWeight(.semibold)
                
                TextArea("give your collection a title", text: $title)
                    .frame(maxHeight: 40)
                Divider().padding(.horizontal)
                    
                
            }
            .padding(.leading)
            .padding(.bottom, 24)
            
            
            VStack(alignment: .leading) {
                Text("Description")
                    .font(.headline)
                    .fontWeight(.semibold)
                
                TextArea("say something about this collection", text: $description)
                    .frame(maxHeight: 150)
                Divider().padding(.horizontal)
            }
            .padding(.leading)
            .padding(.bottom, 36)
            
            //toggle for private
            
            
            Text("Set your amount...")
                .font(.title2)
                .fontWeight(.semibold)
            
            Picker(selection: self.$eurosSel, label: Text("")) {
                ForEach(0 ..< self.euros.count) { index in
                    Text("\(self.euros[index]) €").tag(index)
                }
            }
            .pickerStyle(.wheel)
            .frame(height: 80)
           
//            TextField("€ 0.00 ", value: $amount, formatter: numberFormatter)
//                .keyboardType(.numberPad)
//
            Spacer()
        }
        .onReceive(viewModel.$didUploadCollection) { success in
            if success {
                print("\(eurosSel)")
                presentationMode.wrappedValue.dismiss()
            }
        }
    
    }
    
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        profileImage = Image(uiImage: selectedImage)
    }
}

struct UploadCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        UploadCollectionView()
    }
}
