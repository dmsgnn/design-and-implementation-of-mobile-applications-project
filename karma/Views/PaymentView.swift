//
//  PaymentView.swift
//  karma
//
//  Created by Tommaso Bucaioni on 03/01/23.
//

import SwiftUI
import Firebase

struct PaymentView: View {
    @State private var eurosSel = 0
    private var euros = [Int](0..<10000)
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: CollectionViewModel
    @ObservedObject var paymentViewModel = PaymentViewModel()

    
    init(collection: Collection) {
        self.viewModel = CollectionViewModel(collection: collection)
    }
    
    var body: some View {
        VStack {
            Picker(selection: self.$eurosSel, label: Text("")) {
                ForEach(0 ..< self.euros.count) { index in
                    Text("\(self.euros[index]) €").tag(index)
                }
            }
            .pickerStyle(.wheel)
            
            
            Button {
                paymentViewModel.makePayment(forCollection: viewModel.collection, ofAmount: Float(eurosSel))
            } label: {
                Text("PAY")
            }
        }
        .onReceive(paymentViewModel.$didMakePayment) { success in
            if success {
                print("payment of \(eurosSel) made")
                presentationMode.wrappedValue.dismiss()
            }
        }

    }

}

struct PaymentView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentView(collection: Collection(title: "Regalo di laurea ", caption: "Questa è una descrizione di prova per vedere se riesco a creare una collection View decente che mi possa piacere", amount: 30, currentAmount: 15, favourites: 0, participants: 6, collectionImageUrl: "ciao", timestamp: Firebase.Timestamp(date: Date.init()) , uid: "useridprova"))
    }
    
}
                
