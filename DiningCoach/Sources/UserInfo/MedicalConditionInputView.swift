//
//  MedicalConditionsInputView.swift
//  DiningCoach
//
//  Created by 심현석 on 2023/06/23.
//

import SwiftUI

struct MedicalConditionInputView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var selectedHabit = Set<MedicalCondition>()
    
    @State private var isCompleted: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
                .frame(height: 10)
            
            ProgressView(value: 6, total: 7)
                .tint(Color.primary500)
            
            Spacer()
                .frame(height: 24)
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    HStack {
                        Text("질병 정보를 선택해 주세요")
                            .font(.bold, size: 22, lineHeight: 28)
                        
                        Spacer()
                    }
                    
                    Spacer()
                        .frame(height: 24)
                    
                    VStack(spacing: 16) {
                        ForEach(MedicalCondition.allCases, id: \.self) { condition in
                            CheckmarkButton(title: condition.rawValue, state: selectedHabit.contains(condition) ? .selected : .unselected) {
                                if selectedHabit.contains(condition) {
                                    selectedHabit.remove(condition)
                                } else {
                                    selectedHabit.insert(condition)
                                }
                                // input data
                            }
                        }
                    }
                    
                    Spacer()
                        .frame(height: 10)
                }
            }
            
            //            if selectedExerciseButton == nil || selectedSleepButton == nil {
            //                DCButton("다음", style: .primary) { }
            //                    .disabled(true)
            //            } else {
            //                DCButton("다음", style: .primary) {
            //                    isCompleted = true
            //                    // send data
            //                }
            //            }
            DCButton("다음", style: .primary) {
                isCompleted = true
            }
            
            Spacer()
                .frame(height: 10)
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

enum MedicalCondition: String, CaseIterable {
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
}
