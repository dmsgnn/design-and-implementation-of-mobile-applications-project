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
    @State private var collectionImage: Image?
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var viewModel = UploadCollectionViewModel()
    @EnvironmentObject var collectionVM: CollectionViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    Button {
                        showImagePicker.toggle()
                    } label: {
                        if let collectionImage = collectionImage {
                            collectionImage
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
                    
                    TextField("give your collection a title", text: $title)
                    
                    Divider()
                        .padding(.bottom)
                    
                    Text("Description")
                        .font(.headline)
                        .fontWeight(.semibold)
                        
                    
                    TextField("say something about this collection", text: $description, axis: .vertical)
                        .lineLimit(4, reservesSpace: true)
                        
                    
                }
                .frame(width: UIScreen.main.bounds.width*0.9)
                
                .padding(.horizontal)
                
                Spacer()
                Divider().padding(.horizontal)
     
                
                Text("Set your amount...")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Picker(selection: self.$eurosSel, label: Text("")) {
                    ForEach(0 ..< self.euros.count) { index in
                        Text("\(self.euros[index]) €").tag(index)
                    }
                }
                .pickerStyle(.wheel)
                
                
                //            TextField("€ 0.00 ", value: $amount, formatter: numberFormatter)
                //                .keyboardType(.numberPad)
                //
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: ToolbarItemPlacement.principal) {
                    Text("New Collection")
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
                    if (title == "" || description == "" || eurosSel == 0 || selectedImage == nil) {
                        Button {
                            
                        } label: {
                            Text("Share")
                                .bold()
                                .padding(.horizontal)
                                .padding(.vertical, 10)
                                .background(Color(.systemBlue).opacity(0.3))
                                .foregroundColor(.white)
                                .clipShape(Capsule())
                        }
                    } else {
                        Button {
                            viewModel.uploadCollection(withTitle: title, withCaption: description, withAmount: Float(eurosSel), withImage: selectedImage!)
                        } label: {
                            Text("Share")
                                .bold()
                                .padding(.horizontal)
                                .padding(.vertical, 10)
                                .background(Color(.systemBlue))
                                .foregroundColor(.white)
                                .clipShape(Capsule())
                            
                            
                        }
                    }
                }
            }
            .onReceive(viewModel.$didUploadCollection) { success in
                if success {
                    print("\(eurosSel)")
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
        
    }
    
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        collectionImage = Image(uiImage: selectedImage)
    }
}

struct UploadCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        UploadCollectionView()
    }
}
