//
//  DCTextFieldStyle.swift
//  DiningCoach
//
//  Created by 이송미 on 2023/06/30.
//

import SwiftUI

extension DCTextField {
    enum Style {
        case normal
        case correct
        case error
        
        func foregroundColor(isEmpty: Bool) -> Color {
            if isEmpty {
                return .neutral400
            }
            
            switch self {
            case .correct:
                return .primary500
            case .error:
                return .orange
            default:
                return .neutral900
            }
        }
    }
}
