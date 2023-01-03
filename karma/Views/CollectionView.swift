//
//  Collection2View.swift
//  karma
//
//  Created by Tommaso Bucaioni on 26/12/22.
//

import SwiftUI
import Kingfisher
import Firebase

struct CollectionView: View {
    @ObservedObject var viewModel: CollectionViewModel
    private var percentage = 0.00
    @State private var popup = false
    
    init(collection: Collection) {
        self.viewModel = CollectionViewModel(collection: collection)
        self.percentage = viewModel.collection.currentAmount/viewModel.collection.amount

    }
    
    
    var body: some View {
        
        VStack(alignment: .leading) {
            HStack(alignment: .center, spacing: 20) {
                KFImage(URL(string: viewModel.collection.collectionImageUrl ?? ""))
                    .resizable()
                    .scaledToFill()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .frame(width: 80, height: 50)
                
                Text(viewModel.collection.title)
                    .font(.title2)
                    .fontWeight(.semibold)
                

            }
            
            Text(viewModel.collection.caption)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(Color(.systemGray2))
                .frame(maxHeight: 80)
            
            HStack {
                Text("23 Mar 2022")
                    .font(.footnote)
                ProgressView(value: percentage )
                    .frame(width: 75)
                Text("\(round(percentage*100))") ///still to modify
                    .font(.footnote)
                Spacer()
                
            }
            .padding(.bottom, 16)
    
            HStack {
                Button(action: {
                    viewModel.collection.didLike ?? false ? viewModel.removeFromFavourite() : viewModel.addToFavourite()
                }, label: {
                    Image(systemName: viewModel.collection.didLike ?? false ? "heart.fill" : "heart")
                        .foregroundColor(.black)
                })
                .padding(.trailing, 6)
                
                Image(systemName: "square.and.arrow.up")
                    .padding(.trailing, 6)
                Image(systemName: "ellipsis")
                    .padding(.trailing, 6)
                Spacer()
                Button {
                    popup.toggle()
                } label: {
                    Text("Donate")
                        .foregroundColor(.white)
                        .frame(width: 90, height: 30)
                        .background(Color(.systemBlue))
                        .clipShape(Capsule())
                        
        
        
                }

            }
            
        }
        .padding()
        .frame(width: UIScreen.main.bounds.size.width*0.9, height: 230)
        .background(Color(.white))
        .clipShape(RoundedRectangle(cornerRadius: 15))
        
    }
}
                
        

struct CollectionView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionView(collection: Collection(title: "Regalo di laurea ", caption: "Questa è una descrizione di prova per vedere se riesco a creare una collection View decente che mi possa piacere", amount: 30, currentAmount: 15, favourites: 0, participants: 6, collectionImageUrl: "ciao", timestamp: Firebase.Timestamp(date: Date.init()) , uid: "useridprova"))
    }
}
