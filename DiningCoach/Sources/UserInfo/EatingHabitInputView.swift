//
//  EatingHabitInputView.swift
//  DiningCoach
//
//  Created by 심현석 on 2023/06/23.
//

import SwiftUI

struct EatingHabitInputView: View {
    @Environment(\.dismiss) var dismiss
    @State private var isCompleted: Bool = false
    
    @State private var selectedHabit = Set<EatingHabit>()
    
    var body: some View {
        VStack(spacing: 0) {
            
            VStack {
                ProgressView(value: 5, total: 7)
                    .tint(Color.primary500)
            }
            .padding(.vertical, 8)
            
            VStack(alignment: .leading) {
                Text("해당하는 식습관을 선택해 주세요")
                    .font(.bold, size: 22, lineHeight: 28)
                    .frame(height: 28)
            }
            .padding(.vertical, 16)
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 15) {
                    ForEach(EatingHabit.allCases, id: \.self) { habit in
                        CheckButton(element: habit, state: selectedHabit.contains(habit) ? .selected : .unselected) {
                            if selectedHabit.contains(habit) {
                                selectedHabit.remove(habit)
                            } else {
                                selectedHabit.insert(habit)
                            }
                            // input data
                        }
                    }
                }
                .padding(.vertical, 8)
            }
            
            VStack {
                if selectedHabit.isEmpty {
                    DCButton("다음", style: .primary) { }
                        .disabled(true)
                } else {
                    DCButton("다음", style: .primary) {
                        isCompleted = true
                        // send data
                    }
                }
            }
            .padding(.vertical, 16)
        }
        .padding(.horizontal, 16)
        .navigationDestination(isPresented: $isCompleted) {
            MedicalConditionInputView()
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.backward")
                        .tint(.black)
                }
            }
            
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .tint(.black)
                }
            }
        }
    }
}

struct EatingHabitInputView_Previews: PreviewProvider {
    static var previews: some View {
        EatingHabitInputView()
    }
}

enum EatingHabit: CheckButtonElement, CaseIterable {
    case none
    case lowSalt
    case iodineLimitation
    case fiberLimited
    case hardFoodLimited
    case vegan
    case halal
    
    var type: String {
        switch self {
        case .none:
            return "해당없음"
        case .lowSalt:
            return "저염 식단"
        case .iodineLimitation:
            return "요오드 제한 식단"
        case .fiberLimited:
            return "섬유질을 많이 먹지 못해요"
        case .hardFoodLimited:
            return "딱딱한 음식 잘 먹지 못해요"
        case .vegan:
            return "비건 식단 지향"
        case .halal:
            return "할랄음식 먹어요"
        }
    }
}
