//
//  FoodAddictionView.swift
//  DiningCoach
//
//  Created by 심현석 on 2023/07/17.
//

import SwiftUI

struct FoodAddictionView: View {
    @EnvironmentObject var store: DietRecordStore
    @State private var isPresented: Bool = false
    @FocusState private var isTextEditorFocused: Bool
        
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                FoodAddictionNavigation()
                FoodAddictionMethodSelect(isFocused: _isTextEditorFocused)
                
                ScrollViewReader { proxy in
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 8) {
                            if store.selectedFoodAddictionMethod == .search {
                                // 식품 검색
                            } else {
                                FoodInfoInput()
                            }
                        }
                        .id(1)
                    }
                    .onChange(of: store.selectedFoodAddictionMethod) { _ in
                        proxy.scrollTo(1, anchor: .top)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
        .onTapGesture {
            isTextEditorFocused = false
        }
    }
}

struct FoodAddictionNavigation: View {
    @EnvironmentObject var store: DietRecordStore
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.primary500
                .ignoresSafeArea()
            
            HStack {
                Group {
                    Image(systemName: "chevron.backward")
                        .resizable()
                        .frame(width: 8, height: 16)
                        .foregroundColor(.white)
                        .onTapGesture {
                            dismiss()
                            
                        }
                }
                .frame(width: 24, height: 24)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)

                Spacer()
            }
            
            Text("음식 추가")
                .font(.pretendard(weight: .bold, size: 18))
                .foregroundColor(.white)
        }
        .frame(height: 48)
    }
}

struct FoodAddictionMethodSelect: View {
    @FocusState var isFocused: Bool
    
    var body: some View {
        HStack {
            FoodAddictionMethodCell(method: .search, isFocused: _isFocused)
            FoodAddictionMethodCell(method: .input, isFocused: _isFocused)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
        .onTapGesture {
            isFocused = false
        }
    }
}

struct FoodAddictionMethodCell: View {
    @EnvironmentObject var store: DietRecordStore
    var method: FoodAddictionMetohd
    @FocusState var isFocused: Bool
    
    var body: some View {
        ZStack {
            Text(method.rawValue)
                .font(.pretendard(weight: .bold, size: 14))
                .foregroundColor(store.selectedFoodAddictionMethod == method ? .primary500 : .neutral400)
                .onTapGesture {
                    store.selectedFoodAddictionMethod = method
                    isFocused = false
                }
            
            if store.selectedFoodAddictionMethod == method {
                VStack {
                    Spacer()
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.primary500)
                }
            }
        }
        .frame(height: 36)
        .frame(maxWidth: .infinity)
    }
}

struct FoodAdditionView_Previews: PreviewProvider {
    static var previews: some View {
        FoodAddictionView()
            .environmentObject(DietRecordStore())
    }
}
