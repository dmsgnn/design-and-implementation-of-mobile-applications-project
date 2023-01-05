//
//  OptionTabView.swift
//  karma
//
//  Created by Tommaso Bucaioni on 29/12/22.
//

import SwiftUI

struct OptionTabView: View {
    let viewModel: TabBarViewModel
    var body: some View {
        Image(systemName: viewModel.imageName)
            .foregroundColor(Color(.systemGray))
    }
}

struct OptionTabView_Previews: PreviewProvider {
    static var previews: some View {
        OptionTabView(viewModel: .profile)
    }
}
