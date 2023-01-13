//
//  ActivityCollectionView.swift
//  karma
//
//  Created by Tommaso Bucaioni on 13/01/23.
//

import SwiftUI
import Kingfisher

struct ActivityCollectionView: View {
    
    @ObservedObject var viewModel: ActivityCollectionViewModel
    
    init(payment: Payment) {
        self.viewModel = ActivityCollectionViewModel(payment: payment)
    }
    
    var body: some View {
        HStack(spacing: 24){
            KFImage(URL(string: viewModel.payment.sender?.profileImageUrl ?? " "))
                .resizable()
                .scaledToFill()
                .clipShape(Circle())
                .frame(width: 60, height: 60)
                .padding(.leading)
            
            VStack(alignment: .leading) {
                Text(viewModel.payment.sender?.username ?? "")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.bottom, 2)
                
                Text("\(viewModel.payment.timestamp.dateValue().formatted(date: .abbreviated, time: .omitted))")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(Color(.systemGray))
            }
            .padding(.vertical)
            
            Text("\(String(viewModel.payment.total.formatted(.number.precision(.fractionLength(0))))) €")
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.trailing)
                
        }
        .background(Color(.white))
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

//struct ActivityCollectionView_Previews: PreviewProvider {
//    static var previews: some View {
//        ActivityCollectionView()
//    }
//}
