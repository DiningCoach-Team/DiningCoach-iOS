//
//  MedicalConditionsInputView.swift
//  DiningCoach
//
//  Created by 심현석 on 2023/06/23.
//

import SwiftUI

struct MedicalConditionInputView: View {
    @Environment(\.dismiss) var dismiss
    @State private var isCompleted: Bool = false
    
    @State private var selectedHabit = Set<MedicalCondition>()
    
    var body: some View {
        VStack(spacing: 0) {
            VStack {
                ProgressView(value: 6, total: 7)
                    .tint(Color.primary500)
            }
            .padding(.vertical, 8)
            
            VStack(alignment: .leading) {
                Text("질병 정보를 선택해 주세요")
                    .font(.bold, size: 22, lineHeight: 28)
                    .frame(height: 28)
            }
            .padding(.vertical, 16)
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 16) {
                    ForEach(MedicalCondition.allCases, id: \.self) { condition in
                        CheckButton(element: condition, state: selectedHabit.contains(condition) ? .selected : .unselected) {
                            if selectedHabit.contains(condition) {
                                selectedHabit.remove(condition)
                            } else {
                                selectedHabit.insert(condition)
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
            AllergyInputView()
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

struct MedicalConditionsInputView_Previews: PreviewProvider {
    static var previews: some View {
        MedicalConditionInputView()
    }
}

enum MedicalCondition: String, CheckButtonElement,CaseIterable {
    case none = "해당없음"
    case diabetes = "당뇨병"
    case hypertension = "고혈압"
    case hyperlipidemia = "고지혈증"
    case cancerTreatment = "항암 치료"
    case kidneyDisease = "신장 관련 지병"
    case heartDisease = "심장 관련 지병"
    case thyroidDisease = "갑상선 질환"
    case gout = "통풍"
    case skinDisease = "피부병"
    case menieresDisease = "메니에르병"
    
    var type: String {
        return rawValue
    }
}
