//
//  Color+Neutral.swift
//  DiningCoach
//
//  Created by chamsol kim on 2023/06/14.
//

import SwiftUI

extension Color {
    
    static let neutral50 = Color("neutral-050")
    
    static let neutral100 = Color("neutral-100")
    
    static let neutral200 = Color("neutral-200")
    
    static let neutral300 = Color("neutral-300")
    
    static let neutral400 = Color("neutral-400")
    
    static let neutral500 = Color("neutral-500")
    
    static let neutral600 = Color("neutral-600")
    
    static let neutral700 = Color("neutral-700")
    
    static let neutral800 = Color("neutral-800")
    
    static let neutral900 = Color("neutral-900")
}


// MARK: - Test

fileprivate struct NeutralColorTestView: View {
    
    private let colors = [
        Color.neutral50,
        Color.neutral100,
        Color.neutral200,
        Color.neutral300,
        Color.neutral400,
        Color.neutral500,
        Color.neutral600,
        Color.neutral700,
        Color.neutral800,
        Color.neutral900,
    ]
    
    var body: some View {
        VStack {
            ForEach(colors, id: \.self) { color in
                Rectangle()
                    .fill(color)
                    .frame(width: 200, height: 48)
                    .border(.black)
            }
        }
    }
}

struct NeutralColorTestView_Previews: PreviewProvider {
    static var previews: some View {
        NeutralColorTestView()
    }
}
