//
//  SearchResultMoreView.swift
//  DiningCoach
//
//  Created by SHSEO on 2023/06/28.
//

import SwiftUI
import Kingfisher


struct SearchResultMoreView<T: SearchStoreProtocol>: View {
    @ObservedObject var searchStore: T
    @Binding var selectedTab: FoodCategory
    @Binding var isCustom: Bool
    var body: some View {
        ZStack {
            Color.white
            
            VStack {
                HeaderTabView(isCustom: $isCustom, selectedTab: $selectedTab)
                switch selectedTab {
                case .processedFood:
                    MoreFoodView(selectedDetailFood: $searchStore.selectedDetailFood,
                                 path: $searchStore.path,
                                 foods: searchStore.processedFoods)
                case .freshFood:
                    MoreFoodView(selectedDetailFood: $searchStore.selectedDetailFood,
                                 path: $searchStore.path,
                                 foods: searchStore.freshFoods)
                case .cookedFood:
                    MoreFoodView(selectedDetailFood: $searchStore.selectedDetailFood,
                                 path: $searchStore.path,
                                 foods: searchStore.cookedFoods)
                }
                Spacer()
            }
            
        }
        
    }
}

struct MoreFoodView: View {
    @Binding var selectedDetailFood: FoodProtocol?
    @Binding var path: [SearchStackType]
    let foods: [FoodProtocol]
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        if foods.count != 0 {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 15) {
                    ForEach(foods, id: \.id) { food in
                        VStack(alignment: .leading, spacing: 8) {
                            KFImage(URL(string: food.foodImage ?? ""))
                                .placeholder({
                                    ProgressView()
                                })
                                .fade(duration: 0.2)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 164, height: 130)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                            
                            VStack(alignment: .leading, spacing:4) {
                                Text(food.name ?? "")
                                    .font(.medium, size: 14, lineHeight: 20)
                                    .foregroundColor(.neutral900)
                                Text(food.foodKind ?? "")
                                    .font(.regular, size: 11, lineHeight: 16)
                                    .foregroundColor(.neutral900)
                            }
                        }
                        .onTapGesture {
                            selectedDetailFood = food
                            path.append(.detail)
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
            }
        } else {
            GeometryReader { geo in
                FoodReqView()
                    .position(x: geo.size.width / 2, y: geo.size.height / 2)
            }
        }
    }
}

struct HeaderTabView: View {
    @Binding var isCustom: Bool
    @Binding var selectedTab: FoodCategory
    
    var body: some View {
        HStack() {
            HStack(spacing: 19) {
                ForEach(FoodCategory.allCases, id: \.self) { foodCategory in
                    VStack(spacing: 0) {
                        Text(foodCategory.title)
                            .font(.bold, size: 14, lineHeight: 20)
                            .foregroundColor(foodCategory == selectedTab ? .primary500 : .neutral400)
                            .padding(.vertical, 8)
                        
                        Rectangle()
                            .foregroundColor(foodCategory == selectedTab ? .primary500 : .clear)
                            .frame(height: 1)
                    }
                    .frame(width: 49)
                    .onTapGesture {
                        selectedTab = foodCategory
                    }
                }
            }
            
            Spacer()
                
            Button(action: {
                isCustom.toggle()
            }, label: {
                HStack(spacing: 4) {
                    Text("맞춤 식품만 보기")
                        .font(.bold, size: 11, lineHeight: 16)
                        .foregroundColor(.neutral600)
                    Image("check")
                        .background(
                            RoundedRectangle(cornerRadius: 4)
                                .fill(isCustom ? Color.primary500 : Color.neutral200)
                        )
                }
            })
            .buttonStyle(.plain)
        }
        .frame(height: 52)
        .padding(.horizontal, 16)
        .animation(.easeInOut(duration: 0.2), value: selectedTab)
    }
}

struct AddInfoInputView: View {
    @Binding var isCustom: Bool
    var body: some View {
        ZStack {
            Color.black
                .opacity(0.5)
                .ignoresSafeArea()
            
            VStack {
                Text("추가정보를 입력하시겠습니까?")
                    .font(.bold, size: 18, lineHeight: 24)
                    .foregroundColor(.neutral900)
                    .padding(.top, 24)
                
                Text("맞춤 식품 목록을 제공하기 위해서는\n추가정보 입력이 필요해요!")
                    .font(.semiBold, size: 16, lineHeight: 24)
                    .foregroundColor(.neutral700)
                    .multilineTextAlignment(.center)
                    .padding(.top, 16)
                
                DCButton("추가정보 입력하기", style: .primary, action: {
                    // TODO: 추가정보 입력 뷰 불러오기
                })
                .padding([.top, .horizontal], 16)
                
                Text("괜찮아요")
                    .font(.bold, size: 16, lineHeight: 24)
                    .foregroundColor(.primary500)
                    .padding(.top, 8)
                    .padding(.bottom, 24)
                    .background(
                        Color.primary500
                            .frame(height: 2) // underline's height
                            .offset(y: 5) // underline's y pos
                    )
                    .onTapGesture {
                        isCustom = false
                    }
            }
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(.white)
            )
            .padding(.horizontal, 28)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        
    }
}

struct SearchResultMoreView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultMoreView(searchStore: SearchStore(), selectedTab: .constant(.processedFood), isCustom: .constant(false))
    }
}
