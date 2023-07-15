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
    
    @Published var selectedStatistics: Statistics = .daily
    @Published var totalNutrientValues = [Nutrient]()
    
    @Published var records =
    [
        DietRecord(
            mealTime: .breakfast,
            food:
                [
                    FoodItem(
                        name: "시리얼",
                        nutrient: Nutrient(calorie: 200, carbohydrate: 40, protein: 10, fat: 5, sugar: 10, cholesterol: 0, sodium: 300, saturatedFat: 1.5, transFat: 1)
                    ),
                    FoodItem(
                        name: "우유",
                        nutrient: Nutrient(calorie: 103, carbohydrate: 12, protein: 8, fat: 2.4, sugar: 12, cholesterol: 10, sodium: 100, saturatedFat: 1.5, transFat: 1)
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
                        nutrient: Nutrient(calorie: 165, carbohydrate: 0, protein: 31, fat: 3.6, sugar: 0, cholesterol: 85, sodium: 70, saturatedFat: 1, transFat: 0)
                    ),
                    FoodItem(
                        name: "감자",
                        nutrient: Nutrient(calorie: 130, carbohydrate: 30, protein: 2, fat: 0.2, sugar: 1.2, cholesterol: 0, sodium: 10, saturatedFat: 0, transFat: 0)
                    )
                ],
            diary: "점심에 닭가슴살과 감자를 먹었다."
        ),
        DietRecord(
            mealTime: .dinner,
            food:
                [
                    FoodItem(
                        name: "연어",
                        nutrient: Nutrient(calorie: 206, carbohydrate: 0, protein: 22, fat: 13, sugar: 0, cholesterol: 50, sodium: 50, saturatedFat: 3, transFat: 0)
                    ),
                    FoodItem(
                        name: "퀴노아",
                        nutrient: Nutrient(calorie: 222, carbohydrate: 39, protein: 8.1, fat: 3.6, sugar: 1.6, cholesterol: 0, sodium: 13, saturatedFat: 0.42, transFat: 0)
                    )
                ],
            diary: "저녁에 연어와 퀴노아를 먹었다."
        ),
        DietRecord(
            mealTime: .snack,
            food:
                [
                    FoodItem(
                        name: "요구르트",
                        nutrient: Nutrient(calorie: 149, carbohydrate: 11.4, protein: 8.5, fat: 7.9, sugar: 11.4, cholesterol: 20, sodium: 100, saturatedFat: 5, transFat: 0)
                    ),
                    FoodItem(
                        name: "블루베리",
                        nutrient: Nutrient(calorie: 85, carbohydrate: 21, protein: 1.1, fat: 0.5, sugar: 15, cholesterol: 0, sodium: 1, saturatedFat: 0.01, transFat: 0)
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
                        nutrient: Nutrient(calorie: 200, carbohydrate: 40, protein: 10, fat: 5, sugar: 10, cholesterol: 0, sodium: 300, saturatedFat: 1.5, transFat: 0)
                    ),
                    FoodItem(
                        name: "우유",
                        nutrient: Nutrient(calorie: 103, carbohydrate: 12, protein: 8, fat: 2.4, sugar: 12, cholesterol: 10, sodium: 100, saturatedFat: 1.5, transFat: 0)
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
                        nutrient: Nutrient(calorie: 200, carbohydrate: 40, protein: 10, fat: 5, sugar: 10, cholesterol: 0, sodium: 300, saturatedFat: 1.5, transFat: 0)
                    ),
                    FoodItem(
                        name: "우유",
                        nutrient: Nutrient(calorie: 103, carbohydrate: 12, protein: 8, fat: 2.4, sugar: 12, cholesterol: 10, sodium: 100, saturatedFat: 1.5, transFat: 0)
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
                    self.getTotalNutrientValues(date: newDate)
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
    
    func getWeekDates(date: Date) -> (startOfWeek: Date, endOfWeek: Date) {
        let components = Calendar.current.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date)
        
        let startOfWeek = Calendar.current.date(from: components)!
        let endOfWeek = Calendar.current.date(byAdding: .day, value: 6, to: startOfWeek)!
        
        return (startOfWeek, endOfWeek)
    }
    
    func getMonthDates(date: Date) -> (startOfMonth: Date, endOfMonth: Date) {
        let components = Calendar.current.dateComponents([.year, .month], from: date)
        let startOfMonth = Calendar.current.date(from: components)!

        var endDayComponents = DateComponents()
        endDayComponents.month = 1
        endDayComponents.day = -1
        let endOfMonth = Calendar.current.date(byAdding: endDayComponents, to: startOfMonth)!

        return (startOfMonth, endOfMonth)
    }
    
    func dayOfMonthRecord(day: Int) -> [DietRecord] {
        let components = Calendar.current.dateComponents([.year, .month], from: Date())
        let startOfMonth = Calendar.current.date(from: components)!
        
        let date = Calendar.current.date(byAdding: .day, value: day - 1, to: startOfMonth)!
        let records = self.records.filter { $0.date.isSameDay(with: date) }
        return records
    }
    
    func getTotalNutrientValues(date: Date) {
        let dailyNutrients = records
            .filter { $0.date.isSameDay(with: date) }
            .flatMap { $0.food.map { $0.nutrient } }
        
        let dilayTotalNutrient = dailyNutrients
            .reduce(Nutrient()) { result, nutrient in
                return Nutrient(
                    calorie: result.calorie + nutrient.calorie,
                    carbohydrate: result.carbohydrate + nutrient.carbohydrate,
                    protein: result.protein + nutrient.protein,
                    fat: result.fat + nutrient.fat,
                    sugar: result.sugar + nutrient.sugar,
                    cholesterol: result.cholesterol + nutrient.cholesterol,
                    sodium: result.sodium + nutrient.sodium,
                    saturatedFat: result.saturatedFat + nutrient.saturatedFat,
                    transFat: result.transFat + nutrient.transFat
                )
            }
        
        let startOfWeekDate = getWeekDates(date: date).startOfWeek
        let endOfWeekDate = getWeekDates(date: date).endOfWeek
        let weeklyNutrients = records
            .filter { $0.date >= startOfWeekDate && $0.date <= endOfWeekDate }
            .flatMap { $0.food.map { $0.nutrient } }
        print("weeklyNutrients: \(weeklyNutrients)")
        
        let weeklyTotalNutrient = weeklyNutrients
            .reduce(Nutrient()) { result, nutrient in
                return Nutrient(
                    calorie: result.calorie + nutrient.calorie,
                    carbohydrate: result.carbohydrate + nutrient.carbohydrate,
                    protein: result.protein + nutrient.protein,
                    fat: result.fat + nutrient.fat,
                    sugar: result.sugar + nutrient.sugar,
                    cholesterol: result.cholesterol + nutrient.cholesterol,
                    sodium: result.sodium + nutrient.sodium,
                    saturatedFat: result.saturatedFat + nutrient.saturatedFat,
                    transFat: result.transFat + nutrient.transFat
                )
            }
        
        let startOfMonthDate = getMonthDates(date: date).startOfMonth
        let endOfMonthDate = getMonthDates(date: date).endOfMonth
        let monthlyNutrients = records
            .filter { $0.date >= startOfMonthDate && $0.date <= endOfMonthDate }
            .flatMap { $0.food.map { $0.nutrient } }
        
        let monthlyTotalNutrient = monthlyNutrients
            .reduce(Nutrient()) { result, nutrient in
                return Nutrient(
                    calorie: result.calorie + nutrient.calorie,
                    carbohydrate: result.carbohydrate + nutrient.carbohydrate,
                    protein: result.protein + nutrient.protein,
                    fat: result.fat + nutrient.fat,
                    sugar: result.sugar + nutrient.sugar,
                    cholesterol: result.cholesterol + nutrient.cholesterol,
                    sodium: result.sodium + nutrient.sodium,
                    saturatedFat: result.saturatedFat + nutrient.saturatedFat,
                    transFat: result.transFat + nutrient.transFat
                )
            }
        
        if self.totalNutrientValues.isEmpty {
            self.totalNutrientValues.append(dilayTotalNutrient)
            self.totalNutrientValues.append(weeklyTotalNutrient)
            self.totalNutrientValues.append(monthlyTotalNutrient)
        } else {
            self.totalNutrientValues[0] = dilayTotalNutrient
            self.totalNutrientValues[1] = weeklyTotalNutrient
            self.totalNutrientValues[2] = monthlyTotalNutrient
        }
    }
}

// MARK: - Date extension

extension Date {
    func isSameDay(with date: Date) -> Bool {
        let dateComponents1 = Calendar.current.dateComponents([.year, .month, .day], from: self)
        let dateComponents2 = Calendar.current.dateComponents([.year, .month, .day], from: date)
        return dateComponents1 == dateComponents2
    }
    
    func toNaviTitleWithWeekday() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "M월 d일 (E)"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: self)
    }
    
    func toNaviTitleWithYear() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 M월 d일"
        return formatter.string(from: self)
    }
}
