//
//  CollectionView.swift
//  karma
//
//  Created by Tommaso Bucaioni on 25/12/22.
//

import SwiftUI

struct CollectionView: View {
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 15)
                .frame(width: 260, height: 160)
                .foregroundColor(Color(.lightGray))
            
            Text("Collection Title")
                .font(.title)
                .fontWeight(.semibold)
            
            ProgressView(value: 0.33)
                .progressViewStyle(.linear)
                .padding(.horizontal, 50)
            
            HStack(spacing: 150) {
                HStack {
                    Image(systemName: "eurosign")
                    Text("450")
                }
                .font(.headline)
                .fontWeight(.semibold)
                
                HStack {
                    Image(systemName: "person.fill")
                    Text("23")
                }
            }
            .padding(.top, 4)
        }
        .frame(width: 300, height: 320)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct CollectionView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionView()
    }
}
