//
//  DietRecordDetailFoodList.swift
//  DiningCoach
//
//  Created by 심현석 on 2023/07/14.
//

import SwiftUI

struct DietRecordDetailFoodList: View {
    @EnvironmentObject var store: DietRecordStore
    
    var body: some View {
        VStack(spacing: 16) {
            if store.isEditMode {
                if store.foodList.isEmpty {
                    FoodNameRectangle(isFoodPlusMode: true)
                } else {
                    ForEach(store.foodList, id: \.self) { food in
                        FoodNameRectangle(name: food.name)
                    }
                    FoodNameRectangle(isFoodPlusMode: true)
                }
            } else {
                if store.foodList.isEmpty {
                    FoodNameRectangle(isFoodPlusMode: true)
                } else {
                    ForEach(store.foodList, id: \.self) { food in
                        FoodNameRectangle(name: food.name)
                    }
                }
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
    }
}

struct FoodNameRectangle: View {
    @EnvironmentObject var store: DietRecordStore
    var name: String?
    var isFoodPlusMode: Bool = false
    @State private var isPresentedFoodAddictionView: Bool = false
    
    var body: some View {
        Group {
            if isFoodPlusMode {
                Button {
                    isPresentedFoodAddictionView = true
                } label: {
                    HStack(spacing: 4) {
                        Text("음식 추가")
                            .font(.pretendard(weight: .semiBold, size: 14))
                            .foregroundColor(.neutral300)
                            .padding(.vertical, 12)
                        Image(systemName: "plus")
                            .foregroundColor(.neutral300)
                            .frame(width: 24, height: 24)
                    }
                }
                .disabled(!store.isEditMode)
                .navigationDestination(isPresented: $isPresentedFoodAddictionView) {
                    FoodAddictionView()
                }
            } else {
                HStack(spacing: 4) {
                    Text(name ?? "")
                        .font(.pretendard(weight: .medium, size: 14))
                        .foregroundColor(.neutral900)
                        .padding(.vertical, 12)
                        .padding(.leading, 16)
                    Spacer()
                    if store.isEditMode {
                        Group {
                            Image(systemName: "xmark")
                                .resizable()
                                .frame(width: 8, height: 8)
                                .foregroundColor(.neutral500)
                                .onTapGesture {
                                    if let index = store.foodList.firstIndex(where: { $0.name == name }) {
                                        store.foodList.remove(at: index)
                                    }
                                }
                        }
                        .frame(width: 40, height: 40)
                    }
                }
            }
        }
        .frame(height: 40)
        .frame(maxWidth: .infinity)
        .background(.white)
        .cornerRadius(12)
        .shadow(color: Color(white: 0, opacity: 0.08), radius: 10)
    }
}
