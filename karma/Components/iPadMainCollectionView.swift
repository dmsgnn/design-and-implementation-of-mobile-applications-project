//
//  iPadMainCollectionView.swift
//  karma
//
//  Created by Tommaso Bucaioni on 31/01/23.
//
import SwiftUI
import Kingfisher
import FirebaseFirestore

struct iPadMainCollectionView: View {
    
    @State private var orientation = UIDevice.current.orientation

    let collection: Collection
    
    init(collection: Collection) {
        self.collection = collection
    }
    
    var body: some View {
        VStack {
//                RoundedRectangle(cornerRadius: 10)
            KFImage(URL(string: collection.collectionImageUrl))
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .frame(width: 500, height: 400)
                .padding(.horizontal)
            
            Text(collection.title)
                .foregroundColor(.black)
                .font(.title2)
                .fontWeight(.semibold)
            
            Text(collection.caption)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(Color(.systemGray))
                .padding(.vertical, 20)
            
            HStack {
                
                if let user = collection.user {
                    HStack {
                        KFImage(URL(string: user.profileImageUrl))
                            .resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                            .frame(width: 35, height: 35)
                        
                        Text(user.username)
                            .foregroundColor(.black)
                            .font(.footnote)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    .padding(.leading, 20)
                    .frame(width: UIScreen.main.bounds.width*0.30)
                }
                
//                Spacer()
                VStack(alignment: .center) {
                    if (collection.currentAmount == collection.amount) {
                        Image(systemName: "checkmark.circle.fill").foregroundColor(Color(.systemGreen))
                    } else {
                        Text("\(String((collection.currentAmount*100/collection.amount).formatted(.number.precision(.fractionLength(0)))))%")
                            .foregroundColor(.black)
                    }
                    ProgressView(value:  collection.currentAmount/collection.amount)
                        .frame(width: 400)
                }
                .offset(y: -12)
                .frame(width: UIScreen.main.bounds.width*0.30)
                
//                Spacer()
                
                HStack {
                    Spacer()

                    Text("\(collection.timestamp.dateValue().formatted(date: .abbreviated, time: .omitted))")
                        .font(.footnote)
                        .fontWeight(.medium)
                        .foregroundColor(.black)
                        
                    
                }
                .padding(.trailing, 20)
                .frame(width: UIScreen.main.bounds.width*0.30)
            }
            .padding(.horizontal, 30)
            
            Spacer()
        }
        .padding(.vertical)
    }
}

struct iPadMainCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        iPadMainCollectionView(collection: Collection(title: "Regalo di laurea ", caption: "Questa è una descrizione di prova per vedere se riesco a creare una collection View decente che mi possa piacere", amount: 30, currentAmount: 15, favourites: 0, participants: 6, collectionImageUrl: "ciao", timestamp: FirebaseFirestore.Timestamp(date: Date.init()) , uid: "useridprova"))
    }
}
