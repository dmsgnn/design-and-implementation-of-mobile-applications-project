//
//  UserRowView.swift
//  karma
//
//  Created by Tommaso Bucaioni on 05/01/23.
//

import SwiftUI

struct UserRowView: View {
    var body: some View {
        HStack {
            Circle()
                .frame(width: 40, height: 40)
            
            VStack(alignment: .leading, spacing: 4){
                Text("username")
                    .font(.subheadline).bold()
                
                Text("name surname")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
            }
            Spacer()
        }
        .padding()
    }
}

struct UserRowView_Previews: PreviewProvider {
    static var previews: some View {
        UserRowView()
    }
}
