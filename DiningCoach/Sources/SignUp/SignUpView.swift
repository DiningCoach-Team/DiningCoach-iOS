//
//  SignUpView.swift
//  DiningCoach
//
//  Created by DYS on 2023/07/05.
//

import SwiftUI

struct SignUpView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @State private var isCompleted = false
    @State private var emailAddress: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    private var validatePassword: Bool = true


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
                    VStack(spacing: 0) {

                        Spacer().frame(height: 16)

                        Text("아이디")
                            .font(.bold, size: 18, lineHeight: 24)
                            .frame(height: 24)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        Spacer().frame(height: 13)

                        HStack(spacing: 2) {
                            BasicTextField(placeHolder: "이메일", text: $emailAddress)
                            Text("@")
                                .font(.bold, size: 16, lineHeight: 24)
                            TextFieldWithButton(placeHolder: "직접입력", text: $emailAddress)
                        }

                        Spacer().frame(height: 40)

                        Text("비밀번호 재설정")
                            .font(.bold, size: 18, lineHeight: 24)
                            .frame(height: 24)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        Spacer()
                            .frame(height: 8)

                        ResetPasswordTextField(placeHolder: "비밀번호를 입력해주세요", newPassword: $password)

                        Spacer()
                            .frame(height: 24)

                        ConfirmPasswordTextField(placeHolder: "비밀번호를 다시 입력해주세요", confirmPassword: $confirmPassword)
                }

                Spacer()

                DCButton("가입완료", style: .primary) {}
            }
            .padding(.horizontal, 16)
            .navigationDestination(isPresented: $isCompleted) {
                //go to main login page
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: backButton)
            .navigationBarTitle("회원가입", displayMode: .inline)
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

            Spacer().frame(height: 5)

            Rectangle()
                .frame(height: 1)
                .foregroundColor(text.isEmpty ? Color.neutral300 : Color.primary500)
        }
    }
}

struct TextFieldWithButton: View {
    var placeHolder: String
    @Binding var text: String
    @State var showBottomSheet = false

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0){
                TextField(placeHolder, text: $text)
                    .font(.medium, size: 16, lineHeight: 24)
                    .multilineTextAlignment(text.isEmpty ? .leading : .leading)
                    .tint(Color.primary500)
                    .keyboardType(.emailAddress)
                    .frame(height: 24)

                Button(action: {
                    showBottomSheet.toggle()
                }, label: {
                    Image(systemName: "chevron.down")
                        .foregroundColor(.neutral400)
                })
            }

            Spacer().frame(height: 5)

            Rectangle()
                .frame(height: 1)
                .foregroundColor(text.isEmpty ? Color.neutral300 : Color.primary500)

        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

