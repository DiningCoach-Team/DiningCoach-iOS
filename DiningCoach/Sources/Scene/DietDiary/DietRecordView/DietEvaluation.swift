//
//  DietEvaluation.swift
//  DiningCoach
//
//  Created by 심현석 on 2023/07/12.
//

import SwiftUI

struct DietEvaluation: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("식단 평가")
                .font(.pretendard(weight: .semiBold, size: 16))
                .foregroundColor(.neutral900)
            
            HStack(spacing: 16) {
                SmallDietEvaluation(title: "식습관")
                SmallDietEvaluation(title: "질병")
                SmallDietEvaluation(title: "알레르기")
            }
            
            LargeDietEvaluation()
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 16)
        .frame(height: 290)
    }
}

struct SmallDietEvaluation: View {
    var title: String
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text(title)
                        .font(.pretendard(weight: .semiBold, size: 14))
                        .foregroundColor(.neutral900)
                    Spacer()
                }
                
                // TODO: evaluation
                
                Spacer()
            }
            .padding(16)
            .background(.white)
            .frame(height: 103)
            .cornerRadius(12)
            .shadow(color: Color(white: 0, opacity: 0.10), radius: 10)
        }
    }
}

struct LargeDietEvaluation: View {
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text("영양소")
                        .font(.pretendard(weight: .semiBold, size: 14))
                        .foregroundColor(.neutral900)
                    Spacer()
                }
                
                // TODO: evaluation
                Spacer()
            }
            .padding(16)
            .background(.white)
            .frame(height: 103)
            .cornerRadius(12)
            .shadow(color: Color(white: 0, opacity: 0.10), radius: 10)
        }
    }
}

struct DietEvaluation_Preview: PreviewProvider {
    static var previews: some View {
        DietEvaluation()
    }
}
