//
//  CustomInputField.swift
//  karma
//
//  Created by Tommaso Bucaioni on 06/12/22.
//

import SwiftUI

struct CustomInputField: View {
    
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
            .frame(width: screenWidth*0.8, height: screenHeight * 0.06)
            .background(.white)
            .containerShape(RoundedRectangle(cornerRadius: screenHeight * 0.02))

        
    }
}

struct CustomInputField_Previews: PreviewProvider {
    static var previews: some View {
        CustomInputField(placeholderText: "Email", text: .constant(""))
    }
}
