//
//  MainTabView.swift
//  DiningCoach
//
//  Created by SHSEO on 2023/06/22.
//

import SwiftUI

struct MainTabView: View {
    @Binding var selectedTab: TabCategory
    
    var body: some View {
        HStack() {
            ForEach(TabCategory.allCases, id: \.self) { tabCategory in
                makeTabButton(tabCategory: tabCategory)
            }
        }
        .frame(height: 64)
        .padding(.horizontal, 16)
        .background(
            Rectangle()
                .fill(.white)
                .background(.clear)
                .ignoresSafeArea()
                .cornerRadius(24, corners: [.topLeft, .topRight])
                .shadow(color: .black.opacity(0.05), radius: 3, x: 0, y: -5)
        )
    }
    
    @ViewBuilder
    private func makeTabButton(tabCategory: TabCategory) -> some View {
        if tabCategory == .camera {
            Circle()
                .strokeBorder(
                    AngularGradient(
                        colors:
                            [Color(hex: "C7E8CC"), Color(hex: "A3E9FF"), Color(hex: "4EDF77"), Color(hex: "BED8FF"), Color(hex: "75DBE1"), Color(hex: "75DBE1")],
                        center: .center
                    ),
                    lineWidth: 6)
                .background(
                    Circle()
                        .foregroundColor(Color.white)
                )
                .frame(width: 56, height: 56)
                .offset(y: -19)
                .onTapGesture {
                    selectedTab = tabCategory
                }
        } else {
            Button(action: {
                selectedTab = tabCategory
            }, label: {
                VStack(alignment: .center, spacing: 4) {
                    Image(tabCategory.imageName)
                        .renderingMode(.template)
                        .foregroundColor(selectedTab == tabCategory ? .primary500 : .neutral500)
                    Text(tabCategory.title)
                        .font(.semiBold, size: 11, lineHeight: 16)
                        .foregroundColor(selectedTab == tabCategory ? .primary500 : .neutral500)
                }
                .frame(maxWidth: .infinity)
                
            })
            .buttonStyle(.plain)
        }
        
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView(selectedTab: .constant(.diary))
    }
}
