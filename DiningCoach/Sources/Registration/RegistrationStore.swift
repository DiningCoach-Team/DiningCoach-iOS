//
//  RegistrationStore.swift
//  DiningCoach
//
//  Created by 백정수 on 2023/06/10.
//

import SwiftUI

class RegistrationStore: ObservableObject {
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var nickname: String = ""
    
    // 실제 사용 시에는 서버에서 중복 확인을 진행해야 함.
    let usedNicknames = ["sample1", "sample2", "sample3"]

    var isPasswordValid: Bool? {

       
        return Validation.containsLowercase(password) &&
        Validation.isPasswordLength(password) &&
        Validation.containsTwoTypes(password)
    }
    
    var isConfirmPasswordValid: Bool? {

        return password == confirmPassword
    }


    var isNicknameValid: Bool? {


        return Validation.containsOneTypes(nickname) &&
        Validation.isNicknameLength(nickname)
    }
    
    var isNicknameDuplicated: Bool {

            return usedNicknames.contains(nickname)
        
    }
}

