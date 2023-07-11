//
//  Model.swift
//  DiningCoach
//
//  Created by 심현석 on 2023/07/11.
//

import Foundation

enum MealTime: String, CaseIterable, Hashable {
    case breakfast = "아침"
    case lunch = "점심"
    case dinner = "저녁"
    case snack = "간식"
    
    var imageString: String {
        switch self {
        case .breakfast :
            return "sun.min"
        case .lunch:
            return "sun.haze"
        case .dinner:
            return "moon.stars"
        case .snack:
            return "wand.and.stars"
        }
    }
}

struct FoodItem: Hashable {
    var name: String
    //var calories: Double
}

struct DietRecord: Identifiable, Hashable {
    var id: String
    var mealTime: MealTime
    var food: [FoodItem]
    var diary: String
    
    init(mealTime: MealTime, food: [FoodItem], diary: String) {
        self.id = UUID().uuidString
        self.mealTime = mealTime
        self.food = food
        self.diary = diary
    }
}

