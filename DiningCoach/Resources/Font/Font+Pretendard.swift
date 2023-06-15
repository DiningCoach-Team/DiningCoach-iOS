//
//  Font+Pretendard.swift
//  DiningCoach
//
//  Created by chamsol kim on 2023/06/06.
//

import UIKit
import SwiftUI

extension Font {
    
    enum PretendardWeight: String {
        case extraBold
        case bold
        case semiBold
        case medium
        case regular
        case extraLight
        case light
        case black
        case thin
        
        var name: String {
            rawValue.capitalized
        }
        
        var fontName: String {
            "Pretendard-\(name)"
        }
    }
    
    static func pretendard(weight: PretendardWeight, size: CGFloat) -> Font {
        .custom(weight.fontName, fixedSize: size)
    }
    
    static func pretendardUIFont(weight: PretendardWeight, size: CGFloat) -> UIFont {
        UIFont(name: weight.fontName, size: size) ?? .systemFont(ofSize: size)
    }
}


// MARK: - Test

fileprivate struct FontTestView: View {
    var body: some View {
        VStack(spacing: 10) {
            Text("Pretendard-ExtraBold")
                .font(.pretendard(weight: .extraBold, size: 20))
            Text("Pretendard-SemiBold")
                .font(.pretendard(weight: .semiBold, size: 20))
            Text("Pretendard-Bold")
                .font(.pretendard(weight: .bold, size: 20))
            Text("Pretendard-Medium")
                .font(.pretendard(weight: .medium, size: 20))
            Text("Pretendard-Regular")
                .font(.pretendard(weight: .regular, size: 20))
            Text("Pretendard-ExtraLight")
                .font(.pretendard(weight: .extraLight, size: 20))
            Text("Pretendard-Light")
                .font(.pretendard(weight: .light, size: 20))
            Text("Pretendard-Black")
                .font(.pretendard(weight: .black, size: 20))
            Text("Pretendard-Thin")
                .font(.pretendard(weight: .thin, size: 20))
        }
    }
}

struct FontTestView_Previews: PreviewProvider {
    static var previews: some View {
        FontTestView()
    }
}
