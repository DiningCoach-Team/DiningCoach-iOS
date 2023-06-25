//
//  GenderBirthdayInputView.swift
//  DiningCoach
//
//  Created by 심현석 on 2023/06/23.
//

import SwiftUI

struct GenderBirthdayInputView: View {
    @Environment(\.dismiss) var dismiss
    @State private var isCompleted = false
    
    @State private var maleSelected = false
    @State private var femaleSelected = false
    
    @State private var year: String = ""
    @State private var month: String = ""
    @State private var day: String = ""
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                VStack {
                    ProgressView(value: 1, total: 7)
                        .tint(Color.primary500)
                }
                .padding(8)
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        VStack(alignment: .leading, spacing: 0) {
                            Text("성별은 어떻게 되시나요?")
                                .font(.bold, size: 22, lineHeight: 28)
                                .frame(height: 28)
                            
                            Spacer()
                                .frame(height: 24)
                            
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
                        }
                        .padding(.vertical, 16)
                        
                        Spacer()
                            .frame(height: 16)
                    }
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("생년월일을 알려주세요")
                            .font(.bold, size: 22, lineHeight: 28)
                            .frame(height: 28)
                        
                        Spacer()
                            .frame(height: 24)
                        
                        HStack {
                            BirthdayTextField(placeHolder: "년", text: $year)
                            
                            if !(maleSelected || femaleSelected) || year.isEmpty || month.isEmpty || day.isEmpty {
                                Text(".")
                                    .foregroundColor(Color.neutral300)
                                    .fontWeight(.bold)
                            } else {
                                Text(".")
                                    .foregroundColor(.black)
                                    .fontWeight(.bold)
                            }
                            
                            BirthdayTextField(placeHolder: "월", text: $month)
                            
                            if !(maleSelected || femaleSelected) || year.isEmpty || month.isEmpty || day.isEmpty {
                                Text(".")
                                    .foregroundColor(Color.neutral300)
                                    .fontWeight(.bold)
                            } else {
                                Text(".")
                                    .foregroundColor(.black)
                                    .fontWeight(.bold)
                            }
                            
                            BirthdayTextField(placeHolder: "일", text: $day)
                        }
                    }
                }
                
                Spacer()
                
                VStack {
                    if !(maleSelected || femaleSelected) || year.isEmpty || month.isEmpty || day.isEmpty {
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
                HeightWeightInputView()
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .tint(.black)
                    }
                }
            }
            // 키보드가 화면 덮게 만드는 코드 -> 스크롤뷰가 있어야 작동
            .ignoresSafeArea(.keyboard, edges: .bottom)
        }
    }
}

struct BirthdayTextField: View {
    var placeHolder: String
    @Binding var text: String
    
    var body: some View {
        VStack(spacing: 0) {
            TextField(placeHolder, text: $text)
                .font(.bold, size: 18, lineHeight: 24)
                .multilineTextAlignment(text.isEmpty ? .trailing : .center)
                .tint(Color.primary500)
                .keyboardType(.numberPad)
                .frame(height: 40)
            
            Rectangle()
                .frame(height: 1)
                .foregroundColor(text.isEmpty ? Color.neutral300 : Color.primary500)
        }
    }
}


struct GenderBirthdayInputView_Previews: PreviewProvider {
    static var previews: some View {
        GenderBirthdayInputView()
    }
}
