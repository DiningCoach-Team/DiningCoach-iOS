//
//  AllergiesInputView.swift
//  DiningCoach
//
//  Created by 심현석 on 2023/06/23.
//

import SwiftUI

struct AllergiesInputView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var selectedAllergy = Set<Allergy>()
    
    @State private var isCompleted: Bool = false
    
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
                Text("알레르기 정보를 선택해 주세요")
                    .font(.bold, size: 22, lineHeight: 28)
                    .frame(height: 28)
            }
            .padding(.vertical, 16)
            
            VStack {
                LazyVGrid(columns: [GridItem(), GridItem(), GridItem()], spacing: 16) {
                    ForEach(Allergy.allCases, id: \.self) { allergy in
                        AllergyButton(allergy: allergy, state: selectedAllergy.contains(allergy) ? .selected : .unselected) {
                            if selectedAllergy.contains(allergy) {
                                selectedAllergy.remove(allergy)
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
    
struct AllergiesInputView_Previews: PreviewProvider {
    static var previews: some View {
        AllergiesInputView()
    }
}
