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
            HStack {
                Spacer()
                Text("둘러보기")
                    .padding(.trailing, 16)
                    .padding(.top, 20)
                    .font(.pretendard(weight: .bold, size: 11))
                    .foregroundColor(.neutral600)
                    .onTapGesture {
                        // TODO: Gesture
                    }
            }
            
            Text("Dinning Coach")
                .font(.pretendard(weight: .black, size: 22))
                .padding(.top, 43.5)
                .padding(.bottom, 78.5)
            
            DCLoginView()
            
            SsoLoginView()
            
            Link(destination: URL(string: "https://www.apple.com")!) {
                Text("로그인에 문제가 있으신가요?").loginHelper {
                    
                }
                .underline()
            }
            .padding(.top, 37)
        }
    }
}

// MARK: - login input
struct DCLoginView: View {
    var body: some View {
        Group {
            DCLoginInput()
            
            DCLoginHelper()
        }
    }
}

struct DCLoginInput: View {
    @State var emailInput: String = ""
    @State var passwdInput: String = ""
    
    var body: some View {
        VStack {
            DCTextField(textInput: $emailInput, placeholder: "아이디 (이메일)", supportText: nil)
            
            DCTextField(textInput: $passwdInput, placeholder: "비밀번호", supportText: nil)
            
            DCButton("로그인", style: .primary) {
                
            }
            .padding(.top, 40)
        }
        .padding(.horizontal, 16)
    }
}

struct DCLoginHelper: View {
    var body: some View {
        HStack {
            Text("아이디 찾기").loginHelper {
                // TODO
                print("id 찾기")
            }
            
            Text("비밀번호 찾기").loginHelper {
                // TODO
                print("비밀번호 찾기")
            }
            Spacer()
            
            Text("회원가입").loginHelper {
                // TODO
                print("회원가입")
            }
        }
        .padding(.top, 20)
        .padding(.bottom, 103)
        .padding(.horizontal, 16)
    }
}

// MARK: - sso lgin view
struct SsoLoginView: View {
    var body: some View {
        VStack {
            SsoLoginTitle()
            SsoLoginButtons()
                .padding(.top, 12)
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

// MARK: - extension
extension Text {
    func loginHelper(action: @escaping () -> Void) -> some View {
        self
            .foregroundColor(.neutral400)
            .font(.pretendard(weight: .bold, size: 11))
            .onTapGesture { action() }
    }
}

struct LoginView_Preview: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
