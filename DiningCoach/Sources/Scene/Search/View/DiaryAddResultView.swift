//
//  DiaryAddResultView.swift
//  DiningCoach
//
//  Created by SHSEO on 2023/07/12.
//

import SwiftUI
import Kingfisher

struct DiaryAddResultView: View {
    @Environment(\.dismiss) var dismiss
    let food: FoodProtocol?
    
    @Binding var isShowingSheet: Bool
    var body: some View {
        ScrollView {
            VStack {
                header
                main
                    .padding(.top, 8)
                DCButton("식단 일기 보러 가기", style: .primary, action: {
                    isShowingSheet = false
                })
                .padding(.top, 40)
                .padding([.horizontal, .bottom], 16)
            }
            .frame(maxWidth: .infinity)
            .background(.white)
        }
        
    }
    
    var header: some View {
        HStack {
            Button(action: {
                dismiss()
            }, label: {
                Image("arrow_left")
            })
            Spacer()
            Button(action: {
                isShowingSheet = false
            }, label: {
                Image("xmark_large")
            })
        }
        .frame(height: 48)
        
        .padding(.horizontal, 16)
    }
    
    var main: some View {
        VStack(alignment: .leading) {
            Text("식단을 추가하였습니다!")
                .font(.bold, size: 22, lineHeight: 28)
            VStack(alignment: .leading, spacing: 16) {
                DiaryInfoRow(label: "식품", value: food?.name ?? "")
                DiaryInfoRow(label: "날짜", value: "2023년 07월 12일 (수)")
                DiaryInfoRow(label: "시간", value: "점심", image: "lunch")
            }
            .padding(.top, 24)
            KFImage(URL(string: food?.foodImage ?? ""))
                .placeholder({
                    ProgressView()
                })
                .fade(duration: 0.2)
                .resizable()
                .frame(height: 272)
                .aspectRatio(contentMode: .fill)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.top, 32)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 16)
        
    }
    
}

struct DiaryInfoRow: View {
    var label: String
    var value: String
    var image: String?
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Text(label)
                .font(.medium, size: 16, lineHeight: 24)
                .foregroundColor(.neutral400)
            HStack(alignment: .center, spacing: 4) {
                Text(value)
                    .font(.semiBold, size: 16, lineHeight: 24)
                    .foregroundColor(.neutral900)
                    .padding(.leading, 44)
                if let image = image {
                    Image(image)
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 19, height: 19)
                        .foregroundColor(.neutral900)
                        
                }
            }
        }
    }
}

struct DiaryAddResultView_Previews: PreviewProvider {
    static var previews: some View {
        DiaryAddResultView(food: nil, isShowingSheet: .constant(false))
    }
}
