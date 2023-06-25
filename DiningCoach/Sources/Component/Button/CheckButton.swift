//
//  CheckButton.swift
//  DiningCoach
//
//  Created by 심현석 on 2023/06/24.
//

import SwiftUI

protocol CheckButtonElement {
    var type: String { get }
}

struct CheckButton<Element: CheckButtonElement>: View {
    enum State {
        case selected
        case unselected
    }
    
    @Environment(\.isEnabled) var isEnabled: Bool
    
    private let element: Element
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
                        Text(element.type)
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
                        Text(element.type)
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
    
    init(element: Element, state: State, action: @escaping () -> Void) {
        self.element = element
        self.state = state
        self.action = action
    }
}

struct CheckButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CheckButton(element: Exercise.between1And5Hours, state: .selected){ }
            CheckButton(element: Exercise.between1And5Hours, state: .unselected) { }
        }
    }
}
