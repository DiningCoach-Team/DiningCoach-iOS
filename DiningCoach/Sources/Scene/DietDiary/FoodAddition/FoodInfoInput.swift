//
//  FoodInfoInput.swift
//  DiningCoach
//
//  Created by 심현석 on 2023/07/17.
//

import SwiftUI

struct FoodInfoInput: View {
    @EnvironmentObject var store: DietRecordStore
    @Environment(\.dismiss) var dismiss
    
    @State private var category: FoodItem.Catgory?
    @State private var name: String = ""
    @State private var brand: String = ""
    @State private var capacity: String = ""
    @State private var unit: FoodItem.Unit = .gram
    @State private var calorie: String = ""
    @State private var carbohydrate: String = ""
    @State private var protein: String = ""
    @State private var fat: String = ""
    @State private var sugar: String = ""
    @State private var cholesterol: String = ""
    @State private var sodium: String = ""
    @State private var saturatedFat: String = ""
    @State private var transFat: String = ""
    
    var body: some View {
        VStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 16) {
                FoodInfoTitle(title: "식품의 카테고리를 선택해 주세요", isEssential: true)
                
                HStack(spacing: 16) {
                    FoodCategoryRectangle(category: .processed, selectedCategory: $category)
                    FoodCategoryRectangle(category: .fresh, selectedCategory: $category)
                    FoodCategoryRectangle(category: .Cooked, selectedCategory: $category)
                }
            }
            .padding(.vertical, 8)
            
            VStack(alignment: .leading, spacing: 16) {
                FoodInfoTitle(title: "식품명을 입력해 주세요", isEssential: true)
                FoodInfoTextField(textInput: $name, placeholder: "식품명을 입력해 주세요")
            }
            
            VStack(alignment: .leading, spacing: 16) {
                FoodInfoTitle(title: "식품의 내용량을 입력해주세요", isEssential: true)
                HStack(spacing: 8) {
                    FoodInfoTextField(textInput: $capacity, placeholder: "내용량을 입력해 주세요")
                    FoodUnitRectangle(unit: .gram, selectedUnit: $unit)
                    FoodUnitRectangle(unit: .milliLitre, selectedUnit: $unit)
                }
            }
            
            VStack(alignment: .leading, spacing: 16) {
                FoodInfoTitle(title: "영양성분을 입력해 주세요", isEssential: false)
                VStack(spacing: 16) {
                    FoodNutrientInput(nutrientType: .calorie, isEssential: true, nutrientValue: $calorie)
                    FoodNutrientInput(nutrientType: .carbohydrate, isEssential: false, nutrientValue: $carbohydrate)
                    FoodNutrientInput(nutrientType: .protein, isEssential: false, nutrientValue: $protein)
                    FoodNutrientInput(nutrientType: .fat, isEssential: false, nutrientValue: $fat)
                    FoodNutrientInput(nutrientType: .sugar, isEssential: false, nutrientValue: $sugar)
                    FoodNutrientInput(nutrientType: .cholesterol, isEssential: false, nutrientValue: $cholesterol)
                    FoodNutrientInput(nutrientType: .sodium, isEssential: false, nutrientValue: $sodium)
                    FoodNutrientInput(nutrientType: .saturatedFat, isEssential: false, nutrientValue: $saturatedFat)
                    FoodNutrientInput(nutrientType: .transFat, isEssential: false, nutrientValue: $transFat)
                }
            }
            
            DCButton("완료", style: .primary, action: {
                dismiss()
                
                let calorie = Double(calorie) ?? 0
                let carbohydrate = Double(carbohydrate) ?? 0
                let protein = Double(protein) ?? 0
                let fat = Double(fat) ?? 0
                let sugar = Double(sugar) ?? 0
                let cholesterol = Double(cholesterol) ?? 0
                let sodium = Double(sodium) ?? 0
                let saturatedFat = Double(saturatedFat) ?? 0
                let transFat = Double(transFat) ?? 0
                
                store.foodList.append(FoodItem(name: name, nutrient: Nutrient(calorie: calorie, carbohydrate: carbohydrate, protein: protein, fat: fat, sugar: sugar, cholesterol: cholesterol, sodium: sodium, saturatedFat: saturatedFat, transFat: transFat)))
            })
            .padding(.bottom, 8)
            .disabled(category == nil || name == "" || capacity == "" || calorie == "")
        }
        .padding(.horizontal, 16)
        .navigationBarBackButtonHidden()
    }
}

