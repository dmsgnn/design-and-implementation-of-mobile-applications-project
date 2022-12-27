//
//  TabBarView.swift
//  karma
//
//  Created by Tommaso Bucaioni on 27/12/22.
//

import SwiftUI

enum Tabs: Int {
    case home = 0
    case bookmarks = 1
    case search = 2
    case profile = 3
}

struct TabBarView: View {
    
    @Binding var selectedTab: Tabs
    
    var body: some View {
        HStack(alignment: .center) {
            
            Button {
                selectedTab = .home
            } label: {
                TabBarButton(imageName: "house", isActive: selectedTab == .home)
                
            }

            Button {
                selectedTab = .bookmarks
            } label: {
                TabBarButton(imageName: "bookmark", isActive: selectedTab == .bookmarks)
                
            }
            
            Button {
                //switch to add collection
            } label: {
                GeometryReader { geo in
                    VStack(alignment: .center, spacing: 4) {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 32, height: 32)
                    }
                    .frame(width: geo.size.width, height: geo.size.height)
                }
            }
            
            Button {
                selectedTab = .search
            } label: {
                TabBarButton(imageName: "magnifyingglass.circle", isActive: selectedTab == .search)
            }
            
            Button {
                selectedTab = .profile
            } label: {
                
                TabBarButton(imageName: "person", isActive: selectedTab == .profile)
            }

        }
        .background(Color.theme.custombackg)
        .frame(height: 84)
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(selectedTab: .constant(.bookmarks))
    }
}
