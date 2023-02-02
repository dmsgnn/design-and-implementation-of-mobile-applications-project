//
//  EditCollectionView.swift
//  karma
//
//  Created by Tommaso Bucaioni on 24/01/23.
//

import SwiftUI
import Kingfisher
import Firebase
import FirebaseFirestore

struct EditCollectionView: View {
    
    @State private var title = ""
    @State private var description = ""
    
    @State private var euroSel = 0
    
    private var euros = [Int](0..<10000)
    
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var collectionImage: Image?
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var viewModel: EditCollectionViewModel

    
    init(collection: Collection) {
        self.viewModel = EditCollectionViewModel(collection: collection, service: CollectionService(), uploader: ImageUploader())
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Button {
                    showImagePicker.toggle()
                } label: {
                    if let collectionImage = collectionImage {
                        collectionImage
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIDevice.isIPad ? 500 : 80, height: UIDevice.isIPad ? 400 : 80)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    } else {
                        KFImage(URL(string: viewModel.collection.collectionImageUrl))
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIDevice.isIPad ? 500 : 80, height: UIDevice.isIPad ? 400 : 80)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
                .sheet(isPresented: $showImagePicker, onDismiss: loadImage) {
                    ImagePicker(selectedImage: $selectedImage)
                }
                
    
                
                VStack(alignment: .leading) {
                    
                    Text("Title")
                        .font(.headline)
                        .padding(.top, 5)
                        .fontWeight(.semibold)
                        .id("Title")
                    
                    TextField(viewModel.collection.title, text: $title)
                    
                    Divider()
                        .padding(.bottom)
                    
                    
                    Text("Description")
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    TextField(viewModel.collection.caption, text: $description, axis: .vertical)
                        .lineLimit(4, reservesSpace: true)
                    
                    Divider()
                        .padding(.bottom)
                    
                }
                .frame(width: UIScreen.main.bounds.width*0.9)
                .padding(.horizontal)
                
                Spacer().frame(width: 2, height: UIDevice.isIPad ? 100 : 20)
                
                Text("Set your new amount...")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Picker(selection: self.$euroSel, label: Text("")) {
                    ForEach(0 ..< self.euros.count) { index in
                        Text("\(self.euros[index]) €").tag(index)
                    }
                }
                .pickerStyle(.wheel)
                
            }
            .toolbar {
                ToolbarItem(placement: ToolbarItemPlacement.principal) {
                    Text("Edit Collection")
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
                                viewModel.updateCollectionData(title: title, description: description, amount: Float(euroSel))
                            } else {
                                viewModel.updateCollectionData(title: title, description: description, amount: Float(euroSel))
                            }
                        
                        } label: {
                            Text("Done")
                                .bold()
                        }
                    
                }
                
            }
            .navigationBarBackButtonHidden(true)
        }
        .onReceive(viewModel.$didEditCollection) { success in
            if success {
                presentationMode.wrappedValue.dismiss()
            }
        }
        
        
    }
    
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        collectionImage = Image(uiImage: selectedImage)
        
    }
        
}

struct EditCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        EditCollectionView(collection: Collection(title: "Regalo di laurea ", caption: "Questa è una descrizione di prova per vedere se riesco a creare una collection View decente che mi possa piacere", amount: 30, currentAmount: 20, favourites: 0, participants: 6, collectionImageUrl: "ciao", timestamp: FirebaseFirestore.Timestamp(date: Date.init()) , uid: "useridprova"))
    }
}
