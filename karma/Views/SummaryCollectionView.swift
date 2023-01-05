//
//  SummaryCollectionView.swift
//  karma
//
//  Created by Tommaso Bucaioni on 03/01/23.
//

import SwiftUI

struct SummaryCollectionView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var showHeaderBar = false
    @State var time = Timer.publish(every: 0.1, on: .current, in: .tracking).autoconnect()
    
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.theme.custombackg.ignoresSafeArea()
            ScrollView {
                VStack {
                    GeometryReader { g in
                        HStack {
                            Spacer()
                            VStack {
                                Image(systemName: "photo")
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
                                
                                
                                Text("Title collection")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                
                                Text("collection owner")
                                    .padding(.bottom)
                                
                            }
                            Spacer()
                        }
                    }
                    .frame(height: UIScreen.main.bounds.height / 2.5)
                    
                    VStack {
                        HStack {
                            Text("€ 842 raised of €1000")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Spacer()
                        }
                        
                        ProgressView(value: 0.5)
                            .scaleEffect(x: 1, y: 2)
                        
                        
                        HStack{
                            Image(systemName: "person.fill")
                            Text("43 participants")
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
                    
                    
                    Text("Descrizione di sto cazzo per la raccolta brutta brutta che sepriamo finisca presto etc etc mi chiamo tommaso e sono tommaso e sono tommaso e tifo per l'inter che gol ha fatto. Adriano, Messi è il Migliore giocatore al mondo.")
                        .padding(.horizontal)
                        .font(.body)
                        .padding(.bottom, 8)
                    
                    VStack{
                        HStack {
                            Text("23 Mar 2022 ")
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
                }, label: {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(Color.theme.dark)
                })
                
                Spacer()
                
                if showHeaderBar{
                    Text("Title Collection")
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
            SummaryCollectionView()
        }
    }
}
