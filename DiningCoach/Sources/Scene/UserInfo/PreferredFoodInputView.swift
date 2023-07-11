//
//  PreferredFoodInputView.swift
//  DiningCoach
//
//  Created by 심현석 on 2023/06/23.
//

import SwiftUI

struct PreferredFoodInputView: View {
    @Environment(\.dismiss) var dismiss
    @State private var isCompleted: Bool = false
    
    @State private var selectedFoods = Set<Food>()
    
    // Error: LazyVGrid에 바로 지정해주지 않으면 다음페이지로 이동이 안된다.
    //    let columns = [
    //        GridItem(.flexible()),
    //        GridItem(.flexible()),
    //        GridItem(.flexible())
    //    ]
    
    var body: some View {
        VStack(spacing: 0) {
            VStack {
                ProgressView(value: 4, total: 7)
                    .tint(Color.primary500)
            }
            .padding(.vertical, 8)
            
            VStack(alignment: .leading, spacing: 0) {
                Text("선호하시는 음식을 선택해 주세요")
                    .font(.bold, size: 22, lineHeight: 28)
                    .frame(height: 28)
                
                Spacer()
                    .frame(height: 8)
                
                Text("최대 5개까지 선택해주세요.")
                    .font(.bold, size: 16, lineHeight: 24)
                    .frame(height: 24)
                    .foregroundColor(Color.neutral600)
            }
            .padding(.vertical, 16)
            
            VStack {
                LazyVGrid(columns: [GridItem(), GridItem(), GridItem()], spacing: 16) {
                    ForEach(Food.allCases, id: \.self) { food in
                        SelectButton(element: food, state: selectedFoods.contains(food) ? .selected : .unselected) {
                            if selectedFoods.contains(food) {
                                selectedFoods.remove(food)
                            } else if selectedFoods.count < 5 {
                                selectedFoods.insert(food)
                            }
                            // input data
                        }
                    }
                }
            }
            .padding(.vertical, 8)
            
            Spacer()
            
            VStack {
                if selectedFoods.isEmpty {
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
            EatingHabitInputView()
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

struct PreferredFoodInputView_Previews: PreviewProvider {
    static var previews: some View {
        PreferredFoodInputView()
    }
}

enum Food: SelectButtonElement ,CaseIterable {
    case convenience
    case livestock
    case cooking
    case noodles
    case seafood
    case bread
    case snack
    case agriculture
    case dairy
    case beverage
    case health
    case alcohol
    
    var name: String {
        switch self {
        case .convenience:
            return "간편식"
        case .livestock:
            return "축산물"
        case .cooking:
            return "조리식"
        case .noodles:
            return "면류"
        case .seafood:
            return "수산물"
        case .bread:
            return "빵/떡"
        case .snack:
            return "간식"
        case .agriculture:
            return "농산물"
        case .dairy:
            return "유제품"
        case .beverage:
            return "음료"
        case .health:
            return "건강식품"
        case .alcohol:
            return "주류"
        }
    }
    
    var imageString: String {
        switch self {
        case .convenience:
            return "Property=간편식"
        case .livestock:
            return "Property=고기류"
        case .cooking:
            return "Property=국"
        case .noodles:
            return "Property=면류"
        case .seafood:
            return "Property=해산물"
        case .bread:
            return "Property=베이커리"
        case .snack:
            return "Property=간식"
        case .agriculture:
            return "Property=샐러드"
        case .dairy:
            return "Property=유제품"
        case .beverage:
            return "Property=음료"
        case .health:
            return "Property=건강식품"
        case .alcohol:
            return "Property=주류"
        }
    }
}
