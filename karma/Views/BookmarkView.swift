//
//  BookmarkView.swift
//  karma
//
//  Created by Tommaso Bucaioni on 19/01/23.
//

import SwiftUI

struct BookmarkView: View {
    
    @ObservedObject var viewModel = BookmarkViewModel()
    
    var body: some View {
        VStack {
            Text("Favourites")
                .font(.title)
                .fontWeight(.bold)

            ScrollView(.vertical, showsIndicators: false) {
                ForEach(viewModel.collections) { collections in
                    CollectionView(collection: collections)
                }
            }
        }
    }
}

struct BookmarkView_Previews: PreviewProvider {
    static var previews: some View {
        BookmarkView()
    }
}
