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
    //    @State var showHeaderBar = false
    
    let layout = [GridItem(.adaptive(minimum: 300))]
    @State var time = Timer.publish(every: 0.1, on: .current, in: .tracking).autoconnect()
    @State private var showNewCollectionView = false
    @State private var showEditPage = false
    
    init(user: User) {
        self.viewModel = ProfileViewModel(user: user, userService: UserService(), service: CollectionService(), paymentService: PaymentService())
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
                                .id("username")
                            
                        }
                        .padding(.bottom, 24)
                        
                    }
                    //                            .frame(height: UIScreen.main.bounds.height / 4.3)
                    
                    statsView
                    
                    Divider()
                    
                    CollView
                    
                    
                    RecentActivitiesView
                    
                }
            }
            //                    .background(Color.theme.custombackg)
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
                            .foregroundColor((viewModel.user.id == authViewModel.currentUser?.id) ? .white : .black)
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
                Text("Donations")
                    .fontWeight(.regular)
            }
            .frame(width: UIScreen.main.bounds.width * 0.33)
            
            VStack {
                Text("\(viewModel.collections.count)")
                Text("Collections")
                    .fontWeight(.regular)
            }
            .frame(width: UIScreen.main.bounds.width * 0.33)
            VStack {
                Text("\(String(viewModel.balance.formatted(.number.precision(.fractionLength(0)))))")
                Text("Points")
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
                Text("Collections")
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
                            CollectionView(collection: collection)
                                .padding(.horizontal, UIDevice.isIPad ? 6 : 10)
                            
                        }
                        
                        //                        .padding(.trailing, 10 )
                        
                        
                    }
                    .padding(.horizontal, 15)
                    
                }
            }
            
        }
        .padding(.horizontal)
    }
    
    var RecentActivitiesView: some View {
        
        VStack(alignment: .leading) {
            
            
            if UIDevice.isIPad {
                Text("Recent Activities")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.top, 8)
                    .offset(x: 30)
                LazyVGrid(columns: layout) {
                    ForEach(viewModel.totalPayments) { payment in
                        RecentUserActivityView(payment: payment, isPositive: payment.isPositive ?? false)
                            .padding(.vertical, 4)
                    }
                }
                .padding(.horizontal, 20)
            } else {
                Text("Recent Activities")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.top, 8)
                VStack {
                    ForEach(viewModel.totalPayments) { payment in
                        RecentUserActivityView(payment: payment, isPositive: payment.isPositive ?? false)
                            .padding(.bottom, 4)
                    }
                    
                    
                }
            }
            Spacer().frame(height: 60)
        }
        
    }
    
}
