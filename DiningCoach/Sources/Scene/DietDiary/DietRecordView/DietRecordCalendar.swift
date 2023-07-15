//
//  DietRecordCalendar.swift
//  DiningCoach
//
//  Created by 심현석 on 2023/07/12.
//

import SwiftUI

struct DietRecordCalendar: View {
    @EnvironmentObject var store: DietRecordStore
    
    var body: some View {
        ZStack {
            VStack {
                Color.primary500
                    .cornerRadius(24)
                    .frame(height: store.isWeeklyCalendar ? 200 : 488)
                Spacer()
            }
            .ignoresSafeArea()
            
            VStack {
                CalendarNavigation()
                CalendarHeader()
                if store.isWeeklyCalendar {
                    WeeklyCalendarView()
                } else {
                    MonthlyCalendar()
                }
                Spacer()
            }
            .padding(.horizontal, 16)
        }
    }
}

//MARK: - 달력 네비게이션

struct CalendarNavigation: View {
    @EnvironmentObject var store: DietRecordStore
    
    var body: some View {
        HStack {
            Text(store.isWeeklyCalendar
                 ? "\(store.selectedDate.toCalendarHeaderString()) \(Image(systemName: "chevron.up"))"
                 : "\(store.selectedDate.toCalendarHeaderString()) \(Image(systemName: "chevron.down"))")
            .font(.pretendard(weight: .bold, size: 18))
            .foregroundColor(.white)
            .onTapGesture {
                store.isWeeklyCalendar.toggle()
            }
            
            Spacer()
            
            NavigationLink {
                
            } label: {
                Image("Bell")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .tint(.white)
                    .padding(8)
            }
            
            NavigationLink {
                
            } label: {
                Image("User Rounded")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .padding(8)
            }
        }
        .frame(height: 48)
    }
}

// MARK: - 달력 헤더

struct CalendarHeader: View {
    let weekDays = ["일", "월", "화", "수", "목", "금", "토"]
    
    var body: some View {
        HStack {
            ForEach(weekDays, id: \.self) { day in
                Text(day)
                    .font(.pretendard(weight: .semiBold, size: 16))
                    .foregroundColor(.primary800)
                    .frame(maxWidth: .infinity)
            }
        }
        .padding(.bottom, 4)
    }
}

//MARK: 주간 달력

struct WeeklyCalendarView: View {
    @EnvironmentObject var store: DietRecordStore
    
    var body: some View {
        HStack {
            let firstDayOfWeek = store.getWeekDates(date: Date()).startOfWeek
            
            ForEach(0..<7, id: \.self) { dayOffset in
                let date = getDate(offset: dayOffset, from: firstDayOfWeek)
                let dayNumber = getDayNumber(for: date)
                
                CalendarCell(day: dayNumber, isSelected: store.selectedDate == date)
                    .frame(maxWidth: .infinity)
                    .onTapGesture {
                        store.selectedDate = date
                    }
            }
        }
    }
    
    // 주의 첫 날을 기준으로, 특정 일자에 해당하는 Date를 반환
    private func getDate(offset: Int, from firstDayOfWeek: Date) -> Date {
        return Calendar.current.date(byAdding: .day, value: offset, to: firstDayOfWeek)!
    }
    
    // 특정 Date에서 일자를 추출하여 반환
    private func getDayNumber(for date: Date) -> Int {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return Int(formatter.string(from: date))!
    }
}

// MARK: - 월간 달력

struct MonthlyCalendar: View {
    @EnvironmentObject var store: DietRecordStore
    
    var body: some View {
        let firstDayOfMonth = store.getMonthDates(date: Date()).startOfMonth
        let lastDayofMonth = store.getMonthDates(date: Date()).endOfMonth
        
        let daysInMonth = Calendar.current.component(.day, from: lastDayofMonth)
        let firstWeekdayOfMonth = Calendar.current.component(.weekday, from: firstDayOfMonth)
        let totalIndex = daysInMonth + firstWeekdayOfMonth
        
        VStack {
            LazyVGrid(columns: Array(repeating: GridItem(), count: 7), spacing: 16) {
                ForEach(0 ..< totalIndex, id: \.self) { index in
                    if index < firstWeekdayOfMonth {
                        Rectangle()
                            .frame(maxWidth: .infinity)
                            .foregroundColor(Color.clear)
                    } else {
                        let dayIndex = index - firstWeekdayOfMonth
                        let date = getDate(for: dayIndex)
                        let dayNumber = dayIndex + 1
                        
                        CalendarCell(day: dayNumber, isSelected: store.selectedDate == date)
                            .frame(maxWidth: .infinity)
                            .onTapGesture {
                                store.selectedDate = date
                            }
                    }
                }
            }
        }
    }
    
    // 달의 첫 날을 기준으로,  특정 일자에 해당하는 Date를 반환
    func getDate(for day: Int) -> Date {
        let components = Calendar.current.dateComponents([.year, .month], from: Date())
        let firstDayOfMonth = Calendar.current.date(from: components)!
        return Calendar.current.date(byAdding: .day, value: day, to: firstDayOfMonth)!
    }
}

// MARK: - 날짜 셀

struct CalendarCell: View {
    @EnvironmentObject var store: DietRecordStore
    
    var day: Int
    var isSelected: Bool = false

    let event: [MealTime] = [.breakfast, .snack]
    
    init(day: Int, isSelected: Bool) {
        self.day = day
        self.isSelected = isSelected
    }
    
    var body: some View {
        ZStack {
            if isSelected {
                VStack {
                    RoundedRectangle(cornerRadius: 12)
                        .frame(width: 30, height: 28)
                        .foregroundColor(.white)
                    Spacer()
                }
            }
            
            VStack {
                Text(String(day))
                    .font(.pretendard(weight: .semiBold, size: 16))
                    .foregroundColor(isSelected ? .primary500 : .white)
                    .frame(height: 28)
                
                Spacer()
                
                HStack(spacing: 3) {
                    ForEach(MealTime.allCases.indices, id: \.self) { index in
                        Circle()
                            .frame(width: 5, height: 5)
                            .foregroundColor(
                                store.getRecordsForDay(day: day)
                                    .map { $0.mealTime }
                                    .contains(MealTime.allCases[index])
                                ? .white : .primary800)
                    }
                }
            }
        }
        .frame(width: 29, height: 41)
    }
}

// MARK: - Date extension

extension Date {
    func toCalendarHeaderString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 M월"
        return formatter.string(from: self)
    }
}

// MARK: - Previews

struct DietRecordCalendar_Previews: PreviewProvider {
    static var previews: some View {
        DietRecordCalendar()
            .environmentObject(DietRecordStore())
    }
}
