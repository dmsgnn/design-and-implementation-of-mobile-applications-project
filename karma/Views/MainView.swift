//
//  MainView.swift
//  karma
//
//  Created by Giovanni Demasi on 07/01/23.
//
import SwiftUI

struct MainView: View {
    
    // Tab variables
    @State var currentTab: Tab = .home
    @Namespace var animation
    @State var showTabBar: Bool = true
    
    @State private var showNewCollectionView = false
    
    @EnvironmentObject var authViewModel: AuthViewModel
    //    let user : User
    
    init() {
        // Hiding native tab bar
        UITabBar.appearance().isHidden = true
        //        self.user = user
    }
    
    
    var body: some View {
        
        if let user = authViewModel.currentUser {
            ZStack(alignment: .bottom){
                TabView(selection: $currentTab){
                    GeometryReader{
                        let safeArea = $0.safeAreaInsets
                        let size = $0.size
                        DashboardView(viewModel: DashboardViewModel(), safeArea: safeArea, size: size)
                            .ignoresSafeArea(.container, edges: .top)
                            .setTabBarBackground(color: Color("BG"))
                            .tag(Tab.home)
                        
                    }
                    
                    SearchView()
                        .setTabBarBackground(color: Color("BG"))
                        .tag(Tab.search)
                    
                    //                    UploadCollectionView()
                    //                        .setTabBarBackground(color: Color("BG"))
                    //                        .tag(Tab.post)
                    

                    
                    BookmarkView()
                        .setTabBarBackground(color: Color("BG"))
                        .tag(Tab.bookmarks)
                    
                    ProfileView(user: user)
                        .setTabBarBackground(color: Color("BG"))
                        .tag(Tab.profile)
                }
                TabBar()
                    .offset(y: showTabBar ? 0 : 130)
                    .animation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7), value: showTabBar)
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .onReceive(NotificationCenter.default.publisher(for: .init("SHOWTABBAR"))
            ){ _ in
                showTabBar = true
            }
            .onReceive(NotificationCenter.default.publisher(for: .init("HIDETABBAR"))){ _ in
                showTabBar = false
            }
            
            Button {
                showNewCollectionView.toggle()
            } label: {
                Image(systemName: "plus.circle")
                    .renderingMode(.template)
                    .frame(width: 28, height: 28)
                    .padding()
            }
            .background(Color(.systemBlue))
            .foregroundColor(.white)
            .clipShape(Circle())
            .padding()
            .fullScreenCover(isPresented: $showNewCollectionView) {
                UploadCollectionView()
            }
            
            
            
        }
    }
    
    // Custom Tab Bar
    @ViewBuilder
    func TabBar()->some View{
        HStack(spacing: 0){
            ForEach(Tab.allCases, id: \.rawValue){ tab in
                Image(tab.rawValue)
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
                    .foregroundColor(currentTab == tab ? .white : .gray.opacity(0.5))
                    .background(content : {
                        if(currentTab == tab){
                            Circle()
                                .fill(.black)
                                .scaleEffect(2.5)
                            //.shadow(color: .black.opacity(0.3), radius: 8, x: 5, y: 10)
                                .matchedGeometryEffect(id: "TAB", in: animation)
                        }
                    })
                    .frame(maxWidth: .infinity)
                    .padding(.top, 25)
                    .padding(.bottom, 10)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        currentTab = tab
                    }
            }
        }
        .padding(.horizontal, 15)
        .animation(.interactiveSpring(response: 0.5, dampingFraction: 0.65, blendDuration: 0.65), value: currentTab)
        .background{
            // Custom corner
            CustomCorner(corners: [.topLeft, .topRight], radius: 25)
                .fill(Color(.white))
                .ignoresSafeArea()
        }
    }
    
}


struct MainView_Previews : PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

extension View{
    func showTabBar(){
        //        NotificationCenter.default.post(name: NSNotification.Name("SHOWTABBAR"), object: nil)
        NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "SHOWTABBAR"),object: nil))
        
        
    }
    
    func hideTabBar(){
        //        NotificationCenter.default.post(name: NSNotification.Name("HIDETABBAR"), object: nil)
        NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "HIDETABBAR"),object: nil))
    }
    
    @ViewBuilder
    func setTabBarBackground(color: Color)->some View{
        self
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(){
                color
                    .ignoresSafeArea()
            }
    }
}
