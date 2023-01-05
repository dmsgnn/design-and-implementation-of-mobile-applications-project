//
//  SearchView.swift
//  karma
//
//  Created by Tommaso Bucaioni on 05/01/23.
//

import SwiftUI
import Firebase

struct SearchView: View {
    @State private var searchText = ""
    
    var body: some View {
        VStack {
            SearchBar(text: $searchText)
                .padding()
            ScrollView {
                LazyVStack {
                    ForEach(0...5, id: \.self) { result in
                        NavigationLink {
                            Text("ciao ciao")
                        } label: {
                            VStack {
                                UserRowView()
                                
                                CollectionRowView()
                            }
                        }
                        .foregroundColor(.black)

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
