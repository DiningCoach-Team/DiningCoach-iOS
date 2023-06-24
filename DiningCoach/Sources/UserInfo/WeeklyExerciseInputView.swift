//
//  WeeklyExerciseInputView.swift
//  DiningCoach
//
//  Created by 심현석 on 2023/06/23.
//

import SwiftUI

struct WeeklyExerciseInputView: View {
    
    
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

            }
            
            Spacer()
            
//            if height.isEmpty || weight.isEmpty {
//                DCButton("다음", style: .primary) {
//                }
//                .disabled(true)
//            } else {
//                DCButton("다음", style: .primary) {
//                    isCompleted = true
//                    // send data
//                }
//            }
//
//            Spacer()
//            .frame(height: 10)
        }
        .padding(16)
    }
}
    
struct WeeklyExerciseInputView_Previews: PreviewProvider {
    static var previews: some View {
        WeeklyExerciseInputView()
    }
}

