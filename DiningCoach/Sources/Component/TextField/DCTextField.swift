//
//  DCTextEditor.swift
//  DiningCoach
//
//  Created by 이송미 on 2023/06/27.
//

import SwiftUI

struct DCTextField: View {
    @Binding var textInput: String
    @Binding var style: Style
    
    let placeholder: LocalizedStringKey
    let supportText: String?
    var isSecure: Bool = false
    
    var body: some View {
        let input = $textInput.wrappedValue
        
        VStack(alignment: .leading) {
                        
            ZStack(alignment: .leading) {
                Text(placeholder)
                    .font(.pretendard(weight: .semiBold, size: input.isEmpty ? 16 : 11))
                    .foregroundColor(Color(.placeholderText))
                    .offset(y: input.isEmpty ? 0 : -25)
                    .scaleEffect(input.isEmpty ? 1 : 0.8, anchor: .leading)
                
                if !isSecure {
                    TextField("", text: $textInput)
                        .font(.pretendard(weight: .semiBold, size: 16))
                } else {
                    SecureField("", text: $textInput)
                }
            }
            .animation(.spring(response: 0.2, dampingFraction: 0.5))
            
            Divider()
                .background(color(style: style, isEmpty: input.isEmpty))
                .offset(x: 0, y: -5)
            
            if !isSecure && supportText != nil {
                Text(supportText!)
                    .font(.pretendard(weight: .semiBold, size: 11))
                    .foregroundColor(color(style: style, isEmpty: input.isEmpty))
                    .offset(x: 0, y: -5)
                
            }
        }
        .padding()
    }
}

extension DCTextField {
    enum Style {
        case normal
        case correct
        case error
    }
    
    func color(style: DCTextField.Style, isEmpty: Bool) -> Color {
        if isEmpty {
            return .neutral400
        }
        
        switch style {
        case .correct:
            return .primary500
        case .error:
            return .orange
        default:
            return .neutral900
        }
    }
}

struct DCTextField_Preview: PreviewProvider {
    @State static var emptyInput: String = ""
    @State static var textInput: String = "Input Test"
    @State static var normalStyle: DCTextField.Style = .normal
    @State static var correctStyle: DCTextField.Style = .correct
    @State static var errorStyle: DCTextField.Style = .error
    
    static var previews: some View {
        VStack {
            // default
            DCTextField(textInput: $emptyInput, style: $normalStyle, placeholder: "User name", supportText: "Support Text")
            // typing correct
            DCTextField(textInput: $textInput, style: $correctStyle, placeholder: "User name", supportText: "Support Text")
            // typing error
            DCTextField(textInput: $textInput, style: $errorStyle, placeholder: "User name", supportText: "Support Text")
            
            // password
            DCTextField(textInput: $emptyInput, style: $correctStyle, placeholder: "Password", supportText: nil, isSecure: true)
            
            // password
            DCTextField(textInput: $textInput, style: $correctStyle, placeholder: "User name", supportText: nil, isSecure: true)
        }
    }
}
