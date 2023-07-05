//
//  Login.swift
//  DiningCoach
//
//  Created by 이송미 on 2023/07/05.
//

import Foundation

public enum PlatformType: String, Codable {
    case kakao, google, apple
}

struct SsoResponse: Codable {
    let userId: Int64
    let newUser: Bool?
    let accessToken: String
    let refreshToken: String
}

struct User: Codable {
    let id: Int64
    let userName: String
    let firstName: String
    let email: String
    let password: String
    let phone: String
    let userStatus: Int32
}
