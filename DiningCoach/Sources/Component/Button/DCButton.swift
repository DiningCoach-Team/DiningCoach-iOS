//
//  DCButton.swift
//  DiningCoach
//
//  Created by chamsol kim on 2023/06/14.
//

import SwiftUI

struct DCButton: View {
    
    // MARK: - Environment
    
    @Environment(\.isEnabled) var isEnabled: Bool
    
    
    // MARK: - Body
    
    var body: some View {
        Button(title, action: action)
            .buttonStyle(DCButtonStyle(style: style, isEnabled: isEnabled))
    }
    
    
    // MARK: - Attribute
    
    private let title: LocalizedStringKey
    private let style: Style
    private let action: () -> Void
    
    
    // MARK: - Initialization
    
    init(_ title: LocalizedStringKey, style: Style, action: @escaping () -> Void) {
        self.title = title
        self.style = style
        self.action = action
    }
}

struct DCButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            DCButton("Primary", style: .primary) {
                print("Primary Normal")
            }
            .disabled(false)
            DCButton("Primary Disabled", style: .primary) {
                print("Primary Disabled")
            }
            .disabled(true)
            DCButton("Secondary Normal", style: .secondary) {
                print("Secondary Normal")
            }
            .disabled(false)
            DCButton("Secondary Disabled", style: .secondary) {
                print("Secondary Disabled")
            }
            .disabled(true)
        }
        .padding(16)
        .background(Color.gray.opacity(0.3))
    }
}
