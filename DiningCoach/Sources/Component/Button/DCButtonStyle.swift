//
//  DCButtonStyle.swift
//  DiningCoach
//
//  Created by chamsol kim on 2023/06/14.
//

import SwiftUI

struct DCButtonStyle: ButtonStyle {
    
    let style: DCButton.Style
    let isEnabled: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        let foregroundColor = style.foregroundColor(isEnabled: isEnabled)
        let backgroundColor = style.backgroundColor(isPressed: configuration.isPressed, isEnabled: isEnabled)
        let borderColor = style.borderColor(isEnabled: isEnabled)
        
        return configuration.label
            .font(.bold, size: 18, lineHeight: 24)
            .padding(.vertical, 16)
            .frame(maxWidth: .infinity)
            .foregroundColor(foregroundColor)
            .background(backgroundColor)
            .cornerRadius(12)
            .overlay(RoundedRectangle(cornerRadius: 12).stroke(borderColor))
    }
}
