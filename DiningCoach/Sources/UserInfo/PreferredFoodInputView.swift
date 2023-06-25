//
//  PreferredFoodInputView.swift
//  DiningCoach
//
//  Created by 심현석 on 2023/06/23.
//

import SwiftUI

struct PreferredFoodInputView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var selectedFoods = Set<Food>()
    
    @State private var isCompleted: Bool = false
    
    // Error: LazyVGrid에 바로 지정해주지 않으면 다음페이지로 이동이 안된다.
//    let columns = [
//        GridItem(.flexible()),
//        GridItem(.flexible()),
//        GridItem(.flexible())
//    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Spacer()
                .frame(height: 10)
            
            VStack {
                ProgressView(value: 4, total: 6)
                    .tint(Color.primary500)
            }
            .padding(.vertical, 8)
            
            VStack(alignment: .leading) {
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
                        FoodButton(food: food, state: selectedFoods.contains(food) ? .selected : .unselected) {
                            if selectedFoods.contains(food) {
                                selectedFoods.remove(food)
                            } else if selectedFoods.count < 5 {
                                selectedFoods.insert(food)
                            }
                        }
                    }
                }
            }
            .padding(.top, 8)
            .padding(.bottom, 3)
            
            Spacer()
            
            VStack {
//                if selectedFoods.isEmpty {
//                    DCButton("다음", style: .primary) { }
//                        .disabled(true)
//                } else {
//                    DCButton("다음", style: .primary) {
//                        isCompleted = true
//                        // send data
//                    }
//                }
                DCButton("다음", style: .primary) {
                    isCompleted = true
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

