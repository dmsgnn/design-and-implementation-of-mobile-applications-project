//
//  CustomCornerView.swift
//  karma
//
//  Created by Giovanni Demasi on 06/01/23.
//

import SwiftUI

// Custom corner path shape
struct CustomCorner: Shape {
    var corners: UIRectCorner
    var radius: CGFloat
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
