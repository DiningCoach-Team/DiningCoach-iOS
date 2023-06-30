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

public enum PlatformType: String {
    case kakao, google, apple
}

// MARK: Login Store Protocol
protocol BaseLoginStore {
    func login(completion: @escaping (Bool) -> Void)
    func loginWithSocial(platformType: PlatformType, completion: @escaping (Bool) -> Void)
}

class LoginStore: NSObject, ObservableObject, ASAuthorizationControllerDelegate {
    @Published var isNextViewPresented = false
    @Published var oauthToken: OAuthToken?
    @Published var user: User?
    
    // MARK: kakao login
    func kakaoLogin() {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk { (oauthToken, error) in
                if let error = error {
                    print("카카오 로그인 실패: \(error.localizedDescription)")
                    return
                }
                
                self.kakaoUserInfo()
            }
        } else {
            UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
                if let error = error {
                    print("카카오 로그인 실패: \(error.localizedDescription)")
                    return
                }
                
                self.kakaoUserInfo()
            }
        }
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
    
    // MARK: apple login
    func appleLogin() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.email]

        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.performRequests()
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let _ = authorization.credential as? ASAuthorizationAppleIDCredential {
            isNextViewPresented = true
        }
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Authorization failed: \(error.localizedDescription)")
    }
}

// MARK: google login
extension LoginStore {
    func googleLogin() {
        guard let rootViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else { return }
        
        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { (signInResult, error) in
            if let error = error {
                print("구글 로그인 실패 : \(error)")
                return
            }
            
            guard let result = signInResult else {
                print("구글 로그인 실패 : signInResult 결과가 없음")
                return
            }
            
            
        }
    }
}



