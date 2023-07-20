//
//  SplashView.swift
//  DiningCoach
//
//  Created by chamsol kim on 2023/06/09.
//

import SwiftUI
import UserNotifications

struct SplashView: View {
    @State var isLoading: Bool = true
    var body: some View {
        ZStack {
            if isLoading {
                Color.primary500
                Text("Dining Coach")
                    .font(.extraBold, size: 22, lineHeight: 28)
                    .foregroundColor(.white)
            } else {   
                LoginView().zIndex(1)
            }
        }
        .ignoresSafeArea()
        .onAppear(perform: showRequestUserNotificationAlert)
    }
    
    func showRequestUserNotificationAlert() {
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .sound, .badge]) { hasAllowed, error in
                // TODO: 알림 권한을 획득하지 않았을 때 처리 필요
            }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: { isLoading.toggle() })
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
