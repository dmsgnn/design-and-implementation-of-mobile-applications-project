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
            .frame(width: 310, height: 50)
            .background(.white)
            .containerShape(RoundedRectangle(cornerRadius: 15))

        
    }
}

struct CustomInputField_Previews: PreviewProvider {
    static var previews: some View {
        CustomInputField(placeholderText: "Email", text: .constant(""))
    }
}
