//
//  PaymentView.swift
//  karma
//
//  Created by Tommaso Bucaioni on 03/01/23.
//

import SwiftUI
import Firebase

struct PaymentView: View {
    @ObservedObject var viewModel: CollectionViewModel

    @State private var total:Float = 0.00
    private let numberFormatter: NumberFormatter
    init(collection: Collection) {
        self.viewModel = CollectionViewModel(collection:  collection)
        numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.maximumFractionDigits = 2
    }
    
    var body: some View {
        VStack(alignment: .center) {
            TextField("how much ?", value: $total, formatter: numberFormatter)
                .keyboardType(.default)
//            PaymentButton(action: viewModel.makePayment)
        }
        .padding()
    }
}

struct PaymentView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentView(collection: Collection(title: "Regalo di laurea ", caption: "Questa è una descrizione di prova per vedere se riesco a creare una collection View decente che mi possa piacere", amount: 30, currentAmount: 15, favourites: 0, participants: 6, collectionImageUrl: "ciao", timestamp: Firebase.Timestamp(date: Date.init()) , uid: "useridprova"))
    }
}
