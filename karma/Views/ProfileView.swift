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
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    @ObservedObject var viewModel: ProfileViewModel
    @State var showHeaderBar = false
    @State var time = Timer.publish(every: 0.1, on: .current, in: .tracking).autoconnect()
    @State private var showNewCollectionView = false
    @State private var showEditPage = false
    
    init(user: User) {
        self.viewModel = ProfileViewModel(user: user)
        viewModel.fetchUserCollections()
    
    }
    
    var body: some View {
        
        NavigationStack {
            ZStack(alignment: .top) {
                ScrollView(.vertical, showsIndicators: false) {
                        VStack {
//                            GeometryReader { g in
                                VStack(alignment: .center) {
                                    HStack {
                                        Spacer()
                                        KFImage(URL(string: viewModel.user.profileImageUrl))
                                            .resizable()
                                            .scaledToFill()
                                            .clipShape(Circle())
                                            .frame(width: 100, height: 100)
//                                            .onReceive(self.time) { (_) in
//                                                let y = g.frame(in: .global).minY
//                                                if -y > (UIScreen.main.bounds.height * 0.16) - 50 {
//                                                    withAnimation {
//                                                        self.showHeaderBar = true
//                                                    }
//                                                } else {
//                                                    withAnimation {
//                                                        self.showHeaderBar = false
//                                                    }
//                                                }
//                                        }
                                        
                                        Spacer()
                                    }
                                    

                                    Text("\(viewModel.user.username)")
                                        .font(.title2)
                                        .fontWeight(.semibold)
     
                                }
                                .padding(.bottom, 24)
                                
                            }
//                            .frame(height: UIScreen.main.bounds.height / 4.3)
                            
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
                       viewModel.fetchPayments()
                        viewModel.fetchUser()
                    }
                    .toolbar {
                        ToolbarItem(placement: ToolbarItemPlacement.navigationBarLeading) {
                            Button(action: {
                                presentationMode.wrappedValue.dismiss()
                            }, label: {
                                Image(systemName: "chevron.backward")
                                    .fontWeight(.semibold)
                            })
                        }
                        
                        ToolbarItem(placement: ToolbarItemPlacement.principal) {
        
                            Text(viewModel.user.fullname)
                                .font(.title2)
                                .fontWeight(.semibold)
                            
                        }
                        if viewModel.user.id == authViewModel.currentUser?.id {
                            ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                                Menu {
                                    NavigationLink {
                                        EditProfileView(user: viewModel.user)
                                    } label: {
                                        Label("Edit profile", systemImage: "pencil")
                                    }
                                    
                                    Button(
                                        role: .destructive,
                                        action: {
                                            authViewModel.signOut()
                                        }, label: {
                                            Label("Sign out", systemImage: "rectangle.portrait.and.arrow.right")
                                        }
                                    )
                                    
                                } label: {
                                    Label (
                                        title: { Text("Add") },
                                        icon: { Image(systemName: "ellipsis") }
                                    )
                                }
                                
                            }
                        }
                        
                        
                    }
            
                    .navigationBarBackButtonHidden(true)
                    .foregroundColor(.black)
                
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
//}



struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: User(
            id: NSUUID().uuidString,
            username: "tombucaioni",
            fullname: "Tommaso Bucaioni",
            profileImageUrl: "",
            email: "tbucaioni@virgilio.it"))
        .previewDevice("iPhone 12")
        
//        ProfileView(user: User(
//            id: NSUUID().uuidString,
//            username: "tombucaioni",
//            fullname: "Tommaso Bucaioni",
//            profileImageUrl: "",
//            email: "tbucaioni@virgilio.it"))
//        .previewDevice("iPad (10th generation)")
    }
}

extension ProfileView {
    
    
    var statsView: some View {
        HStack {
            
            VStack {
                Text("\(viewModel.sentPayments.count)")
                Text("Donazioni")
                    .fontWeight(.regular)
            }
            .frame(width: UIScreen.main.bounds.width * 0.33)

            VStack {
                Text("\(viewModel.collections.count)")
                Text("Raccolte")
                    .fontWeight(.regular)
            }
            .frame(width: UIScreen.main.bounds.width * 0.33)
            VStack {
                Text("\(String(viewModel.balance.formatted(.number.precision(.fractionLength(0))))) €")
                Text("Bilancio")
                    .fontWeight(.regular)
            }
            .frame(width: UIScreen.main.bounds.width * 0.33)
        }
        .font(.title2)
        .fontWeight(.bold)
        .padding(.horizontal, 20)
        
    }
    
    var CollView: some View {
        VStack(alignment: .center) {
            HStack {
                Text("Raccolte")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Spacer()
                if viewModel.user.id == authViewModel.currentUser?.id {
                    Button {
                        showNewCollectionView.toggle()
                    } label: {
                        Text("+ Add New")
                            .fontWeight(.semibold)
                            .foregroundColor(Color(.systemBlue))
                    }
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
                            CollectionView(collection: collection).padding(.horizontal, 18)
                                
                        }
                        
                        
                    }
                    
                }
            }
        
        }
        .padding(.horizontal)
    }
    
    var RecentActivitiesView: some View {
        
        VStack(alignment: .leading) {
            Text("Attività recenti")
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.top, 8)
            
            VStack {
                ForEach(viewModel.totalPayments) { payment in
                    RecentUserActivityView(payment: payment, isPositive: payment.isPositive ?? false)
                        .padding(.bottom, 4)
                }

//                ForEach(viewModel.sentPayments) { payment in
//                    RecentUserActivityView(payment: payment, isPositive: payment.isPositive ?? false)
//                }
//
//                ForEach(viewModel.receivedPayments) { payment in
//                    RecentUserActivityView(payment: payment, isPositive: payment.isPositive ?? false)
//                }
            }
        }
    }
    
}

