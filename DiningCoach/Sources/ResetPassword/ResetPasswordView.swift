//
//  ResetPasswordView.swift
//  DiningCoach
//
//  Created by DYS on 2023/06/26.
//

import SwiftUI

struct ResetPasswordView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @State private var isCompleted = false
    @State private var newPassword: String = ""
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
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 0) {
                        Spacer().frame(height: 16)
                        
                        Text("비밀번호 재설정")
                            .font(.bold, size: 22, lineHeight: 28)
                            .frame(height: 28)

                        Spacer()
                            .frame(height: 8)

                        Text("비밀번호를 다시 설정해 주세요.")
                            .font(.regular, size: 16, lineHeight: 24)
                            .tint(Color.neutral600)
                            .frame(height: 48)

                        ResetPasswordTextField(placeHolder: "비밀번호를 입력해주세요", newPassword: $newPassword)

                        Spacer()
                            .frame(height: 24)

                        ConfirmPasswordTextField(placeHolder: "비밀번호를 다시 입력해주세요", confirmPassword: $confirmPassword)

                        Spacer()
                            .foregroundColor(.pink)
                            .frame(height: 32)

                        
                        VStack {
                            if !validatePassword {
                                DCButton("재설정", style: .primary) { print("dd") }
                                    .disabled(true)
                            } else {
                                DCButton("재설정", style: .primary) {
                                    isCompleted = true
                                }
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
            .navigationDestination(isPresented: $isCompleted) {
                FinishResetPasswordView()
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: backButton)
        }
    }
}

struct ResetPasswordTextField: View {
    var placeHolder: String
    @Binding var newPassword: String

    var body: some View {
        VStack(spacing: 0) {

            TextField(placeHolder, text: $newPassword)
                .font(.medium, size: 16, lineHeight: 24)
                .multilineTextAlignment(newPassword.isEmpty ? .leading : .leading)
                .tint(Color.primary500)
                .keyboardType(.emailAddress)
                .frame(height: 24)


            Spacer().frame(height: 16)

            Rectangle()
                .frame(height: 1)
                .foregroundColor(newPassword.isEmpty ? Color.neutral300 : Color.primary500)

            Spacer().frame(height: 8)

            HStack(spacing: 16) {
                Label("영어 소문자", systemImage: "checkmark")
                    .font(.extraLight, size: 11, lineHeight: 16)
                    .foregroundColor(Validation.containsLowercase(newPassword) ? Color.primary500 : Color.neutral400)
                Label("영문 대문자, 숫자, 특수문자 중 2개", systemImage: "checkmark")
                    .font(.extraLight, size: 11, lineHeight: 16)
                    .foregroundColor(Validation.containsTwoTypes(newPassword) ? Color.primary500 : Color.neutral400)
                Label("8~16자", systemImage: "checkmark")
                    .font(.extraLight, size: 11, lineHeight: 16)
                    .foregroundColor(Validation.isPasswordLength(newPassword) ? Color.primary500 : Color.neutral400)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct ConfirmPasswordTextField: View {
    var placeHolder: String
    @Binding var confirmPassword: String

    var body: some View {
        VStack(spacing: 0) {

            TextField(placeHolder, text: $confirmPassword)
                .font(.medium, size: 16, lineHeight: 24)
                .multilineTextAlignment(confirmPassword.isEmpty ? .leading : .leading)
                .tint(Color.primary500)
                .keyboardType(.emailAddress)
                .frame(height: 24)


            Spacer().frame(height: 16)

            Rectangle()
                .frame(height: 1)
                .foregroundColor(confirmPassword.isEmpty ? Color.neutral300 : Color.primary500)

            Spacer().frame(height: 8)

            //- To do: 비밀번호 일치
            if !confirmPassword.isEmpty {
                Label("비밀번호 일치", systemImage: "checkmark")
                        .font(.extraLight, size: 11, lineHeight: 16)
                    .foregroundColor(Validation.isPasswordSame(confirmPassword, confirmPassword) ? Color.primary500 : Color.neutral400)
                    .frame(maxWidth: .infinity, alignment: .leading)
            } else {
                Label("비밀번호 일치", systemImage: "checkmark")
                        .font(.extraLight, size: 11, lineHeight: 16)
                    .foregroundColor( Color.neutral400)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }

        }
    }
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView()
    }
}
