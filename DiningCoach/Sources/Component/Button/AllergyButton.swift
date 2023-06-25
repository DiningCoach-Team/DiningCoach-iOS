//
//  AllergyButton.swift
//  DiningCoach
//
//  Created by 심현석 on 2023/06/24.
//

import SwiftUI

enum Allergy: String, CaseIterable {
    case none = "해당없음"
    case egg = "알류"
    case milk = "우유"
    case beef = "소고기"
    case pork = "돼지고기"
    case chicken = "닭고기"
    case crab = "게"
    case shrimp = "새우"
    case mackerel = "고등어"
    case shellfish = "조개"
    case wheat = "밀"
    case peach = "복숭아"
    case tomato = "토마토"
    case peanut = "땅콩"
    case soy = "대두"
    case buckwheat = "메밀"
    case walnut = "호두"
    case nuts = "견과류"

    var imageString: String {
        switch self {
        case .none:
            return "Property=해당없음"
        case .egg:
            return "Property=알류"
        case .milk:
            return "Property=우유"
        case .beef:
            return "Property=소고기"
        case .pork:
            return "Property=돼지고기"
        case .chicken:
            return "Property=닭고기"
        case .crab:
            return "Property=게"
        case .shrimp:
            return "Property=새우"
        case .mackerel:
            return "Property=고등어"
        case .shellfish:
            return "Property=조개"
        case .wheat:
            return "Property=밀"
        case .peach:
            return "Property=복숭아"
        case .tomato:
            return "Property=토마토"
        case .peanut:
            return "Property=땅콩"
        case .soy:
            return "Property=대두"
        case .buckwheat:
            return "Property=메밀"
        case .walnut:
            return "Property=호두"
        case .nuts:
            return "Property=견과류"
        }
    }
}

struct AllergyButton: View {
    private let allergy: Allergy
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
                        
                        Image(allergy.imageString)
                            .resizable()
                            .frame(width: 48, height: 48)
                        
                        Spacer()
                            .frame(height: 8)
                        
                        Text(allergy.rawValue)
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
                        
                        Image(allergy.imageString)
                            .resizable()
                            .frame(width: 52, height: 52)
                        
                        Spacer()
                            .frame(width: 8)
                        
                        Text(allergy.rawValue)
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
    
    init(allergy: Allergy, state: State, action: @escaping () -> Void) {
        self.allergy = allergy
        self.state = state
        self.action = action
    }
}

extension AllergyButton {
    enum State {
        case selected
        case unselected
    }
}

struct AllergyButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            AllergyButton(allergy: .beef, state: .selected) { }
            AllergyButton(allergy: .beef, state: .unselected) { }
        }
    }
}
