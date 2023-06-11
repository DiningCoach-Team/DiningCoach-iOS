//
//  SplashView.swift
//  DiningCoach
//
//  Created by chamsol kim on 2023/06/09.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            Color.primary500
            Text("Dining Coach")
                .font(.extraBold, size: 22, lineHeight: 28)
                .foregroundColor(.white)
        }
        .ignoresSafeArea()
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
