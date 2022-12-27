//
//  ProfileView.swift
//  karma
//
//  Created by Tommaso Bucaioni on 25/12/22.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    //@State var selectedTab: Tabs = .profile
    private let user: User
    
    init(user: User) {
        self.user = user
    }
    
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
                
                VStack {
                    Spacer()
                    //TabBarView(selectedTab: $selectedTab)
                }
                
            }
            .ignoresSafeArea()
        }
    }

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: User(
            id: NSUUID().uuidString,
            username: "tombucaioni",
            fullname: "Tommaso Bucaioni",
            email: "tbucaioni@virgilio.it"))
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
            
            Button {
                authViewModel.signOut()
            } label: {
                Text("Sign Out")
            }
            
            Circle()
                .frame(width: 100, height: 100)
                .padding(.bottom, 18)
            
            Text("\(user.username)")
                .font(.title).bold()
        }
        .padding(.bottom,24)
        .padding(.top, 20)
    }
    
    var statsView: some View {
        HStack {
            VStack {
                Text("23")
                Text("Donazioni")
                    .fontWeight(.regular)
            }
            
            Spacer()
            
            VStack {
                Text("5")
                Text("Raccolte")
                    .fontWeight(.regular)
            }
            
            Spacer()
            
            VStack {
                Text("+ 10 €")
                Text("Bilancio")
                    .fontWeight(.regular)
            }
        }
        .font(.title2)
        .fontWeight(.bold)
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
                        .fontWeight(.semibold)
                        .foregroundColor(Color(.systemBlue))
                }
            }
            .padding(.horizontal, 20)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(0 ... 5, id: \.self){ _ in
                        CollectionView()
                            .padding(.horizontal, 10)
                        
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
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    ForEach(0 ... 20, id: \.self) { _ in
                        RecentActivityView()
                    }
                    
                }
            
            }
        }
    }
}
