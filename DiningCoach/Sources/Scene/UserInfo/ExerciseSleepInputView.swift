//
//  ExerciseSleepInputView.swift
//  DiningCoach
//
//  Created by 심현석 on 2023/06/23.
//

import SwiftUI

struct ExerciseSleepInputView: View {
    @Environment(\.dismiss) var dismiss
    @State private var isCompleted: Bool = false

    @State private var selectedExercise = Set<Exercise>()
    @State private var selectedSleep = Set<Sleep>()
    
    var body: some View {
        VStack(spacing: 0) {
            VStack {
                ProgressView(value: 3, total: 7)
                    .tint(Color.primary500)
            }
            .padding(.vertical, 8)
            
            ScrollView(showsIndicators: false) {
                VStack {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("일주일에 몇 시간 운동하시나요?")
                            .font(.bold, size: 22, lineHeight: 28)
                            .frame(height: 28)
                        
                        Spacer()
                            .frame(height: 24)
                        
                        VStack(spacing: 16) {
                            ForEach(Exercise.allCases, id: \.self) { exercise in
                                CheckButton(element: exercise, state: selectedExercise.contains(exercise) ? .selected : .unselected) {
                                    if selectedExercise.contains(exercise) {
                                        selectedExercise.remove(exercise)
                                    } else if selectedExercise.isEmpty {
                                        selectedExercise.insert(exercise)
                                    }
                                    // input data
                                }
                            }
                        }
                    }
                    
                    Spacer()
                        .frame(height: 48)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("하루에 몇 시간 주무시나요?")
                            .font(.bold, size: 22, lineHeight: 28)
                            .frame(height: 28)
                        
                        Spacer()
                            .frame(height: 24)
                        
                        VStack(spacing: 16) {
                            ForEach(Sleep.allCases, id: \.self) { sleep in
                                CheckButton(element: sleep, state: selectedSleep.contains(sleep) ? .selected : .unselected) {
                                    if selectedSleep.contains(sleep) {
                                        selectedSleep.remove(sleep)
                                    } else if selectedSleep.isEmpty {
                                        selectedSleep.insert(sleep)
                                    }
                                    // input data
                                }
                            }
                        }
                    }
                }
                .padding(.vertical, 8)
            }
            .padding(.top, 16)
            
            VStack {
                if selectedExercise.isEmpty || selectedSleep.isEmpty {
                    DCButton("다음", style: .primary) { }
                        .disabled(true)
                } else {
                    DCButton("다음", style: .primary) {
                        isCompleted = true
                        // send data
                    }
                }
            }
            .padding(.vertical, 16)
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

enum Exercise: CheckButtonElement, CaseIterable {
    case under1Hour
    case between1And5Hours
    case between5And10Hours
    case over10Hours
    
    var type: String {
        switch self {
        case .under1Hour:
            return "1시간 미만"
        case .between1And5Hours:
            return "1시간 ~ 5시간"
        case .between5And10Hours:
            return "5시간 ~ 10시간"
        case .over10Hours:
            return "5시간 ~ 10시간"
        }
    }
}

enum Sleep: CheckButtonElement, CaseIterable {
    case under6Hours
    case between6And10Hours
    case over10Hours
    
    var type: String {
        switch self {
        case .under6Hours:
            return "6시간 미만"
        case .between6And10Hours:
            return "6시간 ~ 10시간"
        case .over10Hours:
            return "10시간 이상"
        }
    }
}
