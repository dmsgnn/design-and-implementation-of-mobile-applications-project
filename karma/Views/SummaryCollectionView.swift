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
    
    let collection: Collection
    
    init(collection: Collection){
        self.collection = collection
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.theme.custombackg.ignoresSafeArea()
            ScrollView {
                VStack {
                    GeometryReader { g in
                        HStack {
                            Spacer()
                            VStack {
                                KFImage(URL(string: collection.collectionImageUrl ?? ""))
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: UIScreen.main.bounds.width * 0.9, height: 200)
                                    .padding(.top, 50)
                                    .onReceive(self.time) { (_) in
                                        let y = g.frame(in: .global).minY
                                        if -y > (UIScreen.main.bounds.height * 0.3) - 50 {
                                            withAnimation {
                                                self.showHeaderBar = true
                                            }
                                        } else {
                                            withAnimation {
                                                self.showHeaderBar = false
                                            }
                                        }
                                    }
                                
                                
                                Text(collection.title)
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                
                                Text(collection.user?.username ?? "")
                                    .padding(.bottom)
                                
                            }
                            Spacer()
                        }
                    }
                    .frame(height: UIScreen.main.bounds.height / 2.5)
                    
                    VStack {
                        HStack {
                            Text("€\(String(collection.currentAmount.formatted(.number.precision(.fractionLength(2))))) raised of €\(String(collection.amount.formatted(.number.precision(.fractionLength(0)))))")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Spacer()
                        }
                        
                        ProgressView(value: collection.currentAmount/collection.amount)
                            .scaleEffect(x: 1, y: 2)
                        
                        
                        HStack{
                            Image(systemName: "person.fill")
                            Text("\(collection.participants) participants")
                                .fontWeight(.regular)
                            Spacer()
                        }
                        .font(.subheadline)
                        .padding(.top, 10)
                        
                    }
                    .padding(.horizontal)
                    
                    Button() {
                        print("donate")
                    } label: {
                        Text("Donate")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                            .frame(minWidth: 100, maxWidth: 250)
                            .frame(height: 45)
                            .background(Color(.systemBlue))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                    }
                    .padding(.vertical)
                    
                    
                    Text(collection.caption)
                        .padding(.horizontal)
                        .font(.body)
                        .padding(.bottom, 8)
                    
                    VStack{
                        HStack {
                            Text("\(collection.timestamp.dateValue().formatted(date: .abbreviated, time: .omitted))")
                                .font(.footnote)
                                .fontWeight(.regular)
                            Spacer()
                        }
                        .padding(.horizontal)
                    }
                    
                    VStack(alignment: .leading){
                        HStack {
                            Text("Past Donations")
                                .font(.title2)
                                .fontWeight(.semibold)
                            
                            Spacer()
                        }
                    }
                    .padding()
                    
                    VStack(alignment: .leading){
                        HStack {
                            Text("Charts")
                                .font(.title2)
                                .fontWeight(.semibold)
                            Spacer()
                        }
                        RecentActivityView()
                        RecentActivityView()
                        RecentActivityView()
                        RecentActivityView()
                    }
                    .padding()
                    
                    
                    
                    Spacer()
                    
                }
                
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
                    Text(collection.title)
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
