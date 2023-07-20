//
//  DietRecordCalendar.swift
//  DiningCoach
//
//  Created by 심현석 on 2023/07/12.
//

import SwiftUI

struct DietRecordCalendar: View {
    @EnvironmentObject var store: DietRecordStore
    @State private var month: Int = 7
    
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
                CalendarNavigation(month: $month)
                CalendarHeader()
                if store.isWeeklyCalendar {
                    WeeklyCalendarView(month: $month)
                } else {
                    MonthlyCalendar(month: $month)
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
    @Binding var month: Int
    
    var body: some View {
        HStack {
            Text(store.isWeeklyCalendar
                 ? "\(calendarHeaderString(month: month)) \(Image(systemName: "chevron.up"))"
                 : "\(calendarHeaderString(month: month)) \(Image(systemName: "chevron.down"))")
            .font(.pretendard(weight: .bold, size: 18))
            .foregroundColor(.white)
            .onTapGesture {
                store.isWeeklyCalendar.toggle()
            }
            .onChange(of: store.isWeeklyCalendar) { _ in
                let month = Calendar.current.component(.month, from: store.selectedDate)
                self.month = month
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
    
    func calendarHeaderString(month: Int) -> String {
        if store.isWeeklyCalendar {
            let components = Calendar.current.dateComponents([.year, .month], from: store.selectedDate)
            let date = Calendar.current.date(from: components)!
            return date.toCalendarHeaderString()
        }
        
        var components = Calendar.current.dateComponents([.year, .month], from: Date())
        components.month = month
        let date = Calendar.current.date(from: components)!
        return date.toCalendarHeaderString()
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
    @Binding var month: Int
    
    var body: some View {
        HStack {
            let firstDayOfWeek = store.getWeekDates(date: store.selectedDate).startOfWeek
            
            ForEach(0..<7, id: \.self) { dayOffset in
                let date = getDate(offset: dayOffset, from: firstDayOfWeek)
                
                CalendarCell(date: date, isSelected: store.selectedDate == date)
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
}

// MARK: - 월간 달력

struct MonthlyCalendar: View {
    @EnvironmentObject var store: DietRecordStore
    @Binding var month: Int
    @State private var dragOffset = CGSize.zero
    
    var body: some View {
        let firstDayOfMonth = getMonthDates(month: month).firstDayOfMonth
        let lastDayofMonth = getMonthDates(month: month).lastDayofMonth
        
        let daysInMonth = Calendar.current.component(.day, from: lastDayofMonth)
        let firstWeekdayOfMonth = Calendar.current.component(.weekday, from: firstDayOfMonth) - 1
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
                        let date = getDate(month: month, day: dayIndex)
                        
                        CalendarCell(date: date, isSelected: store.selectedDate == date)
                            .frame(maxWidth: .infinity)
                            .onTapGesture {
                                store.selectedDate = date
                                store.isWeeklyCalendar = true
                            }
                    }
                }
            }
        }
        .gesture(
            DragGesture()
                .onChanged { value in
                    self.dragOffset.width = value.translation.width
                }
                .onEnded { value in
                    if self.dragOffset.width < -50 {
                        self.month += 1
                    } else if self.dragOffset.width > 50 {
                        self.month -= 1
                    }
                    self.dragOffset = CGSize.zero
                }
        )
    }
    
    // 달의 첫 날을 기준으로, 특정 일자에 해당하는 Date를 반환
    func getDate(month: Int, day: Int) -> Date {
        var components = Calendar.current.dateComponents([.year, .month], from: Date())
        components.month = month
        let firstDayOfMonth = Calendar.current.date(from: components)!
        return Calendar.current.date(byAdding: .day, value: day, to: firstDayOfMonth)!
    }
    
    // 특정 달의 첫날과 마지막날을 반환
    func getMonthDates(month: Int) -> (firstDayOfMonth: Date, lastDayofMonth: Date) {
        var components = Calendar.current.dateComponents([.year, .month], from: Date())
        components.month = month
        components.day = 1
        let firstDayOfMonth = Calendar.current.date(from: components)!
        
        var lastDayComponents = DateComponents()
        lastDayComponents.month = 1
        lastDayComponents.day = -1
        let lastDayofMonth = Calendar.current.date(byAdding: lastDayComponents, to: firstDayOfMonth)!
        
        return (firstDayOfMonth, lastDayofMonth)
    }
}

// MARK: - 날짜 셀

struct CalendarCell: View {
    @EnvironmentObject var store: DietRecordStore
    
    var date: Date
    var isSelected: Bool

    let event: [MealTime] = [.breakfast, .snack]
    
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
                Text(dateToDay(date: date))
                    .font(.pretendard(weight: .semiBold, size: 16))
                    .foregroundColor(isSelected ? .primary500 : .white)
                    .frame(height: 28)
                
                Spacer()
                
                HStack(spacing: 3) {
                    ForEach(MealTime.allCases.indices, id: \.self) { index in
                        Circle()
                            .frame(width: 5, height: 5)
                            .foregroundColor(
                                store.getRecordsForDay(date: date)
                                    .map { $0.mealTime }
                                    .contains(MealTime.allCases[index])
                                ? .white : .primary800)
                    }
                }
            }
        }
        .frame(width: 29, height: 41)
    }
    
    func dateToDay(date: Date) -> String {
        let component = Calendar.current.component(.day, from: date)
        return String(component)
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
