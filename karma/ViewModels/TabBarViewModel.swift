//
//  TabBarViewModel.swift
//  karma
//
//  Created by Tommaso Bucaioni on 27/12/22.
//

import Foundation

enum TabBarViewModel: Int, CaseIterable {
case home
case bookmarks
case addCollection
case search
case profile
        
    var imageName: String {
        switch self {
        case .home: return "house"
        case .bookmarks: return "bookmark"
        case .addCollection: return "plus.circle"
        case .search: return "magnifyingglass"
        case .profile: return "person"
        }
    }
}
