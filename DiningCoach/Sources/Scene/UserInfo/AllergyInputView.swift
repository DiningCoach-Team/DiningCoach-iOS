//
//  AllergyInputView.swift
//  DiningCoach
//
//  Created by 심현석 on 2023/06/23.
//

import SwiftUI

struct AllergyInputView: View {
    @Environment(\.dismiss) var dismiss
    @State private var isCompleted: Bool = false
    
    @State private var selectedAllergy = Set<Allergy>()
    
    var body: some View {
        VStack(spacing: 0) {
            VStack {
                ProgressView(value: 7, total: 7)
                    .tint(Color.primary500)
            }
            .padding(.vertical, 8)
            
            VStack(alignment: .leading) {
                Text("알레르기 정보를 선택해 주세요")
                    .font(.bold, size: 22, lineHeight: 28)
                    .frame(height: 28)
            }
            .padding(.vertical, 16)
            
            ScrollView {
                VStack {
                    LazyVGrid(columns: [GridItem(), GridItem(), GridItem()], spacing: 16) {
                        ForEach(Allergy.allCases, id: \.self) { allergy in
                            SelectButton(element: allergy, state: selectedAllergy.contains(allergy) ? .selected : .unselected) {
                                if selectedAllergy.contains(allergy) {
                                    selectedAllergy.remove(allergy)
                                } else {
                                    selectedAllergy.insert(allergy)
                                }
                                // input data
                            }
                        }
                    }
                }
                .padding(.vertical, 8)
            }
            
            VStack {
                if selectedAllergy.isEmpty {
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
            UserInfoCompleteView()
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
    
struct AllergyInputView_Previews: PreviewProvider {
    static var previews: some View {
        AllergyInputView()
    }
}

enum Allergy: SelectButtonElement, CaseIterable {
    case none
    case egg
    case milk
    case beef
    case pork
    case chicken
    case crab
    case shrimp
    case mackerel
    case shellfish
    case wheat
    case peach
    case tomato
    case peanut
    case soy
    case buckwheat
    case walnut
    case nuts
    
    var name: String {
        switch self {
        case .none:
            return "해당없음"
        case .egg:
            return "알류"
        case .milk:
            return "우유"
        case .beef:
            return "소고기"
        case .pork:
            return "돼지고기"
        case .chicken:
            return "닭고기"
        case .crab:
            return "게"
        case .shrimp:
            return "새우"
        case .mackerel:
            return "고등어"
        case .shellfish:
            return "조개"
        case .wheat:
            return "밀"
        case .peach:
            return "복숭아"
        case .tomato:
            return "토마토"
        case .peanut:
            return "땅콩"
        case .soy:
            return "대두"
        case .buckwheat:
            return "메밀"
        case .walnut:
            return "호두"
        case .nuts:
            return "견과류"
        }
    }
    
    
    var imageString: String {
        switch self {
        case .none:
            return "Property=해당없음"
        case .egg:
            return "Property=난류"
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
