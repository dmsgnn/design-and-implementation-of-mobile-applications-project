//
//  SearchView.swift
//  karma
//
//  Created by Tommaso Bucaioni on 05/01/23.
//

import SwiftUI
import Firebase

struct SearchView: View {
    @State private var selectedFilter: FilterSearchViewModel = .users
    @Namespace var animation
    
    @ObservedObject var viewModel = SearchViewModel()
    
    var body: some View {
        VStack {
            SearchBar(text: $viewModel.searchText)
                .padding()
            
            HStack {
                ForEach(FilterSearchViewModel.allCases, id: \.self) { item in
                    VStack {
                        Text(item.title)
                            .font(.subheadline)
                            .fontWeight(selectedFilter == item ? .semibold : .regular)
                            .foregroundColor(selectedFilter == item ? .black : .gray)
                        
                        if selectedFilter == item {
                            Capsule()
                                .foregroundColor(.black)
                                .frame(height: 3)
                                .matchedGeometryEffect(id: "filter", in: animation)
                        } else {
                            Capsule()
                                .foregroundColor(.clear)
                                .frame(height: 3)
                        }
                    }
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            self.selectedFilter = item
                        }
                    }
                }
            }
            
            ScrollView {
                if selectedFilter == .users {
                    LazyVStack {
                        ForEach(viewModel.searchableUsers) { user in
                            NavigationLink {
                                ProfileView(user: user)
                            } label: {
                                VStack {
                                    UserRowView(user: user)
                                }
                            }
                            .foregroundColor(.black)
                            
                        }
                    }
                } else {
                    LazyVStack {
                        ForEach(viewModel.searchableCollections) { collection in
                            NavigationLink {
                                SummaryCollectionView(collection: collection)
                            } label: {
                                VStack {
                                    CollectionRowView(collection: collection)
                                }
                            }
                            .foregroundColor(.black)
                            
                        }
                    }
                    
                }
                
            }
    
            
        }
        .background(Color.theme.custombackg)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
