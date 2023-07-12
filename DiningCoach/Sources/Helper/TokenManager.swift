//
//  TokenManager.swift
//  DiningCoach
//
//  Created by 이송미 on 2023/07/12.
//

import Foundation


final class TokenManager {
    public static let shared = TokenManager()
    var token: SsoResponse? = nil
    
    let key = "com.diningcoach.token"
    
    init() {
        if let tokenData = UserDefaults.standard.data(forKey: key) {
            let token = try? JSONDecoder().decode(SsoResponse.self, from: tokenData)
            self.token = token
        }
    }
    
    func setToken(token: SsoResponse) {
        if let data = try? JSONEncoder().encode(token) {
            UserDefaults.standard.set(data, forKey: key)
            UserDefaults.standard.synchronize()
            
            self.token = token
        }
    }
    
    func getToken() -> SsoResponse? {
        return token
    }
    
    func deleteToken() {
        UserDefaults.standard.removeObject(forKey: key)
        self.token = nil
    }
}
