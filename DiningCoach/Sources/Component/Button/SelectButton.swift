//
//  SelectButton.swift
//  DiningCoach
//
//  Created by 심현석 on 2023/06/25.
//

import SwiftUI

protocol SelectButtonElement {
    var name: String { get }
    var imageString: String { get }
}

struct SelectButton<Element: SelectButtonElement>: View {
    
    enum State {
        case selected
        case unselected
    }
    
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
                    
                    VStack(spacing: 0) {
                        Image(element.imageString)
                            .resizable()
                            .frame(width: 48, height: 48)
                        
                        Spacer()
                            .frame(height: 8)
                        
                        Text(element.name)
                            .font(.bold, size: 16, lineHeight: 24)
                            .frame(height: 24)
                            .foregroundColor(Color.neutral900)
                    }
                    .padding(.vertical, 12)
                } else {
                    Color.primary50
                    
                    VStack(spacing: 0) {
                        Image(element.imageString)
                            .resizable()
                            .frame(width: 52, height: 52)
                        
                        Spacer()
                            .frame(width: 8)
                        
                        Text(element.name)
                            .font(.bold, size: 18, lineHeight: 24)
                            .frame(height: 24)
                            .foregroundColor(Color.primary500)
                    }
                    .padding(.vertical, 10)
                }
            }
            .frame(width: 104, height: 104)
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 0)
        }
    }
    
    init(element: Element, state: State, action: @escaping () -> Void) {
        self.element = element
        self.state = state
        self.action = action
    }
}

struct SelectButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            SelectButton(element: PreferredFoodInputView.Food.agriculture, state: .selected) { }
            SelectButton(element: PreferredFoodInputView.Food.agriculture, state: .unselected) { }
        }
    }
}
