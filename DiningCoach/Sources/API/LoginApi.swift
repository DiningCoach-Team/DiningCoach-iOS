//
//  LoginAPI.swift
//  DiningCoach
//
//  Created by 이송미 on 2023/07/10.
//

import Foundation
import Alamofire

final public class LoginApi {
    static let shared = LoginApi()
    let loginSession: Session
    
    init() {
        let apiConfiguration = URLSessionConfiguration.default
        apiConfiguration.tlsMinimumSupportedProtocolVersion = .TLSv12
        loginSession = Session(configuration: apiConfiguration, interceptor: DCInterceptor())
    }
    
}

extension LoginApi {
    func loginWithSso(platformType: PlatformType, userAgent: String, accessToken: String, completion: @escaping (SsoResponse?, Error?) -> Void) {
        loginSession.request(Urls.compose(path: Paths.requestSso), method: .post, parameters: ["platformType": platformType, "userAgent": userAgent, "accessToken": accessToken])
            .responseDecodable(of: SsoResponse.self) { [weak self] response in
                self?.handleResponse(response: response, completion: completion)
            }
    }
    
    func loginWithEmail(email: String, password: String, completion: @escaping (SsoResponse?, Error?) -> Void) {
        loginSession.request(Urls.compose(path: Paths.login), method: .post, parameters: ["email": email, "password": password])
            .responseDecodable(of: SsoResponse.self) { [weak self] response in
                self?.handleResponse(response: response, completion: completion)
            }
    }
    
    func register(email: String, password: String, completion: @escaping (SsoResponse?, Error?) -> Void) {
        loginSession.request(Urls.compose(path: Paths.register), method: .post, parameters: ["email": email, "password": password])
            .responseDecodable(of: SsoResponse.self) { [weak self] response in
                self?.handleResponse(response: response, completion: completion)
            }
    }
    
    func refresh(userId: String, refreshToken: String, completion: @escaping (SsoResponse? , Error?) -> Void) {
        loginSession.request(Urls.compose(path: Paths.refresh), method: .post, parameters: ["userId": userId, "refreshToken": refreshToken])
            .responseDecodable(of: SsoResponse.self) { [weak self] response in
                self?.handleResponse(response: response, completion: completion)
            }
    }
}

extension LoginApi {
    private func handleResponse(response: DataResponse<SsoResponse, AFError>, completion: @escaping (SsoResponse?, Error?) -> Void) {
        switch response.result {
        case .success(let result):
            completion(result, nil)
        case .failure(let error):
            completion(nil, error)
        }
    }
}

