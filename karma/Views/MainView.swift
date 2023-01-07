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
    let user : User
    
    init(user: User) {
        // Hiding native tab bar
        UITabBar.appearance().isHidden = true
        self.user = user
    }
    
    
    var body: some View {
        ZStack(alignment: .bottom){
            TabView(selection: $currentTab){
                DashboardView(viewModel: DashboardViewModel())
                    .setTabBarBackground(color: Color("BG"))
                    .tag(Tab.home)
                
                Text("Search")
                    .setTabBarBackground(color: Color("BG"))
                    .tag(Tab.search)
                
                Text("Post")
                    .setTabBarBackground(color: Color("BG"))
                    .tag(Tab.post)
                
                Text("Bookmarks")
                    .setTabBarBackground(color: Color("BG"))
                    .tag(Tab.bookmarks)
                
                ProfileView(user: user)
                    .setTabBarBackground(color: Color("BG"))
                    .tag(Tab.profile)
            }
            TabBar()
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
        MainView(user: User(username: "Test", fullname: "Test name", profileImageUrl: "none", email: "Test@gmail.com"))
    }
}

extension View{
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
