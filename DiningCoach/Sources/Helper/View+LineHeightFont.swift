//
//  View+LineHeightFont.swift
//  DiningCoach
//
//  Created by chamsol kim on 2023/06/09.
//

import SwiftUI

extension View {
    
    func font(_ weight: Font.PretendardWeight, size: CGFloat, lineHeight: CGFloat) -> some View {
        let uiFont = Font.pretendardUIFont(weight: weight, size: size)
        return font(Font(uiFont)).lineSpacing(lineHeight - uiFont.lineHeight)
    }
}
