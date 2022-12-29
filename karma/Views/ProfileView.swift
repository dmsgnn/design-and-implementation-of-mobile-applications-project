//
//  ProfileView.swift
//  karma
//
//  Created by Tommaso Bucaioni on 25/12/22.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @ObservedObject var viewModel: ProfileViewModel
    //@State var selectedTab: Tabs = .profile
    @State private var showNewCollectionView = false
    
    init(user: User) {
        self.viewModel = ProfileViewModel(user: user)
    }
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            VStack {

                headerView
                
                statsView
                
                Divider()
                    
                CollView
                    
                RecentActivitiesView
                
                }
            }
            .background(Color.theme.custombackg)
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
            
            Text("\(viewModel.user.username)")
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
                    showNewCollectionView.toggle()
                } label: {
                    Text("+ Add New")
                        .fontWeight(.semibold)
                        .foregroundColor(Color(.systemBlue))
                }
            }
            .padding(.horizontal, 20)
            .fullScreenCover(isPresented: $showNewCollectionView) {
                UploadCollectionView()
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(viewModel.collections){ collection in
                        CollectionView(collection: collection)
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


