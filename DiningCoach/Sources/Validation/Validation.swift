//
//  Validation.swift
//  DiningCoach
//
//  Created by 백정수 on 2023/06/10.
//

import Foundation

class Validation {
    static func containsLowercase(_ password: String) -> Bool {
        let lowercaseTest = NSPredicate(format: "SELF MATCHES %@", ".*[a-z]+.*")
        return lowercaseTest.evaluate(with: password)
    }

    static func isPasswordLength(_ password: String) -> Bool {
        return password.count >= 8 && password.count <= 16
    }

    static func containsTwoTypes(_ password: String) -> Bool {
        let pattern = "^(?:(?=.*[a-z])(?=.*[0-9])|(?=.*[a-z])(?=.*[^a-z0-9])|(?=.*[0-9])(?=.*[^a-z0-9])).+$"
        let regexTest = NSPredicate(format: "SELF MATCHES %@", pattern)
        return regexTest.evaluate(with: password)
    }

    
    static func containsOneTypes(_ nickname: String) -> Bool {
        let pattern = "^(?=.*[a-zA-Zㄱ-ㅎㅏ-ㅣ가-힣0-9]).*$"
        let regexTest = NSPredicate(format: "SELF MATCHES %@", pattern)
        return regexTest.evaluate(with: nickname)
    }
    
    static func isNicknameLength(_ nickname: String) -> Bool {
        return nickname.count <= 16
    }

    static func isPasswordSame(_ newPassword: String,_ confirmPassword: String ) -> Bool {
        return newPassword == confirmPassword ? true : false
    }
}
