//
//  RecentUserActivityView.swift
//  karma
//
//  Created by Tommaso Bucaioni on 25/12/22.
//

import SwiftUI

struct RecentUserActivityView: View {
    
    @ObservedObject var viewModel: RecentUserActivityViewModel
    private let isPositive: Bool

    
    init(payment: Payment, isPositive: Bool) {
        self.viewModel = RecentUserActivityViewModel(payment: payment)
        self.isPositive = isPositive
    }
    
    
    var body: some View {
        HStack(spacing: 24){
            Circle()
                .frame(width: 60, height: 60)
                .padding(.leading)
            
            VStack(alignment: .leading) {
                Text(viewModel.payment.collection?.title ?? "")
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
                .foregroundColor(isPositive ? Color.green : Color.red)
                .padding(.trailing)
        }
        .background(Color(.white))
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

//struct RecentUserActivityView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecentUserActivityView()
//    }
//}
