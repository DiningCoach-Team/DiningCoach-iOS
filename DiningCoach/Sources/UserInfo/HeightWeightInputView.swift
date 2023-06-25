//
//  HeightWeightInputView.swift
//  DiningCoach
//
//  Created by 심현석 on 2023/06/23.
//

import SwiftUI

struct HeightWeightInputView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var height: String = ""
    @State private var weight: String = ""
    
    @State private var isCompleted = false
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
                .frame(height: 10)
            
            ProgressView(value: 2, total: 7)
                .tint(Color.primary500)
                        
            VStack(spacing: 0) {
                Spacer()
                    .frame(height: 24)
                
                HStack {
                    Text("키를 알려주세요")
                        .font(.bold, size: 22, lineHeight: 28)
                    
                    Spacer()
                }
                
                Spacer()
                    .frame(height: 24)
                
                HStack {
                    HeightWeightTextField(text: $height)
                    
                    Text("cm")
                        .font(.bold, size: 20, lineHeight: 24)
                        .foregroundColor(height.isEmpty ? Color.neutral300 : Color.neutral900)
                        .padding(.horizontal, 8)
                }
            }
            
            Spacer()
                .frame(height: 132)
            
            VStack(spacing: 0) {
                Spacer()
                    .frame(height: 24)
                
                HStack {
                    Text("몸무게를 알려주세요")
                        .font(.bold, size: 22, lineHeight: 28)
                    
                    Spacer()
                }
                
                Spacer()
                    .frame(height: 24)
                
                HStack {
                    HeightWeightTextField(text: $weight)
                    
                    Text("kg")
                        .font(.bold, size: 20, lineHeight: 24)
                        .foregroundColor(weight.isEmpty ? Color.neutral300 : Color.neutral900)
                        .padding(.horizontal, 8)
                }
            }
            
            Spacer()
            
//            if height.isEmpty || weight.isEmpty {
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
        .onTapGesture {
            hideKeyboard()
        }
        .navigationDestination(isPresented: $isCompleted) {
            ExerciseSleepInputView()
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

struct HeightWeightTextField: View {
    @Binding var text: String
    
    var body: some View {
        VStack(spacing: 0) {
            TextField("", text: $text)
                .font(.bold, size: 18, lineHeight: 24)
                .tint(Color.primary500)
                .keyboardType(.numberPad)
                .frame(height: 48)
            
            Rectangle()
                .frame(height: 1)
                .foregroundColor(text.isEmpty ? Color.neutral300 : Color.primary500)
        }
    }
}

struct HeightWeightInputView_Previews: PreviewProvider {
    static var previews: some View {
        HeightWeightInputView()
    }
}

