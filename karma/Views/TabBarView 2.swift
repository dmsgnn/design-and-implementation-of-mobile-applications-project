//
//  TabBarView.swift
//  karma
//
//  Created by Tommaso Bucaioni on 27/12/22.
//

import SwiftUI

struct TabBarView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        
        if let user = authViewModel.currentUser {
            HStack(spacing: 50) {
                ForEach(TabBarViewModel.allCases, id: \.rawValue) { viewModel in
                    if viewModel == .profile {
                        NavigationLink {
                            ProfileView(user: user)
                        } label: {
                            OptionTabView(viewModel: viewModel)
                        }
                    } else if viewModel == .addCollection {
                        NavigationLink {
                            UploadCollectionView()
                        } label: {
                            OptionTabView(viewModel: viewModel)
                        }
                        //UploadCollectionView()
                    } else {
                        //OptionTabView(viewModel: viewModel)
                    }
                }
            }
            .frame(width: UIScreen.main.bounds.size.width, height: 84)
            .background(Color.theme.custombackg)
        }
    }
    
}
    
struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
