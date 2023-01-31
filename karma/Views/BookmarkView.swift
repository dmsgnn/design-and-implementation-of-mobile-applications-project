//
//  BookmarkView.swift
//  karma
//
//  Created by Tommaso Bucaioni on 19/01/23.
//

import SwiftUI

struct BookmarkView: View {
    
    @ObservedObject var viewModel = BookmarkViewModel(service: CollectionService())
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.theme.custombackg.ignoresSafeArea()
                VStack {
                    HStack {
                        Text("Favourites")
                            .font(.title)
                            .fontWeight(.bold)
                        Spacer()
                    }
                    .padding(.leading)
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        ForEach(viewModel.collections) { collections in
                            NavigationLink {
                                SummaryCollectionView(collection: collections)
                            } label: {
                                CollectionView(collection: collections)
                            }

                            
                        }
                    }
                    Spacer().frame(height: 60)
                    
                }
            }
            .refreshable {
                viewModel.fetchCollections()
        }
        }
    }
}

struct BookmarkView_Previews: PreviewProvider {
    static var previews: some View {
        BookmarkView()
    }
}
