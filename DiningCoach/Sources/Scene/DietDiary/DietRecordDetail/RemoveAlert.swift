//
//  RemoveAlert.swift
//  DiningCoach
//
//  Created by 심현석 on 2023/07/14.
//

import SwiftUI

struct RemoveAlert: View {
    @EnvironmentObject var store: DietRecordStore
    @Binding var isPresented: Bool
    
    var body: some View {
        ZStack {
            Color.black
                .opacity(0.5)
                .ignoresSafeArea()
            
            VStack(spacing: 16) {
                Text("정말로 삭제하시겠어요?")
                    .font(.pretendard(weight: .bold, size: 18))
                    .foregroundColor(.neutral900)
                                
                Text("삭제된 식단 기록은 휴지통에 30일 동안\n보관되며, 이후에 영구 삭제됩니다.")
                    .font(.pretendard(weight: .semiBold, size: 16))
                    .foregroundColor(.neutral700)
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
                
                HStack(spacing: 8) {
                    RemoveOrCancleButton(isRemove: false)
                        .onTapGesture {
                            isPresented = false
                        }
                    
                    RemoveOrCancleButton(isRemove: true)
                        .onTapGesture {
                            store.deleteDietRecord()
                            isPresented = false
                            store.selectedMealTime = store.selectedMealTime
                        }
                }
                
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 24)
            .frame(width: 319, height: 208)
            .background(.white)
            .cornerRadius(12)
        }
    }
}

struct RemoveOrCancleButton: View {
    var isRemove: Bool
    
    var body: some View {
        HStack {
            Spacer()
            Text(isRemove ? "삭제할게요" : "취소할래요")
                .font(.pretendard(weight: .bold, size: 18))
                .foregroundColor(isRemove ? .white : .primary500)
            Spacer()
        }
        .frame(height: 56)
        .background(isRemove ? Color.primary500 : .white)
        .cornerRadius(12)
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.primary500, lineWidth: 1)
        }
    }
}
