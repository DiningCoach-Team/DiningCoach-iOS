//
//  ProcessedFood.swift
//  DiningCoach
//
//  Created by SHSEO on 2023/07/11.
//

import Foundation

protocol FoodProtocol {
    var id: Int64? { get set }
    var foodImage: String? { get set }
    var foodCategory: String? { get set }
    var name: String? { get set }
    var country: String? { get set }
    var brandName: String? { get set }
    var reportNo: String? { get set }
    var foodKind: String? { get set }
    var allergyInfo: String? { get set }
    var storage: String? { get set }
    var barcode: Int? { get set }
    var amountPerServing: Int? { get set }
    var nutritionInfo: NutritionInfo? { get set }
}

struct ProcessedFood: Codable, FoodProtocol {
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
        case country
        case brandName = "brand_name"
        case reportNo = "report_no"
        case foodKind = "food_kind"
        case allergyInfo = "allergy_info"
        case storage
        case barcode
        case amountPerServing = "amount_per_serving"
        case nutritionInfo = "nutrition_info"
    }
}
