//
//  Urls.swift
//  DiningCoach
//
//  Created by 이송미 on 2023/07/05.
//

import Foundation

public struct Hosts {
    public static let shared = Hosts()
    
    public let base = "virtserver.swaggerhub.com/DININGCOACHTEAM/DiningCoach_API_v1/1.0.0" // "diningcoach.org"    
}

public struct Paths {
    public static let requestSso = "/api/v1/auth/sso"
    public static let login = "/api/v1/auth/login"
    public static let register = "/api/v1/auth/register"
    public static let refresh = "/api/v1/auth/refresh"    
}

public struct Urls {
    public static func compose(_ host: String = Hosts.shared.base, path: String) -> String {
        return "https://\(host)\(path)"
    }
}
