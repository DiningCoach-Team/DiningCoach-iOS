//
//  DietRecordStore.swift
//  DiningCoach
//
//  Created by 심현석 on 2023/07/11.
//

import SwiftUI
import Combine

class DietRecordStore: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    
    @Published var isMale: Bool = true
    
    @Published var isWeeklyCalendar: Bool = true
    @Published var selectedDate: Date = Date()
    @Published var selectedDateRecord = [DietRecord]()
    @Published var percentageOfDailyRequirement: [NutrientType: Double] = [:]
    
    @Published var selectedMealTime: MealTime = .breakfast
    @Published var isEditMode: Bool = false
    @Published var foodList = [FoodItem]()
    @Published var diaryText = ""
    
    @Published var records =
    [
        DietRecord(
            mealTime: .breakfast,
            food:
                [
                    FoodItem(
                        name: "시리얼",
                        nutrient: Nutrient(calories: 200, carbohydrate: 40, protein: 10, fat: 5)
                    ),
                    FoodItem(
                        name: "우유",
                        nutrient: Nutrient(calories: 103, carbohydrate: 12, protein: 8, fat: 2.4)
                    )
                ],
            diary: ""
        ),
        DietRecord(
            mealTime: .lunch,
            food:
                [
                    FoodItem(
                        name: "닭가슴살",
                        nutrient: Nutrient(calories: 165, carbohydrate: 0, protein: 31, fat: 3.6)
                    ),
                    FoodItem(
                        name: "감자",
                        nutrient: Nutrient(calories: 130, carbohydrate: 30, protein: 2, fat: 0.2)
                    )
                ],
            diary: "점심에 닭가슴살과 감자를 먹었다."
        ),
//        DietRecord(
//            mealTime: .dinner,
//            food:
//                [
//                    FoodItem(
//                        name: "연어",
//                        nutrient: Nutrient(calories: 206, carbohydrate: 0, protein: 22, fat: 13)
//                    ),
//                    FoodItem(
//                        name: "퀴노아",
//                        nutrient: Nutrient(calories: 222, carbohydrate: 39, protein: 8.1, fat: 3.6)
//                    )
//                ],
//            diary: "저녁에 연어와 퀴노아를 먹었다."
//        ),
        DietRecord(
            mealTime: .snack,
            food:
                [
                    FoodItem(
                        name: "요구르트",
                        nutrient: Nutrient(calories: 149, carbohydrate: 11.4, protein: 8.5, fat: 7.9)
                    ),
                    FoodItem(
                        name: "블루베리",
                        nutrient: Nutrient(calories: 85, carbohydrate: 21, protein: 1.1, fat: 0.5)
                    )
                ],
            diary: "간식으로 요구르트와 블루베리를 먹었다."
        ),
        
        DietRecord(
            mealTime: .breakfast,
            food:
                [
                    FoodItem(
                        name: "시리얼",
                        nutrient: Nutrient(calories: 200, carbohydrate: 40, protein: 10, fat: 5)
                    ),
                    FoodItem(
                        name: "우유",
                        nutrient: Nutrient(calories: 103, carbohydrate: 12, protein: 8, fat: 2.4)
                    )
                ],
            diary: "어제 아침에 시리얼과 우유를 먹었다.",
            date: Date(timeIntervalSinceNow: -3600*24)
        ),
        
        DietRecord(
            mealTime: .snack,
            food:
                [
                    FoodItem(
                        name: "시리얼",
                        nutrient: Nutrient(calories: 200, carbohydrate: 40, protein: 10, fat: 5)
                    ),
                    FoodItem(
                        name: "우유",
                        nutrient: Nutrient(calories: 103, carbohydrate: 12, protein: 8, fat: 2.4)
                    )
                ],
            diary: "어제 간식으로 시리얼과 우유를 먹었다.",
            date: Date(timeIntervalSinceNow: -3600*24)
        ),
    ]
    
    init() {
        selectedDate = {
            let components = Calendar.current.dateComponents([.year, .month, .day], from: Date())
            let startOfDay = Calendar.current.date(from: components)!
            return startOfDay
        }()
        
        $selectedDate
            .sink { [weak self] newDate in
                if let self = self {
                    self.selectedDateRecord = self.records.filter { $0.date.isSameDay(with: newDate) }
                    self.getPercentageOfDailyRequirement()
                }
            }
            .store(in: &cancellables)
        
        $selectedMealTime
            .sink { [weak self] newMealTime in
                if let self = self,
                   let record = self.records.first(where: { $0.date.isSameDay(with: self.selectedDate) && $0.mealTime == newMealTime }) {
                    self.foodList = record.food
                    self.diaryText = record.diary
                } else {
                    self?.foodList = []
                    self?.diaryText = ""
                }
            }
            .store(in: &cancellables)
        
        $records
            .sink { [weak self] newRecords in
                if let self = self {
                    self.selectedDateRecord = newRecords.filter { $0.date.isSameDay(with: self.selectedDate) }
                    self.getPercentageOfDailyRequirement()
                }
            }
            .store(in: &cancellables)
    }
    
    func updateDietRecord(newRecord: DietRecord) {
        if let index = records.firstIndex(where: { $0.date.isSameDay(with: selectedDate) && $0.mealTime == selectedMealTime }) {
            records[index] = newRecord
        } else {
            records.append(newRecord)
        }
    }
    
    func deleteDietRecord() {
        if let index = records.firstIndex(where: { $0.date.isSameDay(with: selectedDate) && $0.mealTime == selectedMealTime }) {
            records.remove(at: index)
        }
    }
    
    func dayOfMonthRecord(day: Int) -> [DietRecord] {
        let components = Calendar.current.dateComponents([.year, .month], from: Date())
        let firstDayOfMonth = Calendar.current.date(from: components)!
        let date = Calendar.current.date(byAdding: .day, value: day - 1, to: firstDayOfMonth)!
        let records = self.records.filter { $0.date.isSameDay(with: date) }
        return records
    }
    
    func getPercentageOfDailyRequirement() {
        let totalNutrient =
        selectedDateRecord
            .flatMap { $0.food.map { $0.nutrient } }
            .reduce(Nutrient(calories: 0, carbohydrate: 0, protein: 0, fat: 0)) { (total, nutrient) in
                return Nutrient(
                    calories: total.calories + nutrient.calories,
                    carbohydrate: total.carbohydrate + nutrient.carbohydrate,
                    protein: total.protein + nutrient.protein,
                    fat: total.fat + nutrient.fat
                )
            }
        
        let maleDailyRequirement = Nutrient(calories: 2500, carbohydrate: 324, protein: 55, fat: 54)
        let femaleDailyRequirement = Nutrient(calories: 2000, carbohydrate: 324, protein: 55, fat: 54)
        let dailyRequirement = self.isMale ? maleDailyRequirement : femaleDailyRequirement
        
        let percentageOfCalories = totalNutrient.calories / dailyRequirement.calories
        let percentageOfCarbohydrate = totalNutrient.carbohydrate / dailyRequirement.carbohydrate
        let percentageOfProtein = totalNutrient.protein / dailyRequirement.protein
        let percentageOfFat = totalNutrient.fat / dailyRequirement.fat
        
        return self.percentageOfDailyRequirement = [
            .calories: percentageOfCalories,
            .carbohydrate: percentageOfCarbohydrate,
            .protein: percentageOfProtein,
            .fat: percentageOfFat
        ]
    }
}

// MARK: - Date extension

extension Date {
    func toNavigationTitleString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "M월 d일 (E)"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: self)
    }
    
    func isSameDay(with date: Date) -> Bool {
        let dateComponents1 = Calendar.current.dateComponents([.year, .month, .day], from: self)
        let dateComponents2 = Calendar.current.dateComponents([.year, .month, .day], from: date)
        return dateComponents1 == dateComponents2
    }
}
