//
//  SearchResultView.swift
//  DiningCoach
//
//  Created by SHSEO on 2023/06/26.
//

import SwiftUI
import Kingfisher

enum FoodCategory: CaseIterable {
    case processedFood
    case freshFood
    case cookedFood
    
    var title: String {
        switch self {
        case .processedFood: return "가공식품"
        case .freshFood: return "신선식품"
        case .cookedFood: return "조리식품"
        }
    }
}


struct SearchResultView<T: SearchStoreProtocol>: View {
    @ObservedObject var searchStore: T
    @State var isMoreActive = false
    @State var selectedFoodCategory: FoodCategory = .processedFood
    @State var isCustom = false
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            
            VStack(spacing: isMoreActive ? 16 : 24) {
                SearchBarView(searchStore: searchStore)
                    .padding(.top, 12)
                    .zIndex(0)
                
                if searchStore.isTextFieldFocus && !searchStore.searchedText.isEmpty {
                    SearchListView(searchStore: searchStore)
                        .zIndex(1)
                } else {
                    ZStack {
                        ScrollView {
                            VStack(spacing: 48) {
                                ProcessedFoodView(searchStore: searchStore,
                                                  foodCategory: FoodCategory.processedFood,
                                                  food: searchStore.processedFoods,
                                                  selectedFoodCategory: $selectedFoodCategory,
                                                  isMoreActive: $isMoreActive,
                                                  path: $searchStore.path)
                                FreshFoodView(foodCategory: FoodCategory.freshFood,
                                              food: searchStore.freshFoods,
                                              selectedFoodCategory: $selectedFoodCategory,
                                              isMoreActive: $isMoreActive,
                                              path: $searchStore.path)
                                CookedFoodView(foodCategory: FoodCategory.processedFood,
                                               food: searchStore.cookedFoods,
                                               selectedFoodCategory: $selectedFoodCategory,
                                               isMoreActive: $isMoreActive,
                                               path: $searchStore.path)
                            }
                        }
                        .zIndex(0)
                        if isMoreActive {
                            SearchResultMoreView(searchStore: searchStore, selectedTab: $selectedFoodCategory, isCustom: $isCustom)
                                .zIndex(1)
                        }
                    }
                    
                }
            }
            // TODO: 추가정보 입력 or 미입력 값 불러오기
            if isCustom {
                AddInfoInputView(isCustom: $isCustom)
            }
        }
        .onAppear {
            searchStore.isTextFieldFocus = false
        }
        .animation(.easeInOut(duration: 0.2), value: isMoreActive)
        
    }
}
extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}

struct FoodHeaderView: View {
    let foodCategory: FoodCategory
    let isFoodEmpty: Bool
    @Binding var selectedFoodCategory: FoodCategory
    @Binding var isMoreActive: Bool
    var body: some View {
        HStack {
            Text(foodCategory.title)
                .font(.semiBold, size: 16, lineHeight: 24)
                .foregroundColor(.neutral900)
            
            Spacer()
            
            Text("더보기")
                .font(.bold, size: 11, lineHeight: 16)
                .foregroundColor(.neutral700)
                .onTapGesture {
                    if isFoodEmpty { return }
                    switch foodCategory {
                    case .processedFood:
                        selectedFoodCategory = .processedFood
                    case .freshFood:
                        selectedFoodCategory = .freshFood
                    case .cookedFood:
                        selectedFoodCategory = .cookedFood
                    }
                    isMoreActive = true
                }
        }
        .padding([.horizontal], 16)
    }
}


struct ProcessedFoodView<T: SearchStoreProtocol>: View {
    @ObservedObject var searchStore: T
    let foodCategory: FoodCategory
    let food: [ProcessedFood]
    @Binding var selectedFoodCategory: FoodCategory
    @Binding var isMoreActive: Bool
    @Binding var path: [SearchStackType]
    var body: some View {
        VStack {
            FoodHeaderView(foodCategory: foodCategory,
                           isFoodEmpty: food.isEmpty,
                           selectedFoodCategory: $selectedFoodCategory,
                           isMoreActive: $isMoreActive)
            
            if food.isEmpty {
                FoodReqView()
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(0..<min(food.count, 15), id: \.self) { index in
                            let foodItem = food[index]
                            VStack(alignment: .leading, spacing: 8) {
                                KFImage(URL(string: foodItem.foodImage ?? ""))
                                    .placeholder({
                                        ProgressView()
                                    })
                                    .fade(duration: 0.2)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 140, height: 96)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                
                                Text(foodItem.name ?? "")
                                    .font(.medium, size: 14, lineHeight: 20)
                            }
                            .onTapGesture {
                                searchStore.selectedDetailFood = foodItem
                                path.append(.detail)
                                
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                }
            }
        }
    }
}

struct FreshFoodView: View {
    let foodCategory: FoodCategory
    let food: [FreshFood]
    @Binding var selectedFoodCategory: FoodCategory
    @Binding var isMoreActive: Bool
    @Binding var path: [SearchStackType]
    var body: some View {
        VStack {
            FoodHeaderView(foodCategory: foodCategory,
                           isFoodEmpty: food.isEmpty,
                           selectedFoodCategory: $selectedFoodCategory,
                           isMoreActive: $isMoreActive)
            
            if food.isEmpty {
                FoodReqView()
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(0..<min(food.count, 15), id: \.self) { index in
                            let foodItem = food[index]
                            VStack(alignment: .leading, spacing: 8) {
                                KFImage(URL(string: foodItem.foodImage ?? ""))
                                    .placeholder({
                                        ProgressView()
                                    })
                                    .fade(duration: 0.2)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 140, height: 96)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                
                                Text(foodItem.name ?? "")
                                    .font(.medium, size: 14, lineHeight: 20)
                            }
                            .onTapGesture {
                                path.append(.detail)
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                }
            }
        }
    }
}

struct CookedFoodView: View {
    let foodCategory: FoodCategory
    let food: [CookedFood]
    @Binding var selectedFoodCategory: FoodCategory
    @Binding var isMoreActive: Bool
    @Binding var path: [SearchStackType]
    var body: some View {
        VStack {
            FoodHeaderView(foodCategory: foodCategory,
                           isFoodEmpty: food.isEmpty,
                           selectedFoodCategory: $selectedFoodCategory,
                           isMoreActive: $isMoreActive)
            
            if food.isEmpty {
                FoodReqView()
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(0..<min(food.count, 15), id: \.self) { index in
                            let foodItem = food[index]
                            VStack(alignment: .leading, spacing: 8) {
                                KFImage(URL(string: foodItem.foodImage ?? ""))
                                    .placeholder({
                                        ProgressView()
                                    })
                                    .fade(duration: 0.2)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 140, height: 96)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                
                                Text(foodItem.name ?? "")
                                    .font(.medium, size: 14, lineHeight: 20)
                            }
                            .onTapGesture {
                                path.append(.detail)
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                }
            }
        }
    }
}

struct FoodReqView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("검색된 식품이 없습니다.\n원하시는 식품이 없다면 등록 요청을 해주세요.")
                .font(.semiBold, size: 14, lineHeight: 16)
                .foregroundColor(.neutral400)
                .multilineTextAlignment(.center)
            
            Button(action: {
                // TODO: 등록 요청 로직 작성
            }, label: {
                Text("등록 요청")
                    .frame(width: 72, height: 24)
                    .font(.bold, size: 11, lineHeight: 16)
                    .foregroundColor(.primary500)
                    .overlay (
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.primary500, lineWidth: 1)
                    )
            })
        }
        .padding(.vertical, 36)
    }
}


struct SearchResultView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultView(searchStore: SearchStore())
    }
}
