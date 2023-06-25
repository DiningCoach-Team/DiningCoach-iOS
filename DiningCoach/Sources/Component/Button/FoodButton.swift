//
//  FoodButton.swift
//  DiningCoach
//
//  Created by 심현석 on 2023/06/24.
//

import SwiftUI

enum Food: String, CaseIterable {
    case convenience = "간편식"
    case livestock = "축산물"
    case cooking = "조리식"
    case noodles = "면류"
    case seafood = "수산물"
    case bread = "빵/떡"
    case snack = "간식"
    case agriculture = "농산물"
    case dairy = "유제품"
    case beverage = "음료"
    case health = "건강식품"
    case alcohol = "주류"

    var image: Image {
        switch self {
        case .convenience:
            return Image("Property=간편식")
        case .livestock:
            return Image("Property=고기류")
        case .cooking:
            return Image("Property=국")
        case .noodles:
            return Image("Property=면류")
        case .seafood:
            return Image("Property=해산물")
        case .bread:
            return Image("Property=베이커리")
        case .snack:
            return Image("Property=간식")
        case .agriculture:
            return Image("Property=샐러드")
        case .dairy:
            return Image("Property=유제품")
        case .beverage:
            return Image("Property=음료")
        case .health:
            return Image("Property=건강식품")
        case .alcohol:
            return Image("Property=주류")
        }
    }
}

struct FoodButton: View {
    private let food: Food
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
                        Spacer()
                            .frame(height: 12)
                        
                        food.image
                            .resizable()
                            .frame(width: 48, height: 48)
                        
                        Spacer()
                            .frame(height: 8)
                        
                        Text(food.rawValue)
                            .font(.bold, size: 16, lineHeight: 24)
                            .frame(height: 24)
                            .foregroundColor(Color.neutral900)
                        
                        Spacer()
                            .frame(width: 12)
                    }
                } else {
                    Color.primary50
                    
                    VStack(spacing: 0) {
                        Spacer()
                            .frame(height: 10)
                        
                        food.image
                            .resizable()
                            .frame(width: 52, height: 52)
                        
                        Spacer()
                            .frame(width: 8)
                        
                        Text(food.rawValue)
                            .font(.bold, size: 18, lineHeight: 24)
                            .frame(height: 24)
                            .foregroundColor(Color.primary500)
                        
                        Spacer()
                            .frame(width: 10)
                    }
                }
            }
            .frame(width: 104, height: 104)
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 0)
        }
    }
    
    init(food: Food, state: State, action: @escaping () -> Void) {
        self.food = food
        self.state = state
        self.action = action
    }
}

extension FoodButton {
    enum State {
        case selected
        case unselected
    }
}

struct FoodButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            FoodButton(food: .agriculture, state: .selected) { }
            FoodButton(food: .agriculture, state: .unselected) { }
        }
    }
}

