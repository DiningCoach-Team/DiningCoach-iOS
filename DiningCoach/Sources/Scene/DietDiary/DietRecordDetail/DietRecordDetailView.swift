//
//  DietRecordDetailView.swift
//  DiningCoach
//
//  Created by 심현석 on 2023/07/11.
//

import SwiftUI

struct DietRecordDetailView: View {
    @EnvironmentObject var store: DietRecordStore
    @State private var isPresented: Bool = false
    @FocusState var isTextEditorFocused: Bool
        
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                DietRecordDetailNavigation()
                MealTimeTabBar(isFocused: _isTextEditorFocused)
                
                ScrollViewReader { proxy in
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 8) {
                            DietRecordDetailImageList()
                            DietRecordDetailFoodList()
                            DietRecordDetailDiary(isFocused: _isTextEditorFocused)
                        }
                        .id(1)
                    }
                    .onChange(of: store.selectedMealTime) { _ in
                        proxy.scrollTo(1, anchor: .top)
                    }
                }
                
                HStack(spacing: 8) {
                    Spacer()
                    if store.isEditMode {
                        DietRecordDetailButton(title: "저장", isFilled: true)
                            .onTapGesture {
                                store.isEditMode = false
                                
                                let newRecord = DietRecord(mealTime: store.selectedMealTime, food: store.foodList, diary: store.diaryText, date: store.selectedDate)
                                store.updateDietRecord(newRecord: newRecord)
                            }
                    } else {
                        DietRecordDetailButton(title: "삭제", isFilled: false)
                            .onTapGesture {
                                withAnimation {
                                    isPresented = true
                                }
                            }
                        DietRecordDetailButton(title: "편집", isFilled: true)
                            .onTapGesture {
                                store.isEditMode = true
                            }
                    }
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
            }
            
            if isPresented {
                RemoveAlert(isPresented: $isPresented)
            }
        }
        .navigationBarBackButtonHidden()
        .onTapGesture {
            isTextEditorFocused = false
        }
    }
}

struct DietRecordDetailNavigation: View {
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
                            store.isEditMode = false
                            store.isWeeklyCalendar = true
                            store.selectedMealTime = .breakfast
                            store.selectedDate = store.selectedDate
                        }
                }
                .frame(width: 24, height: 24)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)

                Spacer()
            }
            
            Text(store.selectedDate.toNaviTitleWithWeekday())
                .font(.pretendard(weight: .bold, size: 18))
                .foregroundColor(.white)
        }
        .frame(height: 48)
    }
}

struct MealTimeTabBar: View {
    @FocusState var isFocused: Bool
    
    var body: some View {
        HStack {
            MealTimeTabBarCell(type: .breakfast, isFocused: _isFocused)
            MealTimeTabBarCell(type: .lunch, isFocused: _isFocused)
            MealTimeTabBarCell(type: .dinner, isFocused: _isFocused)
            MealTimeTabBarCell(type: .snack, isFocused: _isFocused)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
        .onTapGesture {
            isFocused = false
        }
    }
}

struct MealTimeTabBarCell: View {
    @EnvironmentObject var store: DietRecordStore
    var type: MealTime
    @FocusState var isFocused: Bool
    
    var body: some View {
        ZStack {
            Text(type.rawValue)
                .font(.pretendard(weight: .bold, size: 14))
                .foregroundColor(store.selectedMealTime == type ? .primary500 : .neutral400)
                .onTapGesture {
                    store.selectedMealTime = type
                    isFocused = false
                }
            
            if store.selectedMealTime == type {
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

struct DietRecordDetailButton: View {
    var title: String
    var isFilled: Bool
    
    var body: some View {
        Text(title)
            .font(.pretendard(weight: .semiBold, size: 12))
            .foregroundColor(isFilled ? .primary500 : .white)
            .frame(width: 56, height: 32)
            .background(isFilled ? .white : .primary500)
            .cornerRadius(12)
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.primary500, lineWidth: 1)
            }
        
    }
}

// MARK: - Previews

struct DietRecordDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DietRecordDetailView()
            .environmentObject(DietRecordStore())
    }
}
