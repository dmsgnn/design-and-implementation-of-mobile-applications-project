//
//  TabBarView.swift
//  karma
//
//  Created by Tommaso Bucaioni on 27/12/22.
//

import SwiftUI

struct TabBarView: View {
    
    var body: some View {
        HStack(spacing: 50) {
            ForEach(TabBarViewModel.allCases, id: \.rawValue) { option in
                Image(systemName: option.imageName)
                    .foregroundColor(Color(.systemGray))
                
                
            }
        }
        .frame(width: UIScreen.main.bounds.size.width, height: 84)
        .background(Color.theme.custombackg)
    }
    
    
}
    
struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
