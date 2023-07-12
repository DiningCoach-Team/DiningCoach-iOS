//
//  LoginStore.swift
//  DiningCoach
//
//  Created by 백정수 on 2023/06/03.
//

import SwiftUI
import KakaoSDKAuth
import KakaoSDKUser
import AuthenticationServices
import GoogleSignIn

// MARK: Login Store Protocol

class LoginStore: NSObject, ObservableObject, ASAuthorizationControllerDelegate {
    @Published var isNextViewPresented = false
    @Published var oauthToken: OAuthToken?
    @Published var user: User?
    
    let loginApi = LoginApi.shared
    private var appleLoginDelegator: ((Result<Bool, Error>) -> Void)? = nil
    
}
    
extension LoginStore {
    // MARK: - kakao login
    func kakaoLogin(completion: @escaping (Result<Bool, Error>) -> Void) {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk { [weak self] (oauthToken, error) in
                self?.handleKakaoToken(oauthToken: oauthToken, error: error, completion: completion)
            }
            
        } else {
            UserApi.shared.loginWithKakaoAccount { [weak self] (oauthToken, error) in
                self?.handleKakaoToken(oauthToken: oauthToken, error: error, completion: completion)
            }
        }
    }
    
    private func handleKakaoToken(oauthToken: OAuthToken? , error: Error?, completion: @escaping (Result<Bool, Error>) -> Void) {
        if let error = error {
            print("카카오 로그인 실패: \(error.localizedDescription)")
            completion(.failure(error))
            return
        }
        
        self.handleSsoLogin(platformType: .kakao, accessToken: oauthToken!.accessToken, completion: completion)
        self.kakaoUserInfo()
    }
    
    private func kakaoUserInfo() {
        UserApi.shared.me() { (user, error) in
            if let error = error {
                print("사용자 정보 요청 실패: \(error.localizedDescription)")
                return
            }
            
            if let user = user {
                print("사용자 정보: \(user)")
                self.isNextViewPresented = true
            }
        }
    }
    
    // MARK: - apple login
    func appleLogin(completion: @escaping (Result<Bool, Error>) -> Void) {
        self.appleLoginDelegator = completion
        
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.email]

        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.performRequests()
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIdCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            // TODO: Sign in Apple은 access token을 반환하지 않음, 서버를 통해 access token 발급
        }
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Authorization failed: \(error.localizedDescription)")
    }
    
    // MARK: - google login
    func googleLogin(completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let rootViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else { return }
        
        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { (signInResult, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let result = signInResult else {
                completion(.success(false))
                return
            }
            
            self.handleSsoLogin(platformType: .google, accessToken: result.user.accessToken.tokenString, completion: completion)
        }
    }
}

extension LoginStore {
    func isLogin() -> Bool {
        let storedToken = TokenManager.shared.getToken()
        
        if let storedToken = storedToken {
            // TODO: Request server
            // check valid access token
            // if not valid issue the token by refresh token
            // also refresh token is not valid go to login
            print("LOGIN COMPLETE !!!! ")
            return true
        }
        
        return false
    }
    
    func login(email: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        loginApi.loginWithEmail(email: email, password: password) { (response, error) in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let response = response {
                TokenManager.shared.setToken(token: response)
                completion(.success(true))
                
                return
            }
            
            completion(.success(false))
        }
    }
    
    func handleSsoLogin(platformType: PlatformType, accessToken: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        
        loginApi.loginWithSso(platformType: platformType, userAgent: UIDevice.current.model, accessToken: accessToken) { (response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let response = response {
                TokenManager.shared.setToken(token: response)
                completion(.success(true))
                
                return
            }
            
            completion(.success(false))
        }
    }
}



