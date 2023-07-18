//
//  MainView.swift
//  DiningCoach
//
//  Created by SHSEO on 2023/06/22.
//

import SwiftUI
import AVFoundation

struct MainView: View {
    @State var selectedTab: TabCategory = .diary
    @State var searchStore = SearchStore()
    @State var isCameraAuthorized = false
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                Color.white
                
                VStack {
                    switch selectedTab {
                    case .diary:
                        Text("diary view")
                    case .search:
                        SearchView(searchStore: searchStore)
                    case .camera:
                        Text("camera view")
                    case .community:
                        Text("community view")
                    case .shop:
                        Text("shop view")
                    }
                    MainTabView(selectedTab: $selectedTab)
                }
            }
            .preferredColorScheme(.light)
            .ignoresSafeArea(.keyboard)
        }
    }
}

enum TabCategory: CaseIterable {
    case diary
    case search
    case camera
    case community
    case shop
    
    var imageName: String {
        switch self {
        case .diary: return "diary"
        case .search: return "Search"
        case .camera: return ""
        case .community: return "Community"
        case .shop: return "Shop"
        }
    }
    
    var title: String {
        switch self {
        case .diary: return "식단 기록"
        case .search: return "검색"
        case .camera: return ""
        case .community: return "커뮤니티"
        case .shop: return "쇼핑몰"
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
