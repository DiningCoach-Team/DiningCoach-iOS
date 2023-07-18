//
//  NutritionInfo.swift
//  DiningCoach
//
//  Created by SHSEO on 2023/07/13.
//

import Foundation

// MARK: - NutritionInfo
struct NutritionInfo: Codable {
    var id: Int64?
    var calorie: Float?
    var carbohydrate: Float?
    var sugar: Float?
    var protein: Float?
    var fat: Float?
    var cholesterol: Float?
    var sodium: Float?
    var saturatedFat: Float?
    var transFat: Float?
    
    enum CodingKeys: String, CodingKey {
        case id, calorie, carbohydrate, sugar, protein, fat, cholesterol, sodium
        case saturatedFat = "saturated_fat"
        case transFat = "trans_fat"
    }
}
