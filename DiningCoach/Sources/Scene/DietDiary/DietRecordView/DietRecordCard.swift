//
//  DietRecordCard.swift
//  DiningCoach
//
//  Created by 심현석 on 2023/07/11.
//

import SwiftUI

struct DietRecordCard: View {
    @EnvironmentObject var store: DietRecordStore
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("식단 기록")
                .font(.pretendard(weight: .semiBold, size: 16))
                .foregroundColor(.neutral900)
                .padding(.horizontal, 16)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(MealTime.allCases, id: \.self) { mealTime in
                        NavigationLink {
                            DietRecordDetailView()
                                .onAppear {
                                    store.selectedMealTime = mealTime
                                }
                        } label: {
                            if let record = store.selectedDateRecord.first(where: { $0.mealTime == mealTime }) {
                                RecordCard(record: record)
                            } else {
                                EmptyCard(type: mealTime)
                            }
                        }
                    }
                }
                .padding(.vertical, 16)
                .padding(.horizontal, 16)
            }
        }
        .padding(.top, 8)
    }
}

struct RecordCard: View {
    var record: DietRecord
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 16) {
                HStack(spacing: 4) {
                    Image(record.mealTime.imageString)
                        .resizable()
                        .frame(width: 18, height: 18)
                        .foregroundColor(.neutral900)
                    
                    Text(record.mealTime.rawValue)
                        .font(.pretendard(weight: .semiBold, size: 16))
                        .foregroundColor(.neutral800)
                }
                
                Image("음식 사진 등록")
                    .resizable()
                    .frame(width: 160, height: 160)
                
                HStack {
                    let totalCount = record.food.count
                    let displayCount = min(totalCount, 4)
                    let extraCount = totalCount - displayCount
                    
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(record.food.prefix(displayCount), id: \.self) { food in
                            Text(food.name)
                        }
                    }
                    .font(.pretendard(weight: .medium, size: 12))
                    .foregroundColor(.neutral800)
                    .frame(height: 88, alignment: .top)
                    
                    Spacer()
                    
                    if extraCount > 0 {
                        VStack {
                            Spacer()
                            Text("+\(extraCount)")
                                .font(.pretendard(weight: .medium, size: 12))
                                .foregroundColor(.neutral500)
                                .padding(5)
                        }
                    }
                }
                .frame(height: 88)
            }
            .padding(16)
        }
        .frame(width: 192, height: 332)
        .background(.white)
        .cornerRadius(12)
        .shadow(color: Color(white: 0, opacity: 0.1), radius: 10)
    }
}

struct EmptyCard: View {
    var type: MealTime
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                HStack(spacing: 4) {
                    Image(type.imageString)
                        .resizable()
                        .frame(width: 18, height: 18)
                        .foregroundColor(.neutral900)
                    
                    Text(type.rawValue)
                        .font(.pretendard(weight: .semiBold, size: 16))
                        .foregroundColor(.neutral800)
                }
                
                Spacer()
                    .frame(height: 32)
                
                Image("밥 수정 1")
                    .resizable()
                    .frame(width: 128, height: 128)
                
                Spacer()
                    .frame(height: 24)
                
                Text("무엇을 드셨나요?\n음식을 등록하고 식단을\n관리해 보세요!")
                    .font(.pretendard(weight: .semiBold, size: 14))
                    .foregroundColor(.neutral400)
                    .lineSpacing(10)
                
                Spacer()
            }
            .padding(16)
        }
        .frame(width: 192, height: 332)
        .background(.white)
        .cornerRadius(12)
        .shadow(color: Color(white: 0, opacity: 0.1), radius: 10)
    }
}

struct DietDiaryCard_Preview: PreviewProvider {
    static var previews: some View {
        DietRecordCard()
            .environmentObject(DietRecordStore())
    }
}
