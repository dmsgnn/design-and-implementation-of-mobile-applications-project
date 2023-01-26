//
//  SummaryCollectionView.swift
//  karma
//
//  Created by Tommaso Bucaioni on 03/01/23.
//

import SwiftUI
import Firebase
import Kingfisher
import FirebaseFirestore

struct SummaryCollectionView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var showHeaderBar = false
    @State var time = Timer.publish(every: 0.1, on: .current, in: .tracking).autoconnect()
    
    @State private var showPaymentView = false
    @ObservedObject var viewModel: SummaryCollectionViewModel
    @ObservedObject var authViewModel = AuthViewModel()
    
    init(collection: Collection){
        self.viewModel = SummaryCollectionViewModel(collection: collection)
    }
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                Color.theme.custombackg.ignoresSafeArea()
                ScrollView {
                    VStack {
                        //                    GeometryReader { g in
                        HStack {
                            Spacer()
                            VStack {
                                KFImage(URL(string: viewModel.collection.collectionImageUrl))
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: UIScreen.main.bounds.width * 0.9, height: 200)
                                    .padding(.top, 50)
                                
                                
                                
                                Text(viewModel.collection.title)
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                
                                
                                Text(viewModel.collection.user?.username ?? "")
                                    .padding(.bottom)
                            
                                
                            }
                            Spacer()
                        }
                    
                        
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
                    viewModel.fetchCollection()

                }
                
                
            }
        }
        .toolbar {
            
            ToolbarItem(placement: ToolbarItemPlacement.navigationBarLeading) {
                
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.05){
                        showTabBar()
                    }
                }, label: {
                    Image(systemName: "chevron.backward")
                        .fontWeight(.semibold)
                })
                
            }
            
            ToolbarItem(placement: ToolbarItemPlacement.principal) {
                Text(viewModel.collection.title)
                    .font(.title2)
                    .fontWeight(.semibold)
            }
            if viewModel.collection.uid == authViewModel.currentUser?.id {
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                    Menu {
                        NavigationLink {
                            EditCollectionView(collection: viewModel.collection)
                        } label: {
                            Label("Edit collection", systemImage: "pencil")
                        }
                        
                        Button {
                            viewModel.collection.didLike ?? false ? viewModel.removeFromFavourite() : viewModel.addToFavourite()
                        } label: {
                            Label(viewModel.collection.didLike ?? false ? "Remove to favourites" : "Add to favourites", systemImage: viewModel.collection.didLike ?? false ? "bookmark.fill" : "bookmark")
                        }
                        
                        Button (
                            role: .destructive,
                            action: {
                                viewModel.deleteCollection()
                                presentationMode.wrappedValue.dismiss()
                            },
                            label: {
                                Label("Delete collection", systemImage: "trash")
                                
                            }
                        )
                        
                    } label: {
                        Label (
                            title: { Text("") },
                            icon: { Image(systemName: "ellipsis") }
                        )
                    }
                }
            } else {
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                    Button {
                        viewModel.collection.didLike ?? false ? viewModel.removeFromFavourite() : viewModel.addToFavourite()
                    } label: {
                        Image(systemName: viewModel.collection.didLike ?? false ? "bookmark.fill" : "bookmark")
                    }
                }
                
            }
        }
        .navigationBarBackButtonHidden(true)
        .foregroundColor(.black)
        
    }
    
}

struct SummaryCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SummaryCollectionView(collection: Collection(title: "Regalo di laurea ", caption: "Questa è una descrizione di prova per vedere se riesco a creare una collection View decente che mi possa piacere", amount: 30, currentAmount: 20, favourites: 0, participants: 6, collectionImageUrl: "ciao", timestamp: FirebaseFirestore.Timestamp(date: Date.init()) , uid: "useridprova"))
        }
    }
}
