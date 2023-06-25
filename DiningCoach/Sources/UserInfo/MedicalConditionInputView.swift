//
//  MedicalConditionsInputView.swift
//  DiningCoach
//
//  Created by 심현석 on 2023/06/23.
//

import SwiftUI

struct MedicalConditionInputView: View {
    
    
    var body: some View {
        VStack {
            
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
