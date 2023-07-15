//
//  DietRecordView.swift
//  DiningCoach
//
//  Created by 심현석 on 2023/07/11.
//

import SwiftUI

struct DietRecordView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView(showsIndicators: false) {
                    VStack {
                        DietRecordCard()
                            .padding(.top, 161)
                        DietStatistics()
                        DietEvaluation()
                    }
                }
                
                DietRecordCalendar()
            }
        }
    }
}

struct DietRecordView_Preview: PreviewProvider {
    static var previews: some View {
        DietRecordView()
    }
}
