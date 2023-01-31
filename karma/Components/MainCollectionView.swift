//
//  MainCollectionView.swift
//  karma
//
//  Created by Tommaso Bucaioni on 28/01/23.
//

import SwiftUI
import Kingfisher
import Firebase
import FirebaseFirestore

struct MainCollectionView: View {
    let collection: Collection
    
    init(collection: Collection){
        self.collection = collection
    }
    
    var body: some View {
        
        HStack(spacing: 2){
//                        RoundedRectangle(cornerRadius: 10)
            KFImage(URL(string: collection.collectionImageUrl))
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .frame(width: 100, height: 100)
                .padding(.leading, 20)
            
            
            
            VStack(alignment: .leading, spacing: 5) {
                Text("\(collection.timestamp.dateValue().formatted(date: .abbreviated, time: .omitted))")
                    .font(.footnote)
                    .fontWeight(.medium)
                    .foregroundColor(Color(.systemGray))
                
                Text(collection.title)
                    .font(.title2)
                    .fontWeight(.semibold)
                //                        .padding(.bottom, 2)
                    .lineLimit(1)
                    .foregroundColor(.black)
                    .id("CollTitle")
                
                
                
                //                    Text(collection.caption)
                //                        .font(.headline)
                //                        .fontWeight(.semibold)
                //                        .foregroundColor(Color(.systemGray2))
                //                        .lineLimit(1)
                //                        .multilineTextAlignment(.leading)
                if let user = collection.user {
                    Text(user.username)
                        .foregroundColor(.black)
                        .font(.footnote)
                }
                
                HStack {
                    ProgressView(value: collection.currentAmount/collection.amount)
                        .frame(width: 100)
                    
                    
                    if (collection.currentAmount == collection.amount) {
                        Image(systemName: "checkmark.circle.fill").foregroundColor(Color(.systemGreen))
                    } else {
                        Text("\(String((collection.currentAmount*100/collection.amount).formatted(.number.precision(.fractionLength(0)))))%")
                            .foregroundColor(.black)
                            .fontWeight(.medium)
                    }
                }
            }
            .padding(.vertical)
            .padding(.horizontal)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            
            //            }
            
            
            //            Text("\(collection.currentAmount / collection.amount * 100, specifier: "%.1f") %")
            //                .font(.title2)
            //                .fontWeight(.semibold)
            //                .padding(.trailing, 20)
            //                .foregroundColor(.black)
            
            //                                        ProgressBar(progress: (collection.currentAmount / collection.amount * 100))
            //                                            .frame(width: 30.0, height: 30.0)
            
            //.offset(y: -14)
        }
    }
    
}

struct MainCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        MainCollectionView(collection: Collection(title: "Regalo di laurea ", caption: "Questa è una descrizione di prova per vedere se riesco a creare una collection View decente che mi possa piacere", amount: 30, currentAmount: 15, favourites: 0, participants: 6, collectionImageUrl: "ciao", timestamp: FirebaseFirestore.Timestamp(date: Date.init()) , uid: "useridprova"))
    }
}
