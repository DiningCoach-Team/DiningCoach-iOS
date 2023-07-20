//
//  FoodDetailView.swift
//  DiningCoach
//
//  Created by SHSEO on 2023/06/29.
//

import SwiftUI
import Kingfisher

struct SearchDetailView<T: SearchStoreProtocol>: View {
    @ObservedObject var searchStore: T
    @State private var isShowingSheet = false
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            DetailHeaderView(path: $searchStore.path)

            ScrollView {
                VStack {
                    DetailMainView(food: searchStore.selectedDetailFood)

                    Rectangle()
                        .fill(Color.neutral100)
                        .frame(height: 4)

                    FoodInfoView(food: searchStore.selectedDetailFood)
                        .padding(.top, 24)

                    Rectangle()
                        .fill(Color.neutral100)
                        .frame(height: 4)
                        .padding(.top, 24)

                    NutritionView(food: searchStore.selectedDetailFood)
                        .padding([.top, .bottom], 24)

                    DetailFooterView(isShowingSheet: $isShowingSheet)
                }
            }
        }
        .sheet(isPresented: $isShowingSheet, content: {
            DiaryAddView(searchStore: searchStore, isShowingSheet: $isShowingSheet)
                .presentationDetents([.fraction(0.85)])
                .interactiveDismissDisabled(true)

        })
    }
}

struct DetailHeaderView: View {
    @Binding var path: [SearchStackType]
    var body: some View {
        HStack {
            Button(action: {
                path.removeLast()
            }, label: {
                Image("arrow_left")
                    .renderingMode(.template)
                    .foregroundColor(.neutral900)
                    .padding(16)
            })
            
            Spacer()
            
            Text("가공식품")
                .font(.bold, size: 18, lineHeight: 24)
                .foregroundColor(.neutral900)
            
            Spacer()
            
            Button(action: {
                path.removeAll()
            }, label: {
                Image("Search")
                    .renderingMode(.template)
                    .foregroundColor(.neutral900)
                    .padding(16)
            })
        }
    }
}

struct DetailMainView: View {
    let food: FoodProtocol?
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            KFImage(URL(string: food?.foodImage ?? ""))
                .placeholder({
                    ProgressView()
                })
                .fade(duration: 0.2)
                .resizable()
                .frame(height: 272)
                .aspectRatio(contentMode: .fill)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.bottom, 8)
            
            Text(food?.foodKind ?? "")
                .font(.semiBold, size: 14, lineHeight: 16)
                .foregroundColor(.neutral800)
            
            Text(food?.name ?? "")
                .font(.bold, size: 18, lineHeight: 24)
                .foregroundColor(.neutral900)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 16)
    }
}

struct FoodInfoView: View {
    let food: FoodProtocol?
    var body: some View {
        VStack(alignment: .leading) {
            Text("상품정보")
                .font(.semiBold, size: 16, lineHeight: 24)
                .foregroundColor(.neutral900)
                .padding(.bottom, 16)
            
            VStack(alignment: .leading, spacing: 8) {
                InfoRow(label: "제조국", value: food?.country ?? "")
                InfoRow(label: "브랜드", value: food?.brandName ?? "")
                InfoRow(label: "품목보고번호", value: food?.reportNo ?? "")
                InfoRow(label: "식품유형", value: food?.foodKind ?? "")
                InfoRow(label: "알레르기정보", value: food?.allergyInfo ?? "")
                InfoRow(label: "보관방법", value: food?.storage ?? "")
                InfoRow(label: "유통바코드", value: "\(food?.barcode ?? Int())" )
            }
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 16)
    }
}

struct InfoRow: View {
    var label: String
    var value: String
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Text(label)
                .font(.medium, size: 16, lineHeight: 24)
                .foregroundColor(.neutral600)
            
            Text(value)
                .font(.medium, size: 16, lineHeight: 24)
                .foregroundColor(.neutral900)
                .padding(.leading, 109)
        }
    }
}

struct NutritionView: View {
    let food: FoodProtocol?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("영양성분")
                .font(.semiBold, size: 16, lineHeight: 24)
                .foregroundColor(.neutral900)
                .padding(.bottom, 16)
            
            Text("1일 영양성분 기준치 대비 (%)")
                .font(.medium, size: 16, lineHeight: 24)
                .foregroundColor(.neutral900)
                .padding(.bottom, 16)
            if let food = food {
                VStack(spacing: 16) {
                    NutritionRow(label: "탄수화물", value: food.nutritionInfo?.carbohydrate ?? 0)
                    NutritionRow(label: "당류", value: food.nutritionInfo?.sugar ?? 0)
                    NutritionRow(label: "단백질", value: food.nutritionInfo?.protein ?? 0)
                    NutritionRow(label: "지방", value: food.nutritionInfo?.fat ?? 0)
                    NutritionRow(label: "콜레스테롤", value: food.nutritionInfo?.cholesterol ?? 0)
                    NutritionRow(label: "나트륨", value: food.nutritionInfo?.sodium ?? 0)
                    NutritionRow(label: "포화지방산", value: food.nutritionInfo?.saturatedFat ?? 0)
                    NutritionRow(label: "트랜스지방", value: food.nutritionInfo?.transFat ?? 0)
                }
            } else {
                
            }
            
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 16)
    }
}

struct NutritionRow: View {
    var label: String
    var value: Float
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Text(label)
                .font(.medium, size: 16, lineHeight: 24)
                .foregroundColor(.neutral900)
            GeometryReader { geo in
                let barWidth = CGFloat(value / 100) * geo.size.width
                let formattedValue: String = String(format: "%.1f", value)
                
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(Color.neutral50)
                        .frame(width: geo.size.width, height: 16)
                    if value > 80 {
                        Rectangle()
                            .fill(Color.primary500)
                            .frame(width: barWidth, height: 16)
                            .cornerRadius(12, corners: [.bottomRight, .topRight])
                            .overlay(
                                Text(formattedValue.replacingOccurrences(of: ".0", with: "") + "%")
                                    .font(.medium, size: 14, lineHeight: 20)
                                    .foregroundColor(.neutral900)
                                    .padding(.trailing, 8)
                                , alignment: .trailing
                            )
                        
                    } else {
                        HStack(spacing: 8) {
                            Rectangle()
                                .fill(Color.primary500)
                                .frame(width: barWidth, height: 16)
                                .cornerRadius(12, corners: [.bottomRight, .topRight])
                            
                            
                            Text(formattedValue.replacingOccurrences(of: ".0", with: "") + "%")
                                .font(.medium, size: 14, lineHeight: 20)
                                .foregroundColor(.neutral900)
                        }
                    }
                    
                }
                .cornerRadius(12)
                
            }
            .padding(.leading, 86)
            
            
        }
    }
}

struct DetailFooterView: View {
    @Binding var isShowingSheet: Bool
    var body: some View {
        HStack(spacing: 16) {
            Button(action: {
                //TODO: 좋아요 버튼 클릭 시 액션 추가
            }, label: {
                Image("heart")
                    .padding(8)
            })
            
            DCButton("식단 일기에 추가", style: .primary, action: {
                isShowingSheet = true
            })
        }
        .padding(16)
    }
}



struct FoodDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SearchDetailView(searchStore: SearchStore())
    }
}

