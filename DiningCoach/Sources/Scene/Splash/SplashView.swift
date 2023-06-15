//
//  SplashView.swift
//  DiningCoach
//
//  Created by chamsol kim on 2023/06/09.
//

import SwiftUI
import UserNotifications

struct SplashView: View {
    var body: some View {
        ZStack {
            Color.primary500
            Text("Dining Coach")
                .font(.extraBold, size: 22, lineHeight: 28)
                .foregroundColor(.white)
        }
        .ignoresSafeArea()
        .onAppear(perform: showRequestUserNotificationAlert)
    }
    
    func showRequestUserNotificationAlert() {
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .sound, .badge]) { hasAllowed, error in
                // TODO: 알림 권한을 획득하지 않았을 때 처리 필요
            }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
