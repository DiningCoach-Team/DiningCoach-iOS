//
//  DCButton+Style.swift
//  DiningCoach
//
//  Created by chamsol kim on 2023/06/14.
//

import SwiftUI

extension DCButton {
    
    enum Style {
        case primary
        case secondary
        
        func foregroundColor(isEnabled: Bool) -> Color {
            isEnabled ? normalForegroundColor : disabledForegroundColor
        }
        
        func backgroundColor(isPressed: Bool, isEnabled: Bool) -> Color {
            guard isEnabled else {
                return disabledBackgroundColor
            }
            
            return isPressed ? pressedBackgroundColor : normalBackgroundColor
        }
        
        func borderColor(isEnabled: Bool) -> Color {
            isEnabled ? normalBorderColor : disabledBorderColor
        }
    }
}

private extension DCButton.Style {
    
    var normalForegroundColor: Color {
        switch self {
        case .primary:
            return Color.white
        case .secondary:
            return Color.primary500
        }
    }
    
    var disabledForegroundColor: Color {
        switch self {
        case .primary:
            return Color.white
        case .secondary:
            return Color.neutral100
        }
    }
    
    var normalBackgroundColor: Color {
        switch self {
        case .primary:
            return Color.primary500
        case .secondary:
            return Color.white
        }
    }
    
    var pressedBackgroundColor: Color {
        switch self {
        case .primary:
            return Color.primary700
        case .secondary:
            return Color.primary100
        }
    }
    
    var disabledBackgroundColor: Color {
        switch self {
        case .primary:
            return Color.neutral100
        case .secondary:
            return Color.white
        }
    }
    
    var normalBorderColor: Color {
        switch self {
        case .primary:
            return Color.clear
        case .secondary:
            return Color.primary500
        }
    }
    
    var disabledBorderColor: Color {
        switch self {
        case .primary:
            return Color.clear
        case .secondary:
            return Color.neutral100
        }
    }
}
