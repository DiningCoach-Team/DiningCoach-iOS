//
//  NicknameInputView.swift
//  DiningCoach
//
//  Created by 심현석 on 2023/06/30.
//

import SwiftUI

struct NicknameInputView: View {
    @EnvironmentObject var navigation: SigninNavigation
    @State private var isPresented: Bool = false
    @State private var isCompleted: Bool = false
    
    @State var nickname: String = ""
    
    @State var isCombinationValid: Bool = false
    @State var isLengthValid: Bool = false
    
    var body: some View {
        VStack {
            VStack {
                Spacer()
                HStack {
                    Text("가입이 거의 끝나가요!\n어떻게 불러드리면 될까요?")
                        .font(.pretendard(weight: .bold, size: 22))
                        .lineSpacing(6)
                    Spacer()
                }
            }
            .frame(height: 80)
            
            Spacer()
                .frame(height: 120)
            
            VStack(alignment: .leading, spacing: 0) {
                TextField("닉네임을 입력해 주세요", text: $nickname)
                    .font(.pretendard(weight: .semiBold, size: 16))
                    .tint(Color.primary500)
                    .frame(height: 48)
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(nickname.isEmpty ? Color.neutral300 : Color.primary500)
                
                Spacer()
                    .frame(height: 8)
                
                HStack(spacing: 16) {
                    HStack(spacing: 0) {
                        Text("한글, 영문, 숫자 조합")
                        
                        Image(systemName: "checkmark")
                            .frame(width: 16, height: 16)
                    }
                    .foregroundColor(isCombinationValid ? .primary500 : .neutral300)
                    
                    HStack(spacing: 0) {
                        Text("16자 이내")
                        
                        Image(systemName: "checkmark")
                            .frame(width: 16, height: 16)
                    }
                    .foregroundColor(isLengthValid ? .primary500 : .neutral300)

                    HStack(spacing: 0) {
                        Text("단, 한글은 2글자로 인식")
                            .foregroundColor(.primary500)
                    }
                }
                .font(.pretendard(weight: .semiBold, size: 11))
            }
            
            Spacer()
            
            DCButton("완료", style: .primary) {
                // 다음페이지
                isPresented = true
            }
            .padding(.vertical, 16)
            .disabled(!isCompleted)
        }
        .padding(.horizontal, 16)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    navigation.showSheet = false
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(.black)
                }
            }
        }
        .onChange(of: nickname) { newValue in
            isCombinationValid = combinationValid(nickname: nickname)
            isLengthValid = lengthValid(nickname: nickname)
            
            isCompleted = isLengthValid && isCombinationValid
        }
        .navigationDestination(isPresented: $isPresented) {
            SigninCompleteView(nickname: nickname)
        }
    }
    
    func combinationValid(nickname: String) -> Bool {
        let kor = nickname.range(of: "[가-힣]+", options: .regularExpression) != nil
        let eng = nickname.range(of: "[a-zA-Z]+", options: .regularExpression) != nil
        let num = nickname.range(of: "[0-9]+", options: .regularExpression) != nil
        
        let trueCount = [kor, eng, num].filter { $0 }.count
        let isCombinationValid = trueCount == 2 || trueCount == 3
        
        return isCombinationValid
    }
    
    func lengthValid(nickname: String) -> Bool {
        let filter = nickname.range(of: "[가-힣a-zA-Z0-9]+", options: .regularExpression) != nil
        let korCount = extractKorCount(text: nickname)
        let engnumCount = extractEngNumCount(from: nickname)
        
        if filter && (korCount + engnumCount >= 2 && korCount + engnumCount <= 16) {
            return true
        }
        return false
    }
    
    func extractKorCount(text: String) -> Int {
        let regex = try? NSRegularExpression(pattern: "[가-힣]+", options: [])
        if let match = regex?.firstMatch(in: text, options: [], range: NSRange(text.startIndex..., in: text)) {
            return match.range.length * 2
        }
        return 0
    }
    
    func extractEngNumCount(from text: String) -> Int {
        let regex = try? NSRegularExpression(pattern: "[a-zA-Z0-9]+", options: [])
        if let match = regex?.firstMatch(in: text, options: [], range: NSRange(text.startIndex..., in: text)) {
            return match.range.length
        }
        return 0
    }
}

struct NicknameInputView_Previews: PreviewProvider {
    static var previews: some View {
        NicknameInputView()
    }
}
