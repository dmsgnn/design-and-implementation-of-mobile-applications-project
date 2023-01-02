//
//  Double.swift
//  karma
//
//  Created by Tommaso Bucaioni on 30/12/22.
//

import Foundation

extension Double {
    
    private var currencyFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "€"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    func toCurrency() -> String{
        return currencyFormatter.string(for: self) ?? ""
    }
    
    private var roundedFormatter: NumberFormatter {
        let rounded = NumberFormatter()
        rounded.numberStyle = .decimal
        rounded.minimumFractionDigits = 2
        rounded.maximumFractionDigits = 2
        return rounded
    }
    
    func toRound() -> String {
        return roundedFormatter.string(for: self) ?? ""
    }
}
