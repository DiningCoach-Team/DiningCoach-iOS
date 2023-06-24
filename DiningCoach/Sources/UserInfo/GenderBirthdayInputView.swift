//
//  GenderBirthdayInputView.swift
//  DiningCoach
//
//  Created by 심현석 on 2023/06/23.
//

import SwiftUI

struct GenderBirthdayInputView: View {
    @State private var maleSelected = false
    @State private var femaleSelected = false
    
    @State private var year: String = ""
    @State private var month: String = ""
    @State private var day: String = ""
    
    @State private var isCompleted = false
    
    var body: some View {
        VStack {
            ProgressView(value: 1, total: 6)
                .tint(Color.primary500)
            
            HStack {
                Text("성별은 어떻게 되시나요?")
                    .font(.bold, size: 22, lineHeight: 28)
                    .padding(.vertical, 20)
                
                Spacer()
            }
            
            HStack {
                Button {
                    maleSelected = true
                    femaleSelected = false
                    // input data
                } label: {
                    if maleSelected {
                        Image("Property=male, State=selected, version=ios")
                            .frame(width: 164, height: 164)
                    } else {
                        Image("Property=male, State=unselected, version=ios")
                            .frame(width: 164, height: 164)
                    }
                }
                
                Spacer()
                
                Button {
                    maleSelected = false
                    femaleSelected = true
                    // input data
                } label: {
                    if femaleSelected {
                        Image("Property=female, State=selected, version=ios")
                            .frame(width: 164, height: 164)
                    } else {
                        Image("Property=female, State=unselected, version=ios")
                            .frame(width: 164, height: 164)
                    }
                }
            }
            
            Spacer()
                .frame(height: 20)
            
            HStack {
                Text("생년월일을 알려주세요")
                    .font(.bold, size: 22, lineHeight: 28)
                    .padding(.vertical, 20)
                
                Spacer()
            }
            
            HStack {
                BirthdayTextField(placeHolder: "년", text: $year)
                
                if !(maleSelected || femaleSelected) || year.isEmpty || month.isEmpty || day.isEmpty {
                    Text(".")
                        .foregroundColor(Color.neutral300)
                } else {
                    Text(".")
                        .foregroundColor(.black)
                }
                
                BirthdayTextField(placeHolder: "월", text: $month)
                
                if !(maleSelected || femaleSelected) || year.isEmpty || month.isEmpty || day.isEmpty {
                    Text(".")
                        .foregroundColor(Color.neutral300)
                } else {
                    Text(".")
                        .foregroundColor(.black)
                }
                
                BirthdayTextField(placeHolder: "일", text: $day)
            }
            
            Spacer()
            
            if !(maleSelected || femaleSelected) || year.isEmpty || month.isEmpty || day.isEmpty {
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
        .padding(.horizontal, 32)
        .onTapGesture {
            hideKeyboard()
        }
    }
}

struct BirthdayTextField: View {
    var placeHolder: String
    @Binding var text: String
    
    var body: some View {
        VStack {
            TextField(placeHolder, text: $text)
                .fontWeight(.bold)
                .multilineTextAlignment(text.isEmpty ? .trailing : .center)
                .tint(Color.primary500)
                .keyboardType(.numberPad)
            
            Rectangle()
                .frame(height: 2)
                .foregroundColor(text.isEmpty ? Color.neutral300 : Color.primary500)
        }
    }
}


struct GenderBirthdayInputView_Previews: PreviewProvider {
    static var previews: some View {
        GenderBirthdayInputView()
    }
}
