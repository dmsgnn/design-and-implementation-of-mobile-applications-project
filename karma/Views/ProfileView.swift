//
//  ProfileView.swift
//  karma
//
//  Created by Tommaso Bucaioni on 25/12/22.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        ZStack {
            Color.theme.custombackg
            
            ScrollView{
                headerView
                
                statsView
                
                Divider()
                
                CollView
                
                RecentActivitiesView
                
                
                
            }
        }
        .ignoresSafeArea()
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

extension ProfileView {
    var headerView: some View {
        VStack {
            HStack {
                Button {
                    print("go back")
                } label: {
                    Image(systemName: "arrow.left")
                }
                
                Spacer()
                
                Button{
                    print("settings")
                } label: {
                    Image(systemName: "ellipsis")
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 24)
            
            Circle()
                .frame(width: 100, height: 100)
                .padding(.bottom, 18)
            
            Text("Name Surname")
                .font(.title).bold()
        }
        .padding(.bottom,24)
        .padding(.top, 20)
    }
    
    var statsView: some View {
        HStack {
            VStack {
                Text("23")
                    .font(.title2).bold()
                Text("Donazioni")
                    .font(.title2)
            }
            
            Spacer()
            
            VStack {
                Text("5")
                    .font(.title2).bold()
                Text("Raccolte")
                    .font(.title2)
            }
            
            Spacer()
            
            VStack {
                Text("+ 10 €")
                    .font(.title2).bold()
                Text("Bilancio")
                    .font(.title2)
            }
        }
        .padding(.horizontal, 20)
        
    }
    
    var CollView: some View {
        VStack {
            HStack {
                Text("Raccolte")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Button {
                    print("add a collection")
                } label: {
                    Text("+ Add New")
                        .foregroundColor(Color(.systemGray))
                }
            }
            .padding(.horizontal, 20)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(0 ... 5, id: \.self){ _ in
                        CollectionView()
                            .padding(.horizontal)
                            .padding(.bottom)
                    }
                }
            }
        }
    }
    
    var RecentActivitiesView: some View {
        VStack(alignment: .leading) {
            Text("Attività recenti")
                .font(.title2)
                .fontWeight(.semibold)
            VStack {
                ForEach(0 ... 20, id: \.self) { _ in
                    RecentActivityView()
                }
            }
        }
    }
}
