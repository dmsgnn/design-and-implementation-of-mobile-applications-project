//
//  iPadCustomInputField.swift
//  karma
//
//  Created by Giovanni Demasi on 26/01/23.
//

import SwiftUI

struct iPadCustomInputField: View {
    
    let placeholderText: String
    var isSecureField: Bool? = false
    @Binding var text: String
    let screenHeight = UIScreen.main.bounds.height
    let screenWidth = UIScreen.main.bounds.width
    
    var body: some View {

            VStack {
                if isSecureField ?? false {
                    SecureField(placeholderText, text: $text)
                        .padding()
                } else {
                    TextField(placeholderText, text: $text)
                        .padding()
                }
            }
            .frame(width: screenWidth*0.6, height: screenHeight * 0.06)
            .background(.white)
            .containerShape(RoundedRectangle(cornerRadius: screenHeight * 0.02))

        
    }
}

struct iPadCustomInputField_Previews: PreviewProvider {
    static var previews: some View {
        CustomInputField(placeholderText: "Email", text: .constant(""))
            .previewDevice(PreviewDevice(rawValue: "iPad Pro (12.9-inch) (6th generation)"))
            .previewDisplayName("iPad Pro 12.9")
    }
}
