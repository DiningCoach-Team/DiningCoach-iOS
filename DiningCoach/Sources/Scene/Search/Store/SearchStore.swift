//
//  SearchStore.swift
//  DiningCoach
//
//  Created by SHSEO on 2023/06/23.
//

import SwiftUI
import Combine

class SearchStore: SearchStoreProtocol  {
    @Published var processedFoods: [ProcessedFood] = [] // 가공식품
    @Published var freshFoods: [FreshFood] = [] // 신선식품
    @Published var cookedFoods: [CookedFood] = [] // 조리식품
    @Published var isTextFieldFocus: Bool = false // 텍스트필드 포커스
    @Published var recentWordList: [String]  = [] //최근 검색어
    @Published var recommendationWord: [String] = [] //추천 검색어
    @Published var recommendationFood: [String] = [] //추천 음식
    @Published var suggestionWord: [String] = [] //검색어 자동완성 리스트
    @Published var path: [SearchStackType] = [] //네비게이션 스택
    @Published var searchedText: String = "" //사용자 검색어
    @Published var selectedDetailFood: FoodProtocol?
    
    init() {
        recentWordList = UserDefaults.standard.array(forKey: "recentWordList") as? [String] ?? []
        fetchProcessedFoods()
        fetchSuggestions()
        fetchRecommendationWord()
        fetchRecommendationFood()
    }
    
    
    func fetchProcessedFoods() {
        processedFoods = MockParser.load([ProcessedFood].self, from: "MockProcessedFood") ?? []
        
    }
    
    func fetchFreshFoods() {
        freshFoods = []
    }
    
    func fetchCookedFoods() {
        cookedFoods = []
    }
    
    //최근 검색어 저장
    func addRecentSearch(word: String) {
        if recentWordList.contains(word) {
            recentWordList.removeAll { $0 == word }
        }
        if recentWordList.count >= 15 {
            recentWordList.removeLast()
        }
        
        recentWordList.insert(word, at: 0)
        UserDefaults.standard.set(recentWordList, forKey: "recentWordList")
    }
    
    //최근 검색어 삭제
    func removeRecentSearch(word: String) {
        recentWordList.removeAll { $0 == word }
    }
    
    //최근 검색어 전체삭제
    func removeAllRecentSearch() {
        recentWordList.removeAll()
    }
    
    //추천 검색어 가져오기
    func fetchRecommendationWord() {
        //TODO: API 연동
        recommendationWord = ["우유", "매일 재래식 된장", "매일 우유", "닭가슴살", "리면", "해물 라면", "평양 냉면", "불닭 볶음면", "신라면",
                              "비비고 고기만두", "비비고 김치만두", "바나나 우유", "매일 두유", "자갈치"]
    }
    
    //추천 식품 가져오기
    func fetchRecommendationFood() {
        //TODO: API 연동
    }
    
    //
    func fetchSuggestions() {
        suggestionWord = ["우유", "매일 재래식 된장", "매일 우유", "닭가슴살", "리면", "해물 라면", "평양 냉면", "불닭 볶음면", "신라면",
                          "비비고 고기만두", "비비고 김치만두", "바나나 우유", "매일 두유", "자갈치"]
    }
    
    //검색어 자동완성
    func updateSuggestions() {
        if searchedText.isEmpty {
            suggestionWord = ["우유", "매일 재래식 된장", "매일 우유", "닭가슴살", "리면", "해물 라면", "평양 냉면", "불닭 볶음면", "신라면",
                              "비비고 고기만두", "비비고 김치만두", "바나나 우유", "매일 두유", "자갈치"]
        } else {
//            suggestionWord = suggestionWord.filter{ $0.contains(searchedText) }
        }
    }
}

// MARK:
final class MockParser {
    static func load<D: Codable>(_ type: D.Type, from resourceName: String) -> D? {
    // type : 디코딩 할 때 사용되는 모델의 타입
    // resourceName : json 파일의 이름
        guard let path = Bundle.main.path(forResource: resourceName, ofType: "json") else {
            return nil
        }
        // 확장자가 json인 파일의 경로를 가져오는 부분
        guard let jsonString = try? String(contentsOfFile: path) else {
            return nil
        }
         // 파일 안에 있는 데이터(json)을 String 형태로 가져온다
//        print("jsonString : \(jsonString)")
        
        let decoder = JSONDecoder()
        let data = jsonString.data(using: .utf8)
        // string 형태로 가져온 json을 data형으로 변환
        guard let data = data else { return nil }
        return try? decoder.decode(type, from: data)
        // data를 swift 형태로 사용하기 위해 decoding하는 과정
    }
}


enum SearchStackType {
    case result
    case detail
}

enum MealTime: CaseIterable {
    case breakfast
    case lunch
    case dinner
    case snack
    
    var imageName: String {
        switch self {
        case .breakfast: return "breakfast"
        case .lunch: return "lunch"
        case .dinner: return "dinner"
        case .snack: return "snack"
        }
    }
    
    var title: String {
        switch self {
        case .breakfast: return "아침"
        case .lunch: return "점심"
        case .dinner: return "저녁"
        case .snack: return "간식"
        }
    }
}
