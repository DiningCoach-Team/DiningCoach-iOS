//
//  SearchStoreProtocol.swift
//  DiningCoach
//
//  Created by SHSEO on 2023/06/27.
//

import Foundation
import Combine
import SwiftUI

protocol SearchStoreProtocol: ObservableObject {
    var searchedText: String { get set }
    var path: [SearchStackType] { get set }
    var isTextFieldFocus: Bool { get set }
    var processedFoods: [ProcessedFood] { get set }
    var freshFoods: [FreshFood] { get set }
    var cookedFoods: [CookedFood] { get set }
    var recentWordList: [String] { get set }
    var recommendationWord: [String] { get set }
    var recommendationFood: [String] { get set }
    var suggestionWord: [String] { get set }
    var selectedDetailFood: FoodProtocol? { get set }
    
    func fetchProcessedFoods()
    func fetchFreshFoods()
    func fetchCookedFoods()
    func fetchSuggestions()
    func addRecentSearch(word: String)
    func removeRecentSearch(word: String)
    func removeAllRecentSearch()
    func updateSuggestions()
}


