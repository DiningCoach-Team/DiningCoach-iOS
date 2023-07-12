//
//  DietStatistics.swift
//  DiningCoach
//
//  Created by 심현석 on 2023/07/11.
//

import SwiftUI

struct DietStatistics: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("식단 통계")
                .font(.pretendard(weight: .semiBold, size: 16))
                .foregroundColor(.neutral900)
            
            DietStatisticsContainer()
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 16)
        .frame(height: 220)
    }
}

struct DietStatisticsContainer: View {
    @EnvironmentObject var store: DietRecordStore
    @State private var percentage: [NutrientType: Double] = [:]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("영양 성분")
                .font(.pretendard(weight: .semiBold, size: 14))
                .foregroundColor(.neutral900)
            
            VStack(spacing: 8) {
                DietStatisticsGraph(type: .calories, percentage: percentage[.calories] ?? 0)
                DietStatisticsGraph(type: .carbohydrate, percentage: percentage[.carbohydrate] ?? 0)
                DietStatisticsGraph(type: .protein, percentage: percentage[.protein] ?? 0)
                DietStatisticsGraph(type: .fat, percentage: percentage[.fat] ?? 0)
            }
        }
        .padding(.vertical, 16)
        .padding(.leading, 16)
        .frame(height: 152)
        .background(.white)
        .cornerRadius(12)
        .shadow(color: Color(white: 0, opacity: 0.10), radius: 10)
        .onAppear {
            percentage = store.percentageOfDailyRequirement()
        }
    }
}

struct DietStatisticsGraph: View {
    var type: NutrientType
    var percentage: Double
    
    var body: some View {
        HStack(spacing: 8) {
            Text(type.rawValue)
                .font(.pretendard(weight: .medium, size: 12))
                .foregroundColor(.neutral700)
                .frame(width: 42, alignment: .leading)
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .foregroundColor(.neutral100)
                        .cornerRadius(12)
                    
                    Rectangle()
                        .foregroundColor(type.graphColor)
                        .cornerRadius(12)
                        .frame(width: geometry.size.width * min(self.percentage, 1))
                }
            }
            .frame(height: 8)
            
            Text("\(Int(percentage*100))%")
                .font(.pretendard(weight: .medium, size: 12))
                .foregroundColor(.neutral700)
                .frame(width: 32, alignment: .trailing)
            
            Spacer()
        }
    }
}

struct DietStatistics_Preview: PreviewProvider {
    static var previews: some View {
        DietStatistics()
            .environmentObject(DietRecordStore())
    }
}
