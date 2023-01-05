//
//  TextArea.swift
//  karma
//
//  Created by Tommaso Bucaioni on 05/01/23.
//

import SwiftUI

struct TextArea: View {
    @Binding var text: String
    let placeholder: String
    
    init(_ placeholder: String, text: Binding<String>) {
        self.placeholder = placeholder
        self._text = text
        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            
            
            

            TextEditor(text: $text)
                .padding(4)
            
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(Color(.placeholderText))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 12)
                    
            }
            
               
            
//            Circle().foregroundColor(.black)
//                .frame(width: 30, height: 30)
            
//            Text(placeholder)
//                .foregroundColor(Color(.black))
//                .padding(.horizontal, 8)
//                .padding(.vertical, 12)
            
            
            
        }
        .font(.body)
    }
}

struct TextArea_Previews: PreviewProvider {

    static var previews: some View {
        TextArea("prova prova", text: .constant(""))
    }
}
