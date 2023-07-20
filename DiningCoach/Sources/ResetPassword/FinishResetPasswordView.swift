//
//  FinishResetPasswordView.swift
//  DiningCoach
//
//  Created by DYS on 2023/06/27.
//

import SwiftUI

struct FinishResetPasswordView: View {
    @State private var isCompleted = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var backButton : some View {
        Button(
            action: {
                print("back")
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.backward")
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(Color.neutral900)
            }
    }

    var dismissButton : some View {
        Button(
            action: {
                print("to login")
                //로그인화면으로 가기
            }) {
                Image(systemName: "xmark")
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(Color.neutral900)
            }
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                VStack(spacing:0){
                    Spacer().frame(height: 28)

                    Text("비밀번호 설정이 완료되었습니다!")
                        .font(.bold, size: 22, lineHeight: 28)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Spacer()
                        .frame(height: 15)

                    Text("서비스를 계속 이용하시려면 변경한 비밀번호로\n다시 로그인 해주세요.")
                        .font(.regular, size: 16, lineHeight: 24)
                        .tint(Color.neutral600)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Spacer()

                    DCButton("로그인", style: .primary) { }

                }
                .padding(.horizontal, 16)
            }
            .navigationDestination(isPresented: $isCompleted) {
                //go to login main page
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: backButton,trailing: dismissButton)
        }

    }
}

struct FinishResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        FinishResetPasswordView()
    }
}
