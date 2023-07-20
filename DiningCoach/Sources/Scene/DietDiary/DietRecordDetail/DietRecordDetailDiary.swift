//
//  DietRecordDetailDiary.swift
//  DiningCoach
//
//  Created by 심현석 on 2023/07/14.
//

import SwiftUI

struct DietRecordDetailDiary: View {
    @EnvironmentObject var store: DietRecordStore
    @FocusState var isFocused: Bool
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text("식단 일기")
                        .font(.pretendard(weight: .semiBold, size: 14))
                        .foregroundColor(.neutral700)
                    
                    if store.isEditMode {
                        ZStack(alignment: .leading) {
                            TextEditor(text: $store.diaryText)
                                .font(.pretendard(weight: .medium, size: 12))
                                .accentColor(.primary500)
                                .scrollContentBackground(.hidden)
                                .padding(.top, -8)
                                .padding(.leading, -5)
                                .padding(.bottom, -50)
                                .focused($isFocused)
                            
                            
                            if store.diaryText.isEmpty {
                                VStack {
                                    Text("오늘의 식단 일기를 추가해주세요")
                                        .font(.pretendard(weight: .medium, size: 12))
                                        .foregroundColor(.neutral400)
                                    Spacer()
                                }
                            }
                        }
                    } else {
                        if store.diaryText.isEmpty {
                            Text("오늘의 식단 일기를 추가해주세요")
                                .font(.pretendard(weight: .medium, size: 12))
                                .foregroundColor(.neutral400)
                        } else {
                            Text(store.diaryText)
                                .font(.pretendard(weight: .medium, size: 12))
                        }
                    }
                    Spacer()
                }
                .padding(16)
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .frame(height: 168)
            .background(Color.neutral50)
            .cornerRadius(12)
            .shadow(color: isFocused
                    ? Color(red: 25/255, green: 205/255, blue: 162/255, opacity: 0.2)
                    : .white
                    , radius: 10)
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .onTapGesture {
                isFocused = false
            }
            Spacer()
        }
        .frame(height: 300)
    }
}
