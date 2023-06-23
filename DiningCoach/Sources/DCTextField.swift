//
//  DCTextField.swift
//  DiningCoach
//
//  Created by 심현석 on 2023/06/23.
//

import SwiftUI

struct DCTextField: View {
    var placeHolder: String
    @Binding var text: String
    
    var body: some View {
        VStack {
            TextField(placeHolder, text: $text)
                .fontWeight(.bold)
                .multilineTextAlignment(text.isEmpty ? .trailing : .center)
                .tint(Color.primary500)
                .keyboardType(.numberPad)
            
            Rectangle()
                .frame(height: 2)
                .foregroundColor(text.isEmpty ? Color(uiColor: .systemGray5) : Color.primary500)
        }
    }
}
