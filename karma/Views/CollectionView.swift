//
//  Collection2View.swift
//  karma
//
//  Created by Tommaso Bucaioni on 26/12/22.
//

import SwiftUI

struct CollectionView: View {
    @ObservedObject var viewModel: CollectionViewModel
    
    init(collection: Collection) {
        self.viewModel = CollectionViewModel(collection: collection)
    }

    
    var body: some View {
    
        VStack(alignment: .center, spacing: 24) {
            HStack(spacing: 16) {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 60)
                    .shadow(radius: 5, x: 0, y: 5)
                
                VStack(alignment: .leading, spacing: 6) {
                    Text(viewModel.collection.title)
                        .font(.title2)
                        .fontWeight(.semibold)
                    Text(viewModel.collection.caption)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(Color(.systemGray2))
                }
                
                Button {
                    viewModel.addToFavourite()
                } label: {
                    Image(systemName: viewModel.collection.didLike ?? false ? "bookmark.fill" : "bookmark")
                    
                }
                .offset(x:-2, y: -35)
            }
            
            HStack() {
                HStack(spacing: 2) {
                    Image(systemName: "person")
                    Text("5 participants")
                }
                Spacer()
                HStack(spacing: 2){
                    Image(systemName: "eurosign")
                    Text("\(viewModel.collection.currentAmount)")
                }
                .font(.title3)
                .foregroundColor(Color(.darkGray))
            }
            .foregroundColor(Color(.systemGray))
            .font(.subheadline)
            .fontWeight(.bold)
            .padding(.horizontal, 25)
        }
        .frame(width: 300, height: 160)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

/*struct CollectionView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionView()
    }
}*/
