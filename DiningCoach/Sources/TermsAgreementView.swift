//
//  TermsAgreementView.swift
//  DiningCoach
//
//  Created by 심현석 on 2023/06/30.
//

import SwiftUI

class SigninNavigation: ObservableObject {
    @Published var showSheet = false
}

struct TempHomeView: View {
    @StateObject private var navigation = SigninNavigation()
    
    var body: some View {
        NavigationStack {
            Button {
                navigation.showSheet = true
            } label: {
                Text("Go sheet")
            }
            .sheet(isPresented: $navigation.showSheet) {
                TermsAgreementView()
            }
            .environmentObject(navigation)
        }
    }
}

struct TermsAgreementView: View {
    @EnvironmentObject var navigation: SigninNavigation
    @State private var isPresented: Bool = false
    @State private var isCompleted: Bool = false
    
    @State private var isSelectedAll: Bool = false
    @State private var selectedStates: [Bool] = [false, false, false, false, false]
    
    var types: Array<TermsType> = [.mandatory, .mandatory, .mandatory, .mandatory, .optional]
    var titles = ["서비스 이용약관", "개인정보 수집 및 이용 동의", "민감정보 수집 및 이용 동의", "만 14세 이상이에요", "마케팅 정보 수신 동의"]
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    Spacer()
                    HStack {
                        Text("서비스 이용을 위해\n약관을 확인해 주세요")
                            .font(.pretendard(weight: .bold, size: 22))
                            .lineSpacing(6)
                        Spacer()
                    }
                }
                .frame(height: 80)
                
                Spacer()
                    .frame(height: 48)
                
                VStack(alignment: .leading) {
                    Button {
                        isSelectedAll.toggle()
                        selectedStates = Array(repeating: isSelectedAll, count: selectedStates.count)
                    } label: {
                        HStack(spacing: 0) {
                            if isSelectedAll {
                                Image(systemName: "checkmark.circle.fill")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(.primary500)
                            } else {
                                Image(systemName: "checkmark.circle.fill")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(.neutral200)
                            }
                            
                            Text("약관 전체 동의")
                                .font(.medium, size: 18, lineHeight: 24)
                                .padding(8)
                                .foregroundColor(.black)
                        }
                    }
                    
                    Spacer()
                        .frame(height: 25)
                    
                    ForEach(0 ..< selectedStates.count) { index in
                        DetailTermsView(type: types[index], title: titles[index], isSelected: $selectedStates[index], isSelectedAll: $isSelectedAll, selectedStates: $selectedStates)
                            .onChange(of: selectedStates) { _ in
                                isCompleted = selectedStates.prefix(4).allSatisfy { $0 }
                            }
                    }
                }
                
                Spacer()
                
                DCButton("다음", style: .primary) {
                    // 다음페이지
                    isPresented = true
                }
                .padding(.vertical, 16)
                .disabled(!isCompleted)
            }
            .padding(.horizontal, 16)
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
            .navigationDestination(isPresented: $isPresented) {
                NicknameInputView()
            }
        }
    }
}

enum TermsType {
    case mandatory
    case optional
}

struct DetailTermsView: View {
    var type: TermsType
    var title: String
    
    @Binding var isSelected: Bool
    @Binding var isSelectedAll: Bool
    @Binding var selectedStates: [Bool]
    
    var body: some View {
        HStack {
            Button {
                isSelected.toggle()
                
                if !isSelected {
                    isSelectedAll = false
                } else if !(selectedStates.contains { !$0 }) {
                    isSelectedAll = true
                }
            } label: {
                HStack {
                    if isSelected {
                        Image(systemName: "checkmark")
                            .frame(width: 24, height: 24)
                            .foregroundColor(.primary500)
                    } else {
                        Image(systemName: "checkmark")
                            .frame(width: 24, height: 24)
                            .foregroundColor(.neutral200)
                    }
                    
                    Spacer()
                        .frame(width: 8)
                    
                    if type == .mandatory {
                        Text("[필수]")
                            .font(.medium, size: 16, lineHeight: 24)
                    } else {
                        Text("(선택)")
                            .font(.medium, size: 16, lineHeight: 24)
                    }
                    
                    Spacer()
                        .frame(width: 3)
                    
                    Text(title)
                        .font(.medium, size: 16, lineHeight: 24)
                }
                .padding(.vertical, 8)
                .foregroundColor(.black)
            }
            
            Spacer()
            
            NavigationLink {
                // 약관 보기
            } label: {
                Text("보기")
                    .font(.bold, size: 11, lineHeight: 16)
                    .foregroundColor(.neutral300)
            }
        }
    }
}

struct TermsAgreementView_Previews: PreviewProvider {
    static var previews: some View {
        TempHomeView()
    }
}
