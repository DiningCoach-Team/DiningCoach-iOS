//
//  CookedFood.swift
//  DiningCoach
//
//  Created by SHSEO on 2023/07/11.
//

import Foundation

struct CookedFood: Codable, FoodProtocol {
    var id: Int64?
    var foodImage: String?
    var foodCategory: String?
    var name: String?
    var country: String?
    var brandName: String?
    var reportNo: String?
    var foodKind: String?
    var allergyInfo: String?
    var storage: String?
    var barcode: Int?
    var amountPerServing: Int?
    var nutritionInfo: NutritionInfo?
    
    enum CodingKeys: String, CodingKey {
        case id
        case foodImage = "food_image"
        case foodCategory = "food_category"
        case name
        case foodKind = "food_kind"
        case allergyInfo = "allergy_info"
        case storage
        case amountPerServing = "amount_per_serving"
        case nutritionInfo = "nutrition_info"
    }
}
