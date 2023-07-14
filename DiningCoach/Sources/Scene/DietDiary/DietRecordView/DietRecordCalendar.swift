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
            ForEach(-3..<4, id: \.self) { index in
                let date = getDate(for: index)
                let day = getDay(for: index)
                
                CalendarCell(day: day, isSelected: store.selectedDate == date)
                    .frame(maxWidth: .infinity)
                    .onTapGesture {
                        store.selectedDate = date
                    }
            }
        }
    }
    
    // 오늘을 기준으로 전후 7일 중에 특정 일자에 해당하는 날짜를 반환
    func getDay(for day: Int) -> Int {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        let date = Calendar.current.date(byAdding: .day, value: day, to: Date())!
        return Int(formatter.string(from: date))!
    }
    
    // 오늘을 기준으로 전후 7일 중에 특정 일자에 해당하는 Date를 반환
    func getDate(for day: Int) -> Date {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        let startOfDay = Calendar.current.date(from: components)!
        return Calendar.current.date(byAdding: .day, value: day, to: startOfDay)!
    }
}

// MARK: - 월간 달력

struct MonthlyCalendar: View {
    @EnvironmentObject var store: DietRecordStore
    
    var body: some View {
        let numberOfDaysInMonth: Int = numberOfDaysInMonth(in: Date())
        let firstWeekdayOfMonth: Int = firstWeekdayOfMonth(in: Date()) - 1
        let totalIndex = numberOfDaysInMonth + firstWeekdayOfMonth
        
        VStack {
            LazyVGrid(columns: Array(repeating: GridItem(), count: 7), spacing: 16) {
                ForEach(0 ..< totalIndex, id: \.self) { index in
                    if index < firstWeekdayOfMonth {
                        Rectangle()
                            .frame(maxWidth: .infinity)
                            .foregroundColor(Color.clear)
                    } else {
                        let date = getDate(for: index - firstWeekdayOfMonth)
                        let day = index - firstWeekdayOfMonth + 1
                        
                        CalendarCell(day: day, isSelected: store.selectedDate == date)
                            .frame(maxWidth: .infinity)
                            .onTapGesture {
                                store.selectedDate = date
                            }
                    }
                }
            }
        }
    }
    
    // 특정 날짜가 속한 월에 포함된 전체 일수 반환
    func numberOfDaysInMonth(in date: Date) -> Int {
        return Calendar.current.range(of: .day, in: .month, for: date)!.count
    }
    
    // 특정 날짜가 속한 월의 첫 날이 해당 주에서 몇 번째 요일에 해당하는지 반환
    func firstWeekdayOfMonth(in date: Date) -> Int {
        let components = Calendar.current.dateComponents([.year, .month], from: date)
        let firstDayOfMonth = Calendar.current.date(from: components)!
        return Calendar.current.component(.weekday, from: firstDayOfMonth)
    }
    
    // 이번 달에서 특정 일자에 해당하는 Date를 반환
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
                                store.dayOfMonthRecord(day: day)
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
