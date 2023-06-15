//
//  Color+Primary.swift
//  DiningCoach
//
//  Created by chamsol kim on 2023/06/09.
//

import SwiftUI

extension Color {
    
    static let primary50 = Color("primary-050")
    
    static let primary100 = Color("primary-100")
    
    static let primary200 = Color("primary-200")
    
    static let primary300 = Color("primary-300")
    
    static let primary400 = Color("primary-400")
    
    static let primary500 = Color("primary-500")
    
    static let primary600 = Color("primary-600")
    
    static let primary700 = Color("primary-700")
    
    static let primary800 = Color("primary-800")
    
    static let primary900 = Color("primary-900")
}


// MARK: - Test

fileprivate struct PrimaryColorTestView: View {
    
    private let colors = [
        Color.primary50,
        Color.primary100,
        Color.primary200,
        Color.primary300,
        Color.primary400,
        Color.primary500,
        Color.primary600,
        Color.primary700,
        Color.primary800,
        Color.primary900,
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

struct PrimaryColorTestView_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryColorTestView()
    }
}
