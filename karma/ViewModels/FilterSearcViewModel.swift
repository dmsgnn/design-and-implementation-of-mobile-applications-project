//
//  FilterSearcViewModel.swift
//  karma
//
//  Created by Tommaso Bucaioni on 05/01/23.
//

import Foundation

enum FilterSearchViewModel: Int, CaseIterable {
    case users
    case collections
    
    var title: String {
        switch self {
        case .users: return "Accounts"
        case .collections: return "Collections"
        }
    }
}
