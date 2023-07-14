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
    case calories = "열량"
    case carbohydrate = "탄수화물"
    case protein = "단백질"
    case fat = "지방"

    var graphColor: Color {
        switch self {
        case .calories:
            return Color(red: 202/255, green: 253/255, blue: 229/255)
        case .carbohydrate:
            return Color(red: 206/255, green: 237/255, blue: 255/255)
        case .protein:
            return Color(red: 255/255, green: 236/255, blue: 219/255)
        case .fat:
            return Color(red: 255/255, green: 247/255, blue: 208/255)
        }
    }
}

struct Nutrient: Hashable {
    var calories: Double
    var carbohydrate: Double
    var protein: Double
    var fat: Double
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
