//
//  CheckButton.swift
//  DiningCoach
//
//  Created by 심현석 on 2023/06/24.
//

import SwiftUI

enum ButtonState {
    case selected
    case unselected
}

struct CheckButton: View {
    @Environment(\.isEnabled) var isEnabled: Bool
    
    private let title: String
    private let state: ButtonState
    private let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                if state == .unselected {
                    Color.white
                    
                    HStack {
                        Spacer()
                            .frame(width: 16)
                        Text(title)
                            .font(.bold, size: 16, lineHeight: 24)
                            .foregroundColor(Color.neutral900)
                        Spacer()
                        Image(systemName: "checkmark")
                            .foregroundColor(.white)
                            .frame(width: 24, height: 24)
                            .background(Color.neutral100)
                            .cornerRadius(6)
                        Spacer()
                            .frame(width: 16)
                    }
                } else {
                    Color.primary50
                    
                    HStack {
                        Spacer()
                            .frame(width: 16)
                        Text(title)
                            .font(.bold, size: 18, lineHeight: 24)
                            .foregroundColor(Color.primary500)
                        Spacer()
                        Image(systemName: "checkmark")
                            .foregroundColor(.white)
                            .frame(width: 24, height: 24)
                            .background(Color.primary500)
                            .cornerRadius(6)
                        Spacer()
                            .frame(width: 16)
                    }
                }
            }
            .frame(height: 64)
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.06), radius: 10, x: 0, y: 0)
        }
    }
    
    init(title: String, state: ButtonState, action: @escaping () -> Void) {
        self.title = title
        self.state = state
        self.action = action
    }
}

struct CheckButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CheckButton(title: "1시간 미만", state: .selected) { }
            CheckButton(title: "1시간 미만", state: .unselected) { }
        }
    }
}
