//
//  ForgotPasswordView.swift
//  DiningCoach
//
//  Created by DYS on 2023/06/26.
//

import SwiftUI

struct ForgotPasswordView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var isCompleted = false

    @State private var emailAddress: String = ""

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
                    VStack {
                        Spacer().frame(height: 16)

                        VStack(alignment: .leading, spacing: 0) {
                            Text("비밀번호를 잊으셨나요?")
                                .font(.bold, size: 22, lineHeight: 28)
                                .frame(height: 28)

                            Spacer()
                                .frame(height: 8)

                            Text("가입하신 이메일 주소를 입력하면 비밀번호를 재설정할 수 있는 인증번호를 이메일로 보내드릴게요.")
                                .font(.regular, size: 16, lineHeight: 24)
                                .tint(Color.neutral600)
                                .frame(height: 48)


                        }

                        Spacer()
                            .frame(height: 40)

                        VStack(alignment: .leading, spacing: 0) {
                                BasicTextField(placeHolder: "가입하신 이메일을 입력해 주세요.", text: $emailAddress)

                                if  emailAddress.isEmpty {
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
                        if emailAddress.isEmpty {
                            DCButton("인증번호 받기", style: .primary) { }
                                .disabled(true)
                        } else {
                            DCButton("인증번호 받기", style: .primary) {
                                isCompleted = true
                            }
                        }
                    }
                    .padding(.vertical, 16)
                }
                .padding(.horizontal, 16)
                .navigationDestination(isPresented: $isCompleted) {
                    GetCertificationNumberView()
                }
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: backButton)
            }
        }
    }

    struct BasicTextField: View {
        var placeHolder: String
        @Binding var text: String

        var body: some View {
            VStack(spacing: 0) {
                TextField(placeHolder, text: $text)
                    .font(.medium, size: 16, lineHeight: 24)
                    .multilineTextAlignment(text.isEmpty ? .leading : .leading)
                    .tint(Color.primary500)
                    .keyboardType(.emailAddress)
                    .frame(height: 24)

                Spacer().frame(height: 16)

                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(text.isEmpty ? Color.neutral300 : Color.primary500)
            }
        }
    }


    struct ForgotPasswordView_Previews: PreviewProvider {
        static var previews: some View {
            ForgotPasswordView()
        }
    }

}

