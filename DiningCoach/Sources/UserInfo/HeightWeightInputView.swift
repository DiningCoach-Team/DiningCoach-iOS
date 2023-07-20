//
//  HeightWeightInputView.swift
//  DiningCoach
//
//  Created by 심현석 on 2023/06/23.
//

import SwiftUI

struct HeightWeightInputView: View {
    @Environment(\.dismiss) var dismiss
    @State private var isCompleted = false
    
    @State private var height: String = ""
    @State private var weight: String = ""
    
    var body: some View {
        VStack(spacing: 0) {
            VStack {
                ProgressView(value: 2, total: 7)
                    .tint(Color.primary500)
            }
            .padding(.vertical, 8)
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    Text("키를 알려주세요")
                        .font(.bold, size: 22, lineHeight: 28)
                    
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
                .padding(.vertical, 16)
                
                Spacer()
                    .frame(height: 132)
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("몸무게를 알려주세요")
                        .font(.bold, size: 22, lineHeight: 28)
                        .frame(height: 28)
                    
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
                .padding(.vertical, 16)
                
                Spacer()
            }
            
            VStack {
                if height.isEmpty || weight.isEmpty {
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
        .ignoresSafeArea(.keyboard, edges: .bottom)
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

