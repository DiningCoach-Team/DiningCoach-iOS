//
//  LoginButton.swift
//  DiningCoach
//
//  Created by 이송미 on 2023/06/30.
//

import SwiftUI

struct LoginButton: View {
    let type: PlatformType
    let action: () -> Void
    
    var body: some View {
        ZStack {
            loginButtonImage
                .clipShape(Circle())
                .onTapGesture { action() }
                .frame(width: 56, height: 56)
                .cornerRadius(73.5)
        }
    }
    
    var loginButtonImage: Image {
        switch self.type {
        case .kakao:
            return Image("kakao_login")
        case .google:
            return Image("google_login")
        case .apple:
            return Image("apple_login")        
        }
    }
}

struct LoginButton_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            LoginButton(type: .apple){}
            LoginButton(type: .google){}
            LoginButton(type: .kakao){}
        }
    }
}
