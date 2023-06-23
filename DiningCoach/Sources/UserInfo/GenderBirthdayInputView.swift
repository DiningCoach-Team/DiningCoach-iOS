//
//  GenderBirthdayInputView.swift
//  DiningCoach
//
//  Created by 심현석 on 2023/06/23.
//

import SwiftUI

struct GenderBirthdayInputView: View {
    @State private var manSelected = false
    @State private var womanSelected = false
    
    @State private var year: String = ""
    @State private var month: String = ""
    @State private var day: String = ""
    
    var body: some View {
        VStack {
            HStack {
                Text("성별은 어떻게 되시나요?")
                    .font(.headline)
                    .fontWeight(.bold)
                
                Spacer()
            }
            
            HStack {
                Button {
                    manSelected = true
                    womanSelected = false
                } label: {
                    Image(systemName: "heart")
                        .frame(width: 164, height: 164)
                        .background(.gray)
                        .tint(manSelected ? Color(uiColor: .systemMint) : Color.gray)
                }
                
                Spacer()
                
                Button {
                    manSelected = false
                    womanSelected = true
                } label: {
                    Image(systemName: "heart")
                        .frame(width: 164, height: 164)
                        .background(.gray)
                        .tint(womanSelected ? Color(uiColor: .systemMint) : Color.gray)
                }
            }
            
            Spacer()
                .frame(height: 50)
            
            HStack {
                Text("생년월일을 알려주세요")
                    .font(.headline)
                    .fontWeight(.bold)
                
                Spacer()
            }
            
            HStack {
                DCTextField(placeHolder: "년", text: $year)
                Text(".")
                DCTextField(placeHolder: "월", text: $month)
                Text(".")
                DCTextField(placeHolder: "일", text: $day)
            }
            
            Spacer()
            
            DCButton("다음", style: .primary) {
                // action
            }
        }
        .padding()
    }
}

struct GenderBirthdayInputView_Previews: PreviewProvider {
    static var previews: some View {
        GenderBirthdayInputView()
    }
}
