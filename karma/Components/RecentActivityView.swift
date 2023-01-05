//
//  RecentActivityView.swift
//  karma
//
//  Created by Tommaso Bucaioni on 25/12/22.
//

import SwiftUI

struct RecentActivityView: View {
    var body: some View {
        HStack(spacing: 24){
            Circle()
                .frame(width: 60, height: 60)
                .padding(.leading)
            
            VStack(alignment: .leading) {
                Text("Regalo Ale")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.bottom, 2)
                
                Text("23 mar - Money sent")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(Color(.systemGray))
            }
            .padding(.vertical)
            
            Text("10 €")
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.trailing)
                //.offset(y: -14)
        }
        .background(Color(.white))
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

struct RecentActivityView_Previews: PreviewProvider {
    static var previews: some View {
        RecentActivityView()
    }
}
