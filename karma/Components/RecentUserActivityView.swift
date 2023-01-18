//
//  RecentUserActivityView.swift
//  karma
//
//  Created by Tommaso Bucaioni on 25/12/22.
//

import SwiftUI
import Kingfisher

struct RecentUserActivityView: View {
    
    @ObservedObject var viewModel: RecentUserActivityViewModel
    private let isPositive: Bool

    
    init(payment: Payment, isPositive: Bool) {
        self.viewModel = RecentUserActivityViewModel(payment: payment)
        self.isPositive = isPositive
    }
    
    
    var body: some View {
        HStack(){
            KFImage(URL(string: viewModel.payment.receiver?.profileImageUrl ?? ""))
                .resizable()
                .scaledToFill()
                .clipShape(Circle())
                .frame(width: 60, height: 60)
                .padding(.leading)

            VStack(alignment: .leading, spacing: 5) {
                
                Text((isPositive ? viewModel.payment.sender?.username : viewModel.payment.receiver?.username) ?? "")
                    .font(.title2)
                    .fontWeight(.semibold)
                    
                Text((isPositive ? "Money received" : "Money sent"))
                    .font(.subheadline)
                    .padding(.bottom, 2)
                    
                
                Text("\(viewModel.payment.timestamp.dateValue().formatted(date: .abbreviated, time: .omitted))")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(Color(.systemGray))
                    
            }
            .frame(width: 160)
            .padding(.vertical)
         
            Spacer()
            
            Text((isPositive ? "+ \(String(viewModel.payment.total.formatted(.number.precision(.fractionLength(0))))) €" : "- \(String(viewModel.payment.total.formatted(.number.precision(.fractionLength(0))))) €"))
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(isPositive ? Color.green : Color.red)
                .padding(.trailing)
        }
        .frame(width: UIScreen.main.bounds.size.width*0.9, height: 100)
        .background(.white)
        .containerShape(RoundedRectangle(cornerRadius: 15))
    }
}

//struct RecentUserActivityView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecentUserActivityView()
//    }
//}
