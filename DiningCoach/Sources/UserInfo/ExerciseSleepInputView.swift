//
//  ExerciseSleepInputView.swift
//  DiningCoach
//
//  Created by 심현석 on 2023/06/23.
//

import SwiftUI

struct ExerciseSleepInputView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var selectedExerciseButton: Int?
    @State private var selectedSleepButton: Int?
    
    @State private var isCompleted: Bool = false
    
    var exercise = ["1시간 미만", "1시간 ~ 5시간", "5시간 ~ 10시간", "10시간 이상"]
    var sleep = ["6시간 미만", "6시간 ~ 10시간", "10시간 이상"]
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
                .frame(height: 10)
            
            ProgressView(value: 3, total: 7)
                .tint(Color.primary500)
            
            Spacer()
                .frame(height: 24)
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    HStack {
                        Text("일주일에 몇 시간 운동하시나요?")
                            .font(.bold, size: 22, lineHeight: 28)
                        
                        Spacer()
                    }
                    
                    Spacer()
                        .frame(height: 24)
                    
                    VStack(spacing: 16) {
                        ForEach(0..<exercise.count, id: \.self) { index in
                            CheckButton(title: exercise[index], state: selectedExerciseButton == index ? .selected : .unselected) {
                                if selectedExerciseButton == index {
                                    selectedExerciseButton = nil
                                } else {
                                    selectedExerciseButton = index
                                    // input data
                                }
                            }
                        }
                    }
                    
                    Spacer()
                        .frame(height: 10)
                }
                
                Spacer()
                    .frame(height: 48)
                
                VStack(spacing: 0) {
                    HStack {
                        Text("하루에 몇 시간 주무시나요?")
                            .font(.bold, size: 22, lineHeight: 28)
                        
                        Spacer()
                    }
                    
                    Spacer()
                        .frame(height: 24)
                    
                    VStack(spacing: 16) {
                        ForEach(0..<sleep.count, id: \.self) { index in
                            CheckButton(title: sleep[index], state: selectedSleepButton == index ? .selected : .unselected) {
                                if selectedSleepButton == index {
                                    selectedSleepButton = nil
                                } else {
                                    selectedSleepButton = index
                                    // input data
                                }
                            }
                        }
                    }
                }
            }
            
//            if selectedExerciseButton == nil || selectedSleepButton == nil {
//                DCButton("다음", style: .primary) { }
//                    .disabled(true)
//            } else {
//                DCButton("다음", style: .primary) {
//                    isCompleted = true
//                    // send data
//                }
//            }
            DCButton("다음", style: .primary) {
                isCompleted = true
            }
            
            Spacer()
                .frame(height: 10)
        }
        .padding(.horizontal, 16)
        .navigationDestination(isPresented: $isCompleted) {
            PreferredFoodInputView()
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.backward")
                        .tint(.black)
                }
            }
            
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .tint(.black)
                }
            }
        }
    }
}

struct WeeklyExerciseInputView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseSleepInputView()
    }
}

