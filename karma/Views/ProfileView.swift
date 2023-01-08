//
//  ProfileView.swift
//  karma
//
//  Created by Tommaso Bucaioni on 25/12/22.
//

import SwiftUI
import Kingfisher

struct ProfileView: View {
    @Environment(\.verticalSizeClass) var heightSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var widthSizeClass: UserInterfaceSizeClass?
    
    let workoutDateRange = Date()...Date().addingTimeInterval(1)
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    @ObservedObject var viewModel: ProfileViewModel
    @State var showHeaderBar = false
    @State var time = Timer.publish(every: 0.1, on: .current, in: .tracking).autoconnect()
    @State private var showNewCollectionView = false
    
    init(user: User) {
        self.viewModel = ProfileViewModel(user: user)
    }
    
    var body: some View {
        
        NavigationStack {
            ZStack(alignment: .top) {
                ScrollView(.vertical, showsIndicators: false) {
                        VStack {
                            GeometryReader { g in
                                VStack(alignment: .center) {
                                    HStack {
                                        Spacer()
                                        KFImage(URL(string: viewModel.user.profileImageUrl))
                                            .resizable()
                                            .scaledToFill()
                                            .clipShape(Circle())
                                            .frame(width: 100, height: 100)
                                            .onReceive(self.time) { (_) in
                                                let y = g.frame(in: .global).minY
                                                if -y > (UIScreen.main.bounds.height * 0.16) - 50 {
                                                    withAnimation {
                                                        self.showHeaderBar = true
                                                    }
                                                } else {
                                                    withAnimation {
                                                        self.showHeaderBar = false
                                                    }
                                                }
                                        }
                                        Spacer()
                                    }
                                    .padding(.top, 30)

                                    Text("\(viewModel.user.username)")
                                        .font(.title2)
                                        .fontWeight(.semibold)
     
                                }
                                
                            }
                            .frame(height: UIScreen.main.bounds.height / 4.3)
                            
                            statsView
                            
                            Divider()
                            
                            CollView
                            
                            if widthSizeClass == .compact{
                                RecentActivitiesView
                            } else {
                                Text("modalità Ipad")
                            }
                        }
                    }
                    .background(Color.theme.custombackg)
                    .refreshable {
                        viewModel.fetchUserCollections()
                    }
                
                if self.showHeaderBar {
                    HStack {
                        Spacer()
                        Text(viewModel.user.username)
                            .font(.title3)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    .padding(.bottom)
                    .background(Color.theme.custombackg)
                }
                
            }
        }
    }
}



struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: User(
            id: NSUUID().uuidString,
            username: "tombucaioni",
            fullname: "Tommaso Bucaioni",
            profileImageUrl: "",
            email: "tbucaioni@virgilio.it"))
        .previewDevice("iPhone 12")
        
        ProfileView(user: User(
            id: NSUUID().uuidString,
            username: "tombucaioni",
            fullname: "Tommaso Bucaioni",
            profileImageUrl: "",
            email: "tbucaioni@virgilio.it"))
        .previewDevice("iPad (10th generation)")
    }
}

extension ProfileView {
    
    
    var statsView: some View {
        HStack {
            VStack {
                Text("23")
                Text("Donazioni")
                    .fontWeight(.regular)
            }
            
            Spacer()
            
            VStack {
                Text("\(viewModel.collections.count)")
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
                        NavigationLink {
                            SummaryCollectionView(collection: collection)
                        } label: {
                            CollectionView(collection: collection)
                                .padding(.horizontal, 10)
                        }
                        
                        
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

