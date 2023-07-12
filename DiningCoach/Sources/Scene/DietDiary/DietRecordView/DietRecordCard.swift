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
                    ForEach(store.records, id: \.self) { record in
                        NavigationLink {
                            DietRecordDetailView(record: record)
                        } label: {
                            RecordCard(record: record)
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
                    Image(systemName: record.mealTime.imageString)
                        .resizable()
                        .frame(width: 18, height: 18)
                        .foregroundColor(.neutral900)
                    
                    Text(record.mealTime.rawValue)
                        .font(.pretendard(weight: .semiBold, size: 16))
                        .foregroundColor(.neutral800)
                }
                
                Rectangle()
                    .frame(width: 160, height: 160)
                    .foregroundColor(.clear)
                    .background(
                        .gray
                    )
                    .cornerRadius(12)
                
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

struct DietDiaryCard_Preview: PreviewProvider {
    static var previews: some View {
        DietRecordCard()
            .environmentObject(DietRecordStore())
    }
}
