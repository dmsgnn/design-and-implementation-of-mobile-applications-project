//
//  SearchView.swift
//  karma
//
//  Created by Tommaso Bucaioni on 05/01/23.
//

import SwiftUI
import Firebase

struct SearchView: View {
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack {
                    ForEach(0...5, id: \.self) { result in
                        NavigationLink {
                            Text("ciao ciao")
                        } label: {
                            CollectionView(collection: Collection(title: "Regalo di laurea ", caption: "Questa è una descrizione di prova per vedere se riesco a creare una collection View decente che mi possa piacere", amount: 30, currentAmount: 15, favourites: 0, participants: 6, collectionImageUrl: "ciao", timestamp: Firebase.Timestamp(date: Date.init()) , uid: "useridprova"))
                        }

                    }
                }
            }.background(Color.theme.custombackg)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
