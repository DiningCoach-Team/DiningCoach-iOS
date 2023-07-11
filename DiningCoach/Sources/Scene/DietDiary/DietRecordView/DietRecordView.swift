//
//  DietRecordView.swift
//  DiningCoach
//
//  Created by 심현석 on 2023/07/11.
//

import SwiftUI

struct DietRecordView: View {
    @EnvironmentObject private var dietDiaryView: DietDiaryStore
    
    var body: some View {
        ScrollView {
            VStack {
                DietRecordCard()
                    .padding(.top, 161)
            }
            .padding(.horizontal, 16)
        }
    }
}

struct DietRecordView_Preview: PreviewProvider {
    static var previews: some View {
        DietRecordView()
    }
}
