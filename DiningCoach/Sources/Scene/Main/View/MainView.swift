//
//  MainView.swift
//  DiningCoach
//
//  Created by SHSEO on 2023/06/22.
//

import SwiftUI

enum TabCategory: CaseIterable {
    case record
    case search
    case camera
    case community
    case shop
    
    var imageName: String {
        switch self {
        case .record: return "Record"
        case .search: return "Search"
        case .camera: return ""
        case .community: return "Community"
        case .shop: return "Shop"
        }
    }
    
    var title: String {
        switch self {
        case .record: return "식단 기록"
        case .search: return "검색"
        case .camera: return ""
        case .community: return "커뮤니티"
        case .shop: return "쇼핑몰"
        }
    }
}

struct MainView: View {
    @State var selectedTab: TabCategory = .record
    var body: some View {
        VStack {
            Spacer()
            switch selectedTab {
            case .record:
                Text("record view")
            case .search:
                Text("search view")
            case .camera:
                Text("camera view")
            case .community:
                Text("community view")
            case .shop:
                Text("shop view")
            }
            Spacer()
            MainTabView(selectedTab: $selectedTab)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
