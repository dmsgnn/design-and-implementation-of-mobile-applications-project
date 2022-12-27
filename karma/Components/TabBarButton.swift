//
//  TabBarButton.swift
//  karma
//
//  Created by Tommaso Bucaioni on 27/12/22.
//

import SwiftUI

struct TabBarButton: View {
    var imageName: String
    var isActive: Bool
    
    var body: some View {
        
        
    GeometryReader { geo in
            if(isActive){
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.black)
                    .frame(width: geo.size.width/2, height: 4)
                    .padding(.leading, geo.size.width/4)
                
                VStack(alignment: .center, spacing: 4) {
                    Image(systemName: imageName + ".fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                }
                .tint(.black)
                .frame(width: geo.size.width, height: geo.size.height)
                
            } else {
            VStack(alignment: .center, spacing: 4) {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
            }
            .foregroundColor(Color(.systemGray))
            .frame(width: geo.size.width, height: geo.size.height)
        }
    }
        
    }
}

struct TabBarButton_Previews: PreviewProvider {
    static var previews: some View {
        TabBarButton(imageName: "person", isActive: true)
    }
}
