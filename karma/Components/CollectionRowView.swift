//
//  CollectionRowView.swift
//  karma
//
//  Created by Tommaso Bucaioni on 05/01/23.
//

import SwiftUI

struct CollectionRowView: View {
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 80, height: 60)
            
            VStack(alignment: .leading, spacing: 6){
                Text("Title Collection")
                    .font(.headline).bold()
                
                Text("owner username")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
            }
            
            Spacer()
            
            VStack(alignment: .center) {
                Text("Money Raised:")
                    .font(.footnote)
                
                Text("€500 of €1000")
                    .font(.subheadline).bold()
            }
            

        }
        .padding()
    }
}

struct CollectionRowView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionRowView()
    }
}
