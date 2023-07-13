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
    @StateObject private var dietRecordStore = DietRecordStore()
    
    var body: some Scene {
        WindowGroup {
            //SplashView()
            DietRecordView()
                .environmentObject(loginStore)
                .environmentObject(registrationStore)
                .environmentObject(dietRecordStore)
        }
    }
}
