//
//  DCTextEditor.swift
//  DiningCoach
//
//  Created by 이송미 on 2023/06/27.
//

import SwiftUI

struct DCTextField: View {
    @Binding var textInput: String
    let placeholder: LocalizedStringKey
    let supportText: String?
        
    var body: some View {
        let input = $textInput.wrappedValue
        
        VStack(alignment: .leading) {
            ZStack(alignment: .leading) {
                Text(placeholder)
                    .font(.pretendard(weight: .semiBold, size: input.isEmpty ? 16 : 11))
                    .foregroundColor(Color(.placeholderText))
                    .offset(y: input.isEmpty ? 0 : -25)
                    .scaleEffect(input.isEmpty ? 1 : 0.8, anchor: .leading)
                
                TextField("", text: $textInput)
                    .font(.pretendard(weight: .semiBold, size: 16))
            }
            .animation(.spring(response: 0.2, dampingFraction: 0.5))
            
            Divider()
                .background(input.isEmpty ? Color.neutral400 : Color.primary500)
                .offset(x: 0, y: -5)
            
            if supportText != nil {
                Text(supportText!)
                    .font(.pretendard(weight: .semiBold, size: 11))
                    .foregroundColor(.neutral400)
                    .offset(x: 0, y: -5)
                    
            }
        }
        .padding()
    }
}

struct DCTextField_Preview: PreviewProvider {
    @State static var emptyInput: String = ""
    @State static var textInput: String = "Input Test"
    static var previews: some View {
        VStack {
            // default
            DCTextField(textInput: $emptyInput, placeholder: "User name", supportText: "Support Text")
            // typing correct
            DCTextField(textInput: $textInput, placeholder: "User name", supportText: "Support Text")
            DCTextField(textInput: $emptyInput, placeholder: "User name", supportText: "Support Text")
            DCTextField(textInput: $emptyInput, placeholder: "User name", supportText: "Support Text")
        }
    }
}