struct FoodInfoTitle: View {
    var title: String
    var isEssential: Bool
    
    var body: some View {
        HStack(alignment:. top) {
            Text(title)
                .font(.pretendard(weight: .semiBold, size: 16))
                .foregroundColor(.neutral900)
            
            if isEssential {
                Circle()
                    .frame(width: 6, height: 6)
                    .foregroundColor(.primary500)
            }
        }
    }
}

struct FoodCategoryRectangle: View {
    @EnvironmentObject var store: DietRecordStore
    var category: FoodItem.Catgory
    @Binding var selectedCategory: FoodItem.Catgory?
    
    var body: some View {
        Text(category.rawValue)
            .font(.pretendard(weight: .medium, size: 14))
            .foregroundColor(selectedCategory == category ? .primary500 : .neutral900)
            .frame(height: 64)
            .frame(maxWidth: .infinity)
            .background(selectedCategory == category ? Color.primary50 : .white)
            .cornerRadius(12)
            .shadow(color: Color(white: 0, opacity: 0.06), radius: 10)
            .onTapGesture {
                selectedCategory = category
            }
    }
}

struct FoodInfoTextField: View {
    @Binding var textInput: String
    let placeholder: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack(alignment: .leading) {
                if textInput == "" {
                    Text(placeholder)
                        .font(.pretendard(weight: .semiBold, size: 16))
                        .foregroundColor(.neutral400)
                }
                
                TextField("", text: $textInput)
                    .font(.pretendard(weight: .semiBold, size: 16))
                    .frame(height: 56)
            }

            Rectangle()
                .frame(height: 1)
                .foregroundColor(textInput == "" ? Color.neutral300 : .primary500)
        }
    }
}

struct FoodUnitRectangle: View {
    var unit: FoodItem.Unit
    @Binding var selectedUnit: FoodItem.Unit
    
    var body: some View {
        Text(unit.rawValue)
            .font(selectedUnit == unit
                  ? .pretendard(weight: .bold, size: 18)
                  : .pretendard(weight: .semiBold, size: 16))
            .foregroundColor(selectedUnit == unit ? .primary500 : .neutral900)
            .frame(width: 39, height: 64)
            .background(selectedUnit == unit ? Color.primary50 : .white)
            .cornerRadius(12)
            .shadow(color: Color(white: 0, opacity: 0.06), radius: 10)
            .onTapGesture {
                selectedUnit = unit
            }
    }
}

struct FoodNutrientInput: View {
    var nutrientType: NutrientType
    var isEssential: Bool
    @Binding var nutrientValue: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment:. top) {
                Text(nutrientType.rawValue)
                    .font(.pretendard(weight: .semiBold, size: 14))
                    .foregroundColor(.neutral900)
                
                if isEssential {
                    Circle()
                        .frame(width: 6, height: 6)
                        .foregroundColor(.primary500)
                }
            }
            
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    TextField("", text: $nutrientValue)
                        .font(.pretendard(weight: .semiBold, size: 16))
                        .frame(height: 56)
                    
                    Text(nutrientType.unit)
                        .font(.pretendard(weight: .semiBold, size: 20))
                        .foregroundColor(nutrientValue == "" ? .neutral300 : .primary500)
                        .multilineTextAlignment(.trailing)
                        .padding(.horizontal, 8)
                        .frame(width: 54, alignment: .trailing)
                }
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(nutrientValue == "" ? Color.neutral300 : .primary500)
            }
        }
    }
}
