//
//  CheckmarkButton.swift
//  DiningCoach
//
//  Created by 심현석 on 2023/06/24.
//

import SwiftUI

struct CheckmarkButton: View {
    @Environment(\.isEnabled) var isEnabled: Bool
    
    private let title: String
    private let state: State
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
            .frame(width: 343, height: 64)
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.06), radius: 10, x: 0, y: 0)
        }
    }
    
    init(_ title: String, state: State, action: @escaping () -> Void) {
        self.title = title
        self.state = state
        self.action = action
    }
}

extension CheckmarkButton {
    enum State {
        case selected
        case unselected
    }
}

struct CheckmarkButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CheckmarkButton("1시간 미만", state: .selected) { }
            CheckmarkButton("1시간 미만", state: .unselected) { }
        }
    }
}
