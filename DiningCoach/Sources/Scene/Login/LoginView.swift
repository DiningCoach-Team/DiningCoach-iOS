//
//  LoginView.swift
//  DiningCoach
//
//  Created by 이송미 on 2023/06/27.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject private var loginStore: LoginStore
    
    var body: some View {
        VStack {
            SsoLoginView()
        }
    }
}

// MARK: sso lgin view
struct SsoLoginView: View {
    var body: some View {
        VStack {
            SsoLoginTitle()
            SsoLoginButtons()
        }
    }
}

struct SsoLoginTitle: View {
    var body: some View {
        HStack {
            VStack {
                Divider()
                    .foregroundColor(.neutral400)
                    .padding(.leading, 79)
            }
            
            Text("간편 로그인")
                .foregroundColor(.neutral300)
                .font(Font.custom("Pretendard", size: 16))
                .fontWeight(.semibold)
            
            VStack {
                Divider()
                    .foregroundColor(.neutral400)
                    .padding(.trailing, 79)
            }
        }
    }
}

struct SsoLoginButtons: View {
    @EnvironmentObject private var loginStore: LoginStore
    
    var body: some View {
        HStack(spacing: 16) {
            LoginButton(type: .kakao) {
                loginStore.kakaoLogin()
            }
            
            LoginButton(type: .google) {
                loginStore.googleLogin()
            }
            
            LoginButton(type: .apple) {
                loginStore.appleLogin()
            }
        }
    }
}


struct LoginView_Preview: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
