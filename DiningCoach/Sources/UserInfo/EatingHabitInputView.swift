//
//  EatingHabitInputView.swift
//  DiningCoach
//
//  Created by 심현석 on 2023/06/23.
//

import SwiftUI

struct EatingHabitInputView: View {
    
    
    var body: some View {
        VStack {
            Text("1")
        }
    }
}
    
struct EatingHabitInputView_Previews: PreviewProvider {
    static var previews: some View {
        EatingHabitInputView()
    }
}

enum EatingHabit: String, CaseIterable {
    case none = "해당없음"
    case lowSalt = "저염 식단"
    case iodineLimitation = "요오드 제한 식단"
    case fiberLimited = "섬유질을 많이 먹지 못해요"
    case hardFoodLimited = "딱딱한 음식 잘 먹지 못해요"
    case vegan = "비건 식단 지향"
    case halal = "할랄음식 먹어요"
}
