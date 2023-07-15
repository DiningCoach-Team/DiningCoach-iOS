//
//  Model.swift
//  DiningCoach
//
//  Created by 심현석 on 2023/07/11.
//

import SwiftUI

enum MealTime: String, CaseIterable, Hashable {
    case breakfast = "아침"
    case lunch = "점심"
    case dinner = "저녁"
    case snack = "간식"
    
    var imageString: String {
        switch self {
        case .breakfast :
            return "Sun"
        case .lunch:
            return "Sunrise"
        case .dinner:
            return "Moon"
        case .snack:
            return "Star"
        }
    }
}

enum NutrientType: String, CaseIterable, Hashable {
    case calorie = "열량"
    case carbohydrate = "탄수화물"
    case protein = "단백질"
    case fat = "지방"
    case sugar = "당류"
    case cholesterol = "콜레스테롤"
    case sodium = "나트륨"
    case saturatedFat = "포화지방산"
    case transFat = "트랜스지방"
    
    var graphColor: Color {
        switch self {
        case .calorie:
            return Color(red: 202/255, green: 253/255, blue: 229/255)
        case .carbohydrate:
            return Color(red: 206/255, green: 237/255, blue: 255/255)
        case .protein:
            return Color(red: 255/255, green: 236/255, blue: 219/255)
        case .fat:
            return Color(red: 255/255, green: 247/255, blue: 208/255)
        case .sugar:
            return Color(red: 245/255, green: 223/255, blue: 255/255)
        case .cholesterol:
            return Color(red: 255/255, green: 212/255, blue: 235/255)
        case .sodium:
            return Color(red: 255/255, green: 206/255, blue: 206/255)
        case .saturatedFat:
            return Color(red: 237/255, green: 255/255, blue: 215/255)
        case .transFat:
            return Color(red: 214/255, green: 253/255, blue: 255/255)
        }
    }
    
    var unit: String {
        switch self {
        case .calorie:
            return "kcal"
        case .carbohydrate, .sugar:
            return "g"
        case .protein:
            return "g"
        case .fat, .saturatedFat, .transFat:
            return "g"
        case .cholesterol:
            return "mg"
        case .sodium:
            return "mg"
        }
    }
    
    var dailyStandard: Double {
        switch self {
        case .calorie:
            return 2000
        case .carbohydrate:
            return 324
        case .protein:
            return 55
        case .fat:
            return 54
        case .sugar:
            return 100
        case .cholesterol:
            return 300
        case .sodium:
            return 2000
        case .saturatedFat:
            return 15
        case .transFat:
            return 1
        }
    }
}
    
struct Nutrient: Hashable {
    var calorie: Double = 0
    var carbohydrate: Double = 0
    var protein: Double = 0
    var fat: Double = 0
    var sugar: Double = 0
    var cholesterol: Double = 0
    var sodium: Double = 0
    var saturatedFat: Double = 0
    var transFat: Double = 0
}

struct FoodItem: Hashable {
    var name: String
    var nutrient: Nutrient
}

struct DietRecord: Identifiable, Hashable {
    var id: String
    var mealTime: MealTime
    var food: [FoodItem]
    var diary: String
    var date: Date
    
    init(mealTime: MealTime, food: [FoodItem], diary: String, date: Date = Date()) {
        self.id = UUID().uuidString
        self.mealTime = mealTime
        self.food = food
        self.diary = diary
        self.date = date
    }
}

enum Statistics: String, CaseIterable, Hashable {
    case daily = "일별"
    case weekly = "주별"
    case monthly = "월별"
}
