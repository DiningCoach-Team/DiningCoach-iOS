//
//  DiningCoachApp.swift
//  DiningCoach
//
//  Created by 백정수 on 2023/05/08.
//

import SwiftUI

@main
struct DiningCoachApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var loginStore = LoginStore()
    @StateObject private var registrationStore = RegistrationStore()
    
    var body: some Scene {
        WindowGroup {
            SplashView()
                .environmentObject(loginStore)
                .environmentObject(registrationStore)
        }
    }
}
