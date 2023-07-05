//
//  GetCertificationNumberView.swift
//  DiningCoach
//
//  Created by DYS on 2023/06/26.
//

import SwiftUI

struct GetCertificationNumberView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var isCompleted = false

    @State private var certificationNumber: String = ""

    var backButton : some View {
        Button(
            action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.backward") 
                .aspectRatio(contentMode: .fit)
                .foregroundColor(Color.black)
            }
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {

                ScrollView(showsIndicators: false) {
                    VStack { //-1
                        Spacer().frame(height: 16)

                        VStack(alignment: .leading, spacing: 0) {
                            Text("인증번호를 입력해 주세요")
                                .font(.bold, size: 22, lineHeight: 28)
                                .frame(height: 28)

                            Spacer()
                                .frame(height: 8)

                            Text("가입하신 이메일 주소로 보내드린 인증번호를 제한 시간 내에 입력해 주세요.")
                                .font(.regular, size: 16, lineHeight: 24)
                                .tint(Color.neutral600)
                                .frame(height: 48)


                        }

                        Spacer()
                            .frame(height: 40)

                        VStack(alignment: .leading, spacing: 0) {
                            BasicTextFieldWithTimer(placeHolder: "인증번호를 입력해 주세요", text: $certificationNumber)

                                if  certificationNumber.isEmpty {
                                    Text(".")
                                        .foregroundColor(Color.neutral300)
                                        .fontWeight(.bold)
                                } else {
                                    Text(".")
                                        .foregroundColor(.black)
                                        .fontWeight(.bold)
                                }
                        }
                    } 

                    VStack {
                        if certificationNumber.isEmpty {
                            DCButton("인증", style: .primary) { }
                                .disabled(true)
                        } else {
                            DCButton("인증", style: .primary) {
                                isCompleted = true
                            }
                        }
                    }
                    .padding(.vertical, 16)
                }
                .padding(.horizontal, 16)
                .navigationDestination(isPresented: $isCompleted) {
                    ResetPasswordView()
                }
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: backButton)
            }
        }
    }

    struct BasicTextFieldWithTimer: View {
        var placeHolder: String
        @Binding var text: String

        var body: some View {
            VStack(spacing: 0) {

                HStack {
                    TextField(placeHolder, text: $text)
                        .font(.medium, size: 16, lineHeight: 24)
                        .multilineTextAlignment(text.isEmpty ? .leading : .leading)
                        .tint(Color.primary500)
                        .keyboardType(.numberPad)
                        .textContentType(.oneTimeCode)
                        .frame(height: 24)

                    Label("03:00", systemImage: "")
                        .labelStyle(.titleOnly)
                        .tint(Color.neutral400)
                        .frame(height: 24)
                }

                Spacer().frame(height: 16)

                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(text.isEmpty ? Color.neutral300 : Color.primary500)
            }
        }
    }


}

struct GetCertificationNumberView_Previews: PreviewProvider {
    static var previews: some View {
        GetCertificationNumberView()
    }
}
