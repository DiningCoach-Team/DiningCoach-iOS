//
//  DietRecordStore.swift
//  DiningCoach
//
//  Created by 심현석 on 2023/07/11.
//

import SwiftUI

class DietRecordStore: ObservableObject {
    @Published var isMale: Bool = true
    @Published var selectedDate: Date = Date()
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
            diary: "아침에 시리얼과 우유를 먹었다."
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
        DietRecord(
            mealTime: .dinner,
            food:
                [
                    FoodItem(
                        name: "연어",
                        nutrient: Nutrient(calories: 206, carbohydrate: 0, protein: 22, fat: 13)
                    ),
                    FoodItem(
                        name: "퀴노아",
                        nutrient: Nutrient(calories: 222, carbohydrate: 39, protein: 8.1, fat: 3.6)
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
                        nutrient: Nutrient(calories: 149, carbohydrate: 11.4, protein: 8.5, fat: 7.9)
                    ),
                    FoodItem(
                        name: "블루베리",
                        nutrient: Nutrient(calories: 85, carbohydrate: 21, protein: 1.1, fat: 0.5)
                    )
                ],
            diary: "간식으로 요구르트와 블루베리를 먹었다."
        ),
    ]
    
    func percentageOfDailyRequirement() -> [NutrientType: Double] {
        let totalNutrient =
        records
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
        
        return [
            .calories: percentageOfCalories,
            .carbohydrate: percentageOfCarbohydrate,
            .protein: percentageOfProtein,
            .fat: percentageOfFat
        ]
    }
}
