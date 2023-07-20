//
//  RecordAddView.swift
//  DiningCoach
//
//  Created by SHSEO on 2023/07/07.
//

import SwiftUI

struct DiaryAddView<T: SearchStoreProtocol>: View {
    @ObservedObject var searchStore: T
    @State var date: Date = Date()
    @State private var isComplete = false
    @State var selectedDay: String?
    @State var selectedMeal: MealTime?
    @Binding var isShowingSheet: Bool
    
    @State var push = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack() {
                    CalendarHeaderView(selectedMeal: $selectedMeal, isShowingSheet: $isShowingSheet)
                    
                    CalendarView(date: $date, selectedDay: $selectedDay)
                        .padding(.top, 24)
                    
                    DCButton("추가", style: .primary, action: {
                        isComplete = true
                    })
                    .disabled(selectedDay != nil && selectedMeal != nil ? false : true)
                    .padding([.horizontal, .bottom], 16)
                    .padding(.top, 24)
                }
                .frame(maxWidth: .infinity)
                .background(.white)
            }
            .navigationDestination(isPresented: $isComplete, destination: {
                DiaryAddResultView(food: searchStore.selectedDetailFood, isShowingSheet: $isShowingSheet)
                    .navigationBarHidden(true)
            })
        }
    }
}

struct CalendarHeaderView: View {
    @Binding var selectedMeal: MealTime?
    @Binding var isShowingSheet: Bool
    var body: some View {
        VStack {
            ZStack() {
                Text("날짜를 선택해주세요.")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .font(.bold, size: 14, lineHeight: 20)
                    .foregroundColor(.neutral900)
                HStack {
                    Spacer()
                    Button(action: {
                        isShowingSheet = false
                    }, label: {
                        Image("xmark_large")
                            .renderingMode(.template)
                            .foregroundColor(.neutral900)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 17)
                    })
                }
            }
            .frame(maxWidth: .infinity)
            .overlay(
                GeometryReader { geometry in
                    Color.neutral100
                        .frame(width: geometry.size.width - 32, height: 1)
                        .position(x: geometry.size.width / 2, y: geometry.size.height)
                }
            )
            HStack(spacing: 32) {
                ForEach(MealTime.allCases, id: \.self) { time in
                    VStack(spacing: 4) {
                        Button(action: {
                            selectedMeal = time
                        }, label: {
                            Image(time.imageName)
                                .renderingMode(.template)
                                .padding(4)
                                .background(
                                    Circle()
                                        .fill(selectedMeal == time ? Color.primary500 : Color.clear)
                                        .overlay(Circle()
                                            .stroke(selectedMeal == time ? Color.primary500 : Color.neutral100, lineWidth: 1)
                                        )
                                )
                                .foregroundColor(selectedMeal == time ? .white : Color.neutral700)
                            
                            
                        })
                        Text(time.title)
                            .font(.regular, size: 11, lineHeight: 16)
                            .foregroundColor(.neutral700)
                    }
                }
            }
            .padding(.top, 24)
        }
    }
}

struct CalendarView: View {
    @Binding var date: Date
    @Binding var selectedDay: String?
    var body: some View {
        VStack {
            CalendarTitle(date: $date)
            DayOfWeek()
            CalendarGrid(selectedDay: $selectedDay, date: $date)
                .padding(.horizontal, 20)
        }
    }
}

struct CalendarTitle: View {
    @Binding var date: Date
    var body: some View {
        HStack {
            Button(action: {
                date = CalendarHelper().minusYear(date)
            }, label: {
                Image("double_prev")
            })
            Button(action: {
                date = CalendarHelper().minusMonth(date)
            }, label: {
                Image("prev")
            })
            Text(CalendarHelper().monthYearString(date))
                .frame(maxWidth: .infinity)
                .font(.bold, size: 14, lineHeight: 20)
                .foregroundColor(.neutral900)
            Button(action: {
                date = CalendarHelper().plusMonth(date)
            }, label: {
                Image("next")
            })
            Button(action: {
                date = CalendarHelper().plusYear(date)
            }, label: {
                Image("double_next")
            })
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 20)
    }
}

