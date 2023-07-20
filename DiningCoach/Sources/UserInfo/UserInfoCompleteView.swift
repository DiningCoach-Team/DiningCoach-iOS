//
//  UserInfoCompleteView.swift
//  DiningCoach
//
//  Created by 심현석 on 2023/06/25.
//

import SwiftUI

struct UserInfoCompleteView: View {
    @Environment(\.dismiss) var dismiss
    @State private var isCompleted: Bool = false
    
    var body: some View {
        VStack {
            VStack {
                Text("추가정보 입력이 모두 끝났어요!")
                    .font(.bold, size: 22, lineHeight: 28)
                    .frame(height: 28)
            }
            .padding(.top, 34)
            .padding(.bottom, 18)
            
            Spacer()
                .frame(height: 32)
            
            VStack {
                Image("result_Hands")
                    .resizable()
                    .frame(width: 156, height: 193)
            }
            .padding(16)
            
            Spacer()
                .frame(height: 32)
            
            VStack {
                Text("여기까지 오시느라 수고 많으셨습니다!")
                    .font(.medium, size: 16, lineHeight: 24)
                    .frame(height: 24)
                
                Spacer()
                    .frame(height: 16)
                
                Text("이제 모든 준비가 완료되었으니 다이닝코치로\n더욱 편리한 식단관리를 시작해보세요!")
                    .font(.medium, size: 16, lineHeight: 24)
                    .multilineTextAlignment(.center)
            }
            
            Spacer()
            
            VStack {
                DCButton("다이닝코치 시작하기", style: .primary) {
                    isCompleted = true
                }
            }
            .padding(.vertical, 16)
        }
        .padding(.horizontal, 16)
        .navigationDestination(isPresented: $isCompleted) {
            
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.backward")
                        .tint(.black)
                }
            }
        }
    }
}

struct UserInfoCompleteView_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoCompleteView()
    }
}


