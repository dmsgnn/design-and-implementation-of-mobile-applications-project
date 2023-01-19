//
//  SummaryCollectionView.swift
//  karma
//
//  Created by Tommaso Bucaioni on 03/01/23.
//

import SwiftUI
import Firebase
import Kingfisher

struct SummaryCollectionView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var showHeaderBar = false
    @State var time = Timer.publish(every: 0.1, on: .current, in: .tracking).autoconnect()
    
    @State private var showPaymentView = false
    @ObservedObject var viewModel: SummaryCollectionViewModel
    
    init(collection: Collection){
        self.viewModel = SummaryCollectionViewModel(collection: collection)
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.theme.custombackg.ignoresSafeArea()
            ScrollView {
                VStack {
//                    GeometryReader { g in
                        HStack {
                            Spacer()
                            VStack {
                                KFImage(URL(string: viewModel.collection.collectionImageUrl ?? ""))
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: UIScreen.main.bounds.width * 0.9, height: 200)
                                    .padding(.top, 50)
//                                    .onReceive(self.time) { (_) in
//                                        let y = g.frame(in: .global).minY
//                                        if -y > (UIScreen.main.bounds.height * 0.3) - 50 {
//                                            withAnimation {
//                                                self.showHeaderBar = true
//                                            }
//                                        } else {
//                                            withAnimation {
//                                                self.showHeaderBar = false
//                                            }
//                                        }
//                                    }
                                
                                
                                Text(viewModel.collection.title)
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                
                                Text(viewModel.collection.user?.username ?? "")
                                    .padding(.bottom)
                                
                            }
                            Spacer()
                        }
//                    }
//                    .frame(height: UIScreen.main.bounds.height / 2.5)
                    
                    VStack {
                        HStack {
                            Text("€ \(String(viewModel.collection.currentAmount.formatted(.number.precision(.fractionLength(2))))) raised of € \(String(viewModel.collection.amount.formatted(.number.precision(.fractionLength(0)))))")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Spacer()
                        }
                        
                        ProgressView(value: viewModel.collection.currentAmount/viewModel.collection.amount)
                            .scaleEffect(x: 1, y: 2)
                        
                        
                        HStack{
                            Image(systemName: "person.2.fill")
                            Text("\(viewModel.collection.participants) donations")
                                .fontWeight(.regular)
                            Spacer()
                        }
                        .font(.subheadline)
                        .padding(.top, 10)
                        
                    }
                    .padding(.horizontal)
                    
                    Button() {
                        showPaymentView.toggle()
                    } label: {
                        Text("Donate")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                            .frame(minWidth: 100, maxWidth: 250)
                            .frame(height: 45)
                            .background(Color(.systemBlue))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                    }
                    .sheet(isPresented: $showPaymentView, content: {
                        PaymentView(collection: viewModel.collection)
                            .presentationDetents([.medium])
                    })
                    .padding(.vertical)
                    
                    
                    Text(viewModel.collection.caption)
                        .padding(.horizontal)
                        .font(.body)
                        .padding(.bottom, 8)
                    
                    VStack{
                        HStack {
                            Text("\(viewModel.collection.timestamp.dateValue().formatted(date: .abbreviated, time: .omitted))")
                                .font(.footnote)
                                .fontWeight(.regular)
                            Spacer()
                        }
                        .padding(.horizontal)
                    }
                    
                   
                    
                    VStack(alignment: .leading){
                        HStack {
                            Text("Donations")
                                .font(.title2)
                                .fontWeight(.semibold)
                            Spacer()
                        }
                        
                        ForEach(viewModel.payments) { payment in
                            ActivityCollectionView(payment: payment)
                        }
                       
                    }
                    .padding()
                    
                    
                    
                    Spacer()
                    
                }
                
            }
            .refreshable {
                viewModel.fetchPaymentsForCollection()
            }
            .navigationBarBackButtonHidden(true)
            
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                    showTabBar()
                }, label: {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(Color.theme.dark)
                })
                
                Spacer()
                
                if showHeaderBar{
                    Text(viewModel.collection.title)
                        .font(.title3)
                        .fontWeight(.semibold)
                }
                
                Spacer()
                
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "ellipsis")
                        .foregroundColor(Color.theme.dark)
                })
            }
            
            .padding(.bottom)
            .padding(.horizontal)
            .background(showHeaderBar ? Color.theme.custombackg : Color.clear)
            
            
            
        }
        
    }
    
}

struct SummaryCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SummaryCollectionView(collection: Collection(title: "Regalo di laurea ", caption: "Questa è una descrizione di prova per vedere se riesco a creare una collection View decente che mi possa piacere", amount: 30, currentAmount: 20, favourites: 0, participants: 6, collectionImageUrl: "ciao", timestamp: Firebase.Timestamp(date: Date.init()) , uid: "useridprova"))
        }
    }
}
