//
//  CollectionRowView.swift
//  karma
//
//  Created by Tommaso Bucaioni on 05/01/23.
//

import SwiftUI
import Firebase
import Kingfisher
import FirebaseFirestore

struct CollectionRowView: View {
    
    let collection: Collection
    
    init(collection: Collection){
        self.collection = collection
    }
    
    var body: some View {
        HStack {
            KFImage(URL(string: collection.collectionImageUrl))
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 60)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        
            if let user = collection.user {
                
                VStack(alignment: .leading, spacing: 6){
                    Text(collection.title)
                        .font(.headline).bold()
                    Text(user.username)
                        .font(.footnote)
                }
            }
            
            Spacer()
            
            VStack(alignment: .center) {
                Text("Money Raised:")
                    .font(.footnote)
                
                Text("€\(String(collection.currentAmount.formatted(.number.precision(.fractionLength(2))))) of €\(String(collection.amount.formatted(.number.precision(.fractionLength(0)))))")
                    .font(.subheadline).bold()
                    .id("status")
            }
            

        }
        .padding()
    }
}

struct CollectionRowView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionRowView(collection: Collection(title: "Regalo di laurea ", caption: "Questa è una descrizione di prova per vedere se riesco a creare una collection View decente che mi possa piacere", amount: 30, currentAmount: 15, favourites: 0, participants: 6, collectionImageUrl: "ciao", timestamp: FirebaseFirestore.Timestamp(date: Date.init()) , uid: "useridprova"))
    }
}
