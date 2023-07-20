//
//  SigninCompleteView.swift
//  DiningCoach
//
//  Created by 심현석 on 2023/06/30.
//

import SwiftUI

struct SigninCompleteView: View {
    @EnvironmentObject var navigation: SigninNavigation
    
    var nickname: String
    
    var body: some View {
        VStack {
            VStack {
                Spacer()
                HStack {
                    Text("\(nickname)님,\n가입이 완료되었어요!")
                        .font(.pretendard(weight: .bold, size: 22))
                        .lineSpacing(6)
                    Spacer()
                }
            }
            .frame(height: 80)
            
            Spacer()
                .frame(height: 40)
            
            VStack {
                HStack {
                    VStack(alignment:. leading, spacing: 16) {
                        Text("다이닝코치는 식단관리 서비스로써\n식단일기 기록, 식단 추천 등 여러 기능들을\n제공하고 있어요.")
                        
                        Text("맞춤형 정보를 제공하기 위해서는\n\(nickname)님에 대한 추가정보가 필요해요!\n추가정보는 7단계로 구성되어 있으며, 식단 구성에\n필요한 간단한 정보에 대해 여쭤보려고 해요.")
                        
                        Text("입력하신 정보는 다른 목적으로 사용되거나 제3자에게 제공되지 않습니다.")
                    }
                    .font(.pretendard(weight: .medium, size: 16))
                    .lineSpacing(8)
                    Spacer()
                }
            }
            
            Spacer()
            
            VStack(spacing: 8) {
                DCButton("추가정보 입력하기", style: .primary) {
                    // 다음페이지
                }
                
                DCButton("건너뛰기", style: .secondary) {
                    navigation.showSheet = false
                }
            }
            .padding(.vertical, 16)
        }
        .padding(.horizontal, 16)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    navigation.showSheet = false
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(.black)
                }
            }
        }
    }
}

struct SigninCompleteView_Previews: PreviewProvider {
    static var previews: some View {
        SigninCompleteView(nickname: "민수민수")
    }
}
