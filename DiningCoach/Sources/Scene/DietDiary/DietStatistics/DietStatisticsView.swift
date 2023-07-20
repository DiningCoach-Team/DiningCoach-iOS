//
//  DietStatisticsView.swift
//  DiningCoach
//
//  Created by 심현석 on 2023/07/14.
//

import SwiftUI

struct DietStatisticsView: View {
    var body: some View {
        VStack(spacing: 0) {
            DietStatisticsNavigation()
            StatisticsTabBar()
            ScrollView(showsIndicators: false) {
                VStack {
                    StatisticsDetail()
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
            }
            Spacer()
        }
        .navigationBarBackButtonHidden()
    }
}

struct DietStatisticsNavigation: View {
    @EnvironmentObject var store: DietRecordStore
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.primary500
                .ignoresSafeArea()
            
            HStack {
                Group {
                    Image(systemName: "chevron.backward")
                        .resizable()
                        .frame(width: 8, height: 16)
                        .foregroundColor(.white)
                        .onTapGesture {
                            dismiss()
                            store.isEditMode = false
                            store.selectedStatistics = .daily
                            store.selectedDate = store.selectedDate
                        }
                }
                .frame(width: 24, height: 24)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                
                Spacer()
            }
            
            Text(store.selectedDate.toNaviTitleWithYear())
                .font(.pretendard(weight: .bold, size: 18))
                .foregroundColor(.white)
        }
        .frame(height: 48)
    }
}

struct StatisticsTabBar: View {
    var body: some View {
        HStack {
            StatisticsTabBarCell(type: .daily)
            StatisticsTabBarCell(type: .weekly)
            StatisticsTabBarCell(type: .monthly)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
    }
}

struct StatisticsTabBarCell: View {
    @EnvironmentObject var store: DietRecordStore
    var type: Statistics
    
    var body: some View {
        ZStack {
            Text(type.rawValue)
                .font(.pretendard(weight: .bold, size: 14))
                .foregroundColor(store.selectedStatistics == type ? .primary500 : .neutral400)
                .onTapGesture {
                    store.selectedStatistics = type
                }
            
            if store.selectedStatistics == type {
                VStack {
                    Spacer()
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.primary500)
                }
            }
        }
        .frame(height: 36)
        .frame(maxWidth: .infinity)
    }
}

struct StatisticsDetail: View {
    @EnvironmentObject var store: DietRecordStore
    
    var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 5) {
                Text("이형구님이")
                    .foregroundColor(.neutral900)
                Text("오늘")
                    .foregroundColor(.primary500)
                Text("섭취한 영양소에요!")
                    .foregroundColor(.neutral900)
                Spacer()
            }
            .font(.pretendard(weight: .semiBold, size: 18))
            
            VStack {
                ForEach(Statistics.allCases.indices, id: \.self) { index in
                    if store.selectedStatistics == Statistics.allCases[index] {
                        StatisticsDetailGraph(type: .calorie, value: store.totalNutrientValues[index].calorie)
                        StatisticsDetailGraph(type: .carbohydrate, value: store.totalNutrientValues[index].carbohydrate)
                        StatisticsDetailGraph(type: .protein, value: store.totalNutrientValues[0].protein)
                        StatisticsDetailGraph(type: .fat, value: store.totalNutrientValues[index].fat)
                        StatisticsDetailGraph(type: .sugar, value: store.totalNutrientValues[index].sugar)
                        StatisticsDetailGraph(type: .cholesterol, value: store.totalNutrientValues[index].cholesterol)
                        StatisticsDetailGraph(type: .sodium, value: store.totalNutrientValues[index].sodium)
                        StatisticsDetailGraph(type: .saturatedFat, value: store.totalNutrientValues[index].saturatedFat)
                        StatisticsDetailGraph(type: .transFat, value: store.totalNutrientValues[index].transFat)
                    }
                }
            }
        }
    }
}

struct StatisticsDetailGraph: View {
    var type: NutrientType
    var value: Double
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .foregroundColor(.neutral100)
                        .cornerRadius(12)
                    
                    Rectangle()
                        .foregroundColor(type.graphColor)
                        .cornerRadius(12)
                        .frame(width: geometry.size.width * min(value/type.dailyStandard, 1))
                }
            }
            
            HStack(spacing: 8) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(type.rawValue)
                        .font(.pretendard(weight: .semiBold, size: 14))
                        .foregroundColor(.neutral800)
                    
                    Text("\(doubleValueFormat(value)) \(type.unit)")
                        .font(.pretendard(weight: .bold, size: 22))
                        .foregroundColor(value/type.dailyStandard >= 1 ? .red :.neutral900)
                }
                Spacer()
                
                if type != .transFat {
                    VStack {
                        Spacer()
                        Text("\(Int((value/type.dailyStandard) * 100))%")
                            .font(.pretendard(weight: .bold, size: 18))
                            .foregroundColor(value/type.dailyStandard >= 1 ? .red :.neutral900)
                    }
                }
            }
            .padding(16)
        }
        .frame(height: 80)
    }
    
    func doubleValueFormat(_ value: Double) -> String {
        if value == floor(value) {
            return String(format: "%.0f", value)
        } else {
            return String(format: "%.2f", value)
        }
    }
}

struct DietStatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        DietStatisticsView()
            .environmentObject(DietRecordStore())
    }
}