struct DayOfWeek: View {
    var body: some View {
        HStack() {
            Text("S")
                .dayOfWeek()
                .foregroundColor(.primary600)
            Text("M")
                .dayOfWeek()
                .foregroundColor(.neutral900)
            Text("T")
                .dayOfWeek()
                .foregroundColor(.neutral900)
            Text("W")
                .dayOfWeek()
                .foregroundColor(.neutral900)
            Text("T")
                .dayOfWeek()
                .foregroundColor(.neutral900)
            Text("F")
                .dayOfWeek()
                .foregroundColor(.neutral900)
            Text("S")
                .dayOfWeek()
                .foregroundColor(.primary600)
        }
        .padding(.top, 24)
        .padding(.horizontal, 20)
    }
}

struct CalendarGrid: View {
    @Binding var selectedDay: String?
    @Binding var date: Date
    
    var body: some View {
        VStack(spacing: 1)  {
            let daysInMonth = CalendarHelper().daysInMonth(date)
            let firstDayOfMonth = CalendarHelper().firstOfMonth(date)
            let startingSpaces = CalendarHelper().weekDay(firstDayOfMonth)
            let prevMonth = CalendarHelper().minusMonth(date)
            let daysInPrevMonth = CalendarHelper().daysInMonth(prevMonth)
            
            ForEach(0..<6) { row in
                HStack(spacing: 8) {
                    ForEach(1..<8) { column in
                        let count = column + (row * 7)
                        CalendarCell(selectedDay: $selectedDay,
                                     count: count,
                                     startingSpaces:startingSpaces,
                                     daysInMonth: daysInMonth,
                                     daysInPrevMonth: daysInPrevMonth)
                        
                    }
                }
                .frame(height: 48)
            }
        }
        
    }
}

struct CalendarCell: View
{
    @Binding var selectedDay: String?
    let count : Int
    let startingSpaces : Int
    let daysInMonth : Int
    let daysInPrevMonth : Int
    
    var body: some View
    {
        let day = monthStruct().day()
        Text(day)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .font(.semiBold, size: selectedDay == day ? 16 : 11, lineHeight: selectedDay == day ? 24 : 16)
            .foregroundColor(textColor(type: monthStruct().monthType))
            .background(
                RoundedRectangle(cornerRadius: 57)
                    .fill(selectedDay == day && monthStruct().monthType == .Current ? Color.primary500 : Color.clear)
            )
            .onTapGesture {
                if monthStruct().monthType == .Current {
                    withAnimation(.spring(response: 0.2, dampingFraction: 0.7)) {
                        selectedDay = monthStruct().day()
                    }
                }
            }
        
    }
    private func textColor(type: MonthType) -> Color
    {
        if type != MonthType.Current { return Color.clear }
        if type == MonthType.Current && selectedDay == monthStruct().day() {
            return Color.white
        }
        return Color.neutral900
    }
    
    private func monthStruct() -> MonthStruct
    {
        let start = startingSpaces == 0 ? startingSpaces + 7 : startingSpaces
        if(count <= start)
        {
            let day = daysInPrevMonth + count - start
            return MonthStruct(monthType: MonthType.Previous, dayInt: day)
        }
        else if (count - start > daysInMonth)
        {
            let day = count - start - daysInMonth
            return MonthStruct(monthType: MonthType.Next, dayInt: day)
        }
        
        let day = count - start
        return MonthStruct(monthType: MonthType.Current, dayInt: day)
    }
    struct MonthStruct
    {
        var monthType: MonthType
        var dayInt : Int
        func day() -> String
        {
            return String(dayInt)
        }
    }
    
    enum MonthType
    {
        case Previous
        case Current
        case Next
    }
}


extension Text {
    func dayOfWeek() -> some View {
        self
            .frame(maxWidth: .infinity)
            .font(.bold, size: 14, lineHeight: 20)
    }
}

struct DiaryAddView_Previews: PreviewProvider {
    static var previews: some View {
        DiaryAddView(searchStore: SearchStore(), isShowingSheet: .constant(false))
    }
}
