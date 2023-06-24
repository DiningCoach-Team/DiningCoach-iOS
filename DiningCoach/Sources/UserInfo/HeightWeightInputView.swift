//
//  HeightWeightInputView.swift
//  DiningCoach
//
//  Created by 심현석 on 2023/06/23.
//

import SwiftUI

struct HeightWeightInputView: View {
    @State private var height: String = ""
    @State private var weight: String = ""
    
    @State private var isCompleted = false
    
    var body: some View {
        VStack {
            ProgressView(value: 2, total: 6)
                .tint(Color.primary500)
            
            VStack {
                HStack {
                    Text("키를 알려주세요")
                        .font(.bold, size: 22, lineHeight: 28)
                        .padding(.vertical, 20)
                    
                    Spacer()
                }
                
                HStack {
                    HeightWeightTextField(text: $height)
                    
                    Text("cm")
                        .font(.bold, size: 20, lineHeight: 24)
                        .foregroundColor(height.isEmpty ? Color.neutral300 : Color.neutral900)
                }
            }
            
            Spacer()
                .frame(height: 100)
            
            VStack {
                HStack {
                    Text("몸무게를 알려주세요")
                        .font(.bold, size: 22, lineHeight: 28)
                        .padding(.vertical, 20)
                    
                    Spacer()
                }
                
                HStack {
                    HeightWeightTextField(text: $weight)
                    
                    Text("kg")
                        .font(.bold, size: 20, lineHeight: 24)
                        .foregroundColor(height.isEmpty ? Color.neutral300 : Color.neutral900)
                }
            }
            
            Spacer()
            
            if height.isEmpty || weight.isEmpty {
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
        .padding(.horizontal, 16)
        .onTapGesture {
            hideKeyboard()
        }
    }
}

struct HeightWeightTextField: View {
    @Binding var text: String
    
    var body: some View {
        VStack {
            TextField("", text: $text)
                .fontWeight(.bold)
                .tint(Color.primary500)
                .keyboardType(.numberPad)
            
            Rectangle()
                .frame(height: 2)
                .foregroundColor(text.isEmpty ? Color.neutral300 : Color.primary500)
        }
    }
}

struct HeightWeightInputView_Previews: PreviewProvider {
    static var previews: some View {
        HeightWeightInputView()
    }
}

