//
//  BookmarkView.swift
//  karma
//
//  Created by Tommaso Bucaioni on 19/01/23.
//

import SwiftUI

struct BookmarkView: View {
    
    @ObservedObject var viewModel = BookmarkViewModel(service: CollectionService())
    
    let layout = [
        GridItem(.adaptive(minimum: 300))
    ]
    
    var body: some View {
        if UIDevice.isIPad {
            NavigationStack {
                ZStack {
                    VStack {
                        HStack {
                            Text("Favourites")
                                .font(.title)
                                .fontWeight(.bold)
                        }
                        .padding()
                        
                        ScrollView(.vertical, showsIndicators: false) {
                            LazyVGrid(columns: layout, spacing: 30) {
                                ForEach(viewModel.collections) { collections in
                                    NavigationLink {
                                        SummaryCollectionView(collection: collections)
                                    } label: {
                                        CollectionView(collection: collections)
                                    }
                                    .onTapGesture {
                                        hideTabBar()
                                    }
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
        } else {
            NavigationStack {
                ZStack {
                    VStack {
                        HStack {
                            Text("Favourites")
                                .font(.title)
                                .fontWeight(.bold)
                            Spacer()
                        }
                        .padding(.leading)
                        .padding(.top, 3)
                        
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
}

struct BookmarkView_Previews: PreviewProvider {
    static var previews: some View {
        BookmarkView()
    }
}
