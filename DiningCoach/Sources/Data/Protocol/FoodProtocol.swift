//
//  FoodProtocol.swift
//  DiningCoach
//
//  Created by SHSEO on 2023/07/18.
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
