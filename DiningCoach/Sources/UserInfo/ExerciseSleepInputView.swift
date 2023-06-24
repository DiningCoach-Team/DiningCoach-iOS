//
//  ExerciseSleepInputView.swift
//  DiningCoach
//
//  Created by 심현석 on 2023/06/23.
//

import SwiftUI

struct ExerciseSleepInputView: View {
    @State private var selectedExerciseButton: Int?
    @State private var selectedSleepButton: Int?
    @State private var isCompleted: Bool = false
    
    var exercise = ["1시간 미만", "1시간 ~ 5시간", "5시간 ~ 10시간", "10시간 이상"]
    var sleep = ["6시간 미만", "6시간 ~ 10시간", "10시간 이상"]
    
    var body: some View {
        VStack {
            ProgressView(value: 3, total: 6)
                .tint(Color.primary500)
            
            VStack {
                HStack {
                    Text("일주일에 몇 시간 운동하시나요?")
                        .font(.bold, size: 22, lineHeight: 28)
                        .padding(.vertical, 20)
                    
                    Spacer()
                }
                
                ForEach(0..<exercise.count, id: \.self) { index in
                    CheckmarkButton(exercise[index], state: selectedExerciseButton == index ? .selected : .unselected) {
                        selectedExerciseButton = index
                    }
                }

            }
            
            Spacer()
                .frame(height: 30)
            
            VStack {
                HStack {
                    Text("하루에 몇 시간 주무시나요?")
                        .font(.bold, size: 22, lineHeight: 28)
                        .padding(.vertical, 20)
                    
                    Spacer()
                }
                
                ForEach(0..<sleep.count, id: \.self) { index in
                    CheckmarkButton(sleep[index], state: selectedSleepButton == index ? .selected : .unselected) {
                        selectedSleepButton = index
                        // input data
                    }
                }

            }
            
            if selectedExerciseButton != nil || selectedSleepButton != nil {
                DCButton("다음", style: .primary) {
                }
                .disabled(true)
            } else {
                DCButton("다음", style: .primary) {
                    isCompleted = true
                    // send data
                }
            }

            Spacer()
            .frame(height: 10)
        }
        .padding(16)
    }
}
    
struct WeeklyExerciseInputView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseSleepInputView()
    }
}

