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

class LoginStore: NSObject, ObservableObject, ASAuthorizationControllerDelegate {
    @Published var isNextViewPresented = false
    @Published var oauthToken: OAuthToken?
    @Published var user: User?
    
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



