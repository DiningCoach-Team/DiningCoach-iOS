//
//  DietRecordDetailImageList.swift
//  DiningCoach
//
//  Created by 심현석 on 2023/07/14.
//

import SwiftUI

struct DietRecordDetailImageList: View {
    @EnvironmentObject var store: DietRecordStore
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(0...2, id: \.self) { record in
                    VStack(spacing: 8) {
                        Text("사진 추가")
                            .font(.pretendard(weight: .semiBold, size: 14))
                        Image(systemName: "plus")
                            .frame(width: 24, height: 24)
                    }
                    .foregroundColor(.neutral300)
                    .frame(width: 150, height: 150)
                    .background(Color.neutral50)
                    .cornerRadius(12)
                }
            }
            .padding(.horizontal, 16)
        }
        .padding(.vertical, 8)
    }
}
