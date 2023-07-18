//
//  CameraPermissionView.swift
//  DiningCoach
//
//  Created by SHSEO on 2023/07/17.
//

import SwiftUI

struct CameraPermissionView: View {
    var body: some View {
        ZStack {
            Color.black
                .opacity(0.5)
                .ignoresSafeArea()
            
            VStack {
                Text("‘카메라' 권한 승인이 필요합니다.")
                    .font(.bold, size: 18, lineHeight: 24)
                    .foregroundColor(.neutral900)
                    .padding(.top, 40)
                
                Text("해당 서비스를 이용하기 위해서는\n‘카메라' 권한 승인이 필요합니다.\n설정에서 '카메라' 권한 승인을 허용해주세요.")
                    .font(.semiBold, size: 16, lineHeight: 24)
                    .foregroundColor(.neutral700)
                    .multilineTextAlignment(.center)
                    .padding(.top, 16)
                
                DCButton("설정으로 이동", style: .primary, action: {
                    
                })
                .padding([.top, .horizontal], 16)
                
                
                Text("괜찮아요")
                    .font(.bold, size: 16, lineHeight: 24)
                    .foregroundColor(.primary500)
                    .padding(.top, 8)
                    .padding(.bottom, 24)
                    .background(
                        Color.primary500
                            .frame(height: 2)
                            .offset(y: 5)
                    )
            }
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(.white)
            )
            .overlay(alignment: .topLeading, content: {
                Image("camera")
                    .offset(x: 16, y: -56)
            })
            .padding(.horizontal, 28)
        }
    }
}

struct CameraPermissionView_Previews: PreviewProvider {
    static var previews: some View {
        CameraPermissionView()
    }
}
