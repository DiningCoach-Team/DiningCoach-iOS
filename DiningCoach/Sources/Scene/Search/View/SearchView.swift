//
//  SearchView.swift
//  DiningCoach
//
//  Created by SHSEO on 2023/06/23.
//

import SwiftUI
import Combine
import Kingfisher


struct SearchView<T: SearchStoreProtocol>: View {
    @ObservedObject var searchStore: T
    @State var isShowingResult = false
    var body: some View {
        NavigationStack(path: $searchStore.path) {
            VStack() {
                if !searchStore.isTextFieldFocus{
                    SearchHeaderView()
                }
                SearchBarView(searchStore: searchStore)
                    .padding(.top, 12)
                
                if searchStore.searchedText.isEmpty {
                    ScrollView() {
                        if !searchStore.recentWordList.isEmpty {
                            RecentSearchView(searchStroe: searchStore)
                                .padding(.top, 30)
                        }
                        
                        RecommendSearchView(searchStore: searchStore)
                            .padding(.top, 32)
                        
                        RecommendFoodView()
                            .padding(.top, 32)
                    }
                    .scrollDismissesKeyboard(.immediately)
                } else {
                    SearchListView(searchStore: searchStore)
                }
                
            }
            .background(.white)
            .padding(.bottom, 10)
            .animation(.easeInOut(duration: 0.2),
                       value: [
                        !searchStore.isTextFieldFocus,
                        searchStore.searchedText.isEmpty,
                        searchStore.recentWordList.isEmpty
                       ]
            )
            .navigationBarHidden(true)
            .onAppear {
                print("SearchView onAppear")
                searchStore.searchedText = ""
            }
            .navigationDestination(for: SearchStackType.self, destination:{ type in

                switch type {
                case .result :
                    SearchResultView(searchStore: searchStore)
                        .navigationBarHidden(true)
                case .detail:
                    SearchDetailView(searchStore: searchStore)
                        .navigationBarHidden(true)
                }
            })
        }
    }
}

struct SearchHeaderView: View {
    var body: some View {
        HStack(spacing: 0) {
            Spacer()
            
            Button(action: {
                //TODO: 벨 버튼 클릭 시 기능 추가
            }, label: {
                Image("bell")
                    .frame(width: 40, height: 40)
            })
            
            Button(action: {
                //TODO: 유저 버튼 클릭 시 기능 추가
            }, label: {
                Image("user")
                    .frame(width: 40, height: 40)
            })
        }
        .frame(maxWidth: .infinity)
        .padding(.trailing, 8)
    }
}

struct RecentSearchView<T: SearchStoreProtocol>: View {
    @ObservedObject var searchStroe: T
    
    var body: some View {
        
        VStack(spacing: 16) {
            HStack {
                Text("최근 검색어")
                    .font(.bold, size: 14, lineHeight: 20)
                    .foregroundColor(.neutral900)
                Spacer()
                
                Button(action: {
                    searchStroe.removeAllRecentSearch()
                }, label: {
                    Text("전체 삭제")
                        .font(.bold, size: 11, lineHeight: 16)
                        .foregroundColor(.neutral700)
                })
            }
            .padding(.horizontal, 16)
            .padding(.top, 6)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(searchStroe.recentWordList, id: \.self) { word in
                        HStack(alignment: .center, spacing: 4) {
                            Text(word)
                                .font(.semiBold, size: 11, lineHeight: 16)
                                .foregroundColor(.neutral900)
                                .onTapGesture {
                                    searchStroe.searchedText = word
                                    searchStroe.addRecentSearch(word: word)
                                    searchStroe.path.append(.result)
                                }
                            
                            Button(action: {
                                searchStroe.removeRecentSearch(word: word)
                            }, label: {
                                Image("xmark")
                            })
                            .buttonStyle(.plain)
                        }
                        .frame(height: 30)
                        .padding(.horizontal, 9)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .strokeBorder(Color.neutral300, lineWidth: 1)
                        )
                    }
                }
                .padding(.horizontal, 16)
                
            }
        }
        .frame(maxWidth: .infinity)
        
        
    }
}

struct RecommendSearchView<T: SearchStoreProtocol>: View {
    @ObservedObject var searchStore: T
    @State private var totalHeight = CGFloat(100)
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Text("추천 검색어")
                    .font(.bold, size: 14, lineHeight: 20)
                    .foregroundColor(.neutral900)
                Spacer()
            }
            GeometryReader { geometry in
                self.generateContent(in: geometry)
                    .background(GeometryReader {gp -> Color in
                        DispatchQueue.main.async {
                            self.totalHeight = gp.size.height
                        }
                        return Color.clear
                    })
            }
            .frame(maxHeight: .infinity)
            .frame(height: totalHeight)
            
        }
        .padding(.horizontal, 16)
        
    }
    
    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        
        return ZStack(alignment: .topLeading) {
            ForEach(self.searchStore.recommendationWord, id: \.self) { keyword in
                self.item(for: keyword)
                    .padding([.horizontal, .vertical], 4)
                    .alignmentGuide(.leading, computeValue: { d in
                        if (abs(width - d.width) > g.size.width)
                        {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        if keyword == self.searchStore.recommendationWord.last! {
                            width = 0
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: {d in
                        let result = height
                        if keyword == self.searchStore.recommendationWord.last! {
                            height = 0
                        }
                        return result
                    })
                    .onTapGesture {
                        searchStore.searchedText = keyword
                        searchStore.addRecentSearch(word: keyword)
                        searchStore.path.append(.result)
                    }
            }
        }
        
    }
    
    private func item(for text: String) -> some View {
        Text(text)
            .frame(height: 28)
            .padding(.horizontal, 9)
            .font(.semiBold, size: 11, lineHeight: 16)
            .background(Color.primary50)
            .foregroundColor(Color.primary500)
            .cornerRadius(12)
    }
}

struct dummy: Hashable {
    var imageUrl: String
    var imageName: String
}

struct RecommendFoodView: View {
    var dummys: [dummy] = [dummy(imageUrl: "https://firebasestorage.googleapis.com/v0/b/steady-copilot-206205.appspot.com/o/goods%2F066018fb-b16a-480c-9b8e-c100c3a02f42%2F066018fb-b16a-480c-9b8e-c100c3a02f42_front_angle_250_w.jpg?alt=media&token=d1051a5c-a8ad-4f88-9089-4adaa6ce98e1", imageName: "매일 우유"), dummy(imageUrl: "https://firebasestorage.googleapis.com/v0/b/steady-copilot-206205.appspot.com/o/goods%2F066018fb-b16a-480c-9b8e-c100c3a02f42%2F066018fb-b16a-480c-9b8e-c100c3a02f42_front_angle_250_w.jpg?alt=media&token=d1051a5c-a8ad-4f88-9089-4adaa6ce98e1", imageName: "매일 우유"), dummy(imageUrl: "https://firebasestorage.googleapis.com/v0/b/steady-copilot-206205.appspot.com/o/goods%2F066018fb-b16a-480c-9b8e-c100c3a02f42%2F066018fb-b16a-480c-9b8e-c100c3a02f42_front_angle_250_w.jpg?alt=media&token=d1051a5c-a8ad-4f88-9089-4adaa6ce98e1", imageName: "매일 우유"), dummy(imageUrl: "https://firebasestorage.googleapis.com/v0/b/steady-copilot-206205.appspot.com/o/goods%2F066018fb-b16a-480c-9b8e-c100c3a02f42%2F066018fb-b16a-480c-9b8e-c100c3a02f42_front_angle_250_w.jpg?alt=media&token=d1051a5c-a8ad-4f88-9089-4adaa6ce98e1", imageName: "매일 우유"), dummy(imageUrl: "https://firebasestorage.googleapis.com/v0/b/steady-copilot-206205.appspot.com/o/goods%2F066018fb-b16a-480c-9b8e-c100c3a02f42%2F066018fb-b16a-480c-9b8e-c100c3a02f42_front_angle_250_w.jpg?alt=media&token=d1051a5c-a8ad-4f88-9089-4adaa6ce98e1", imageName: "매일 우유")]
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Text("이런 음식은 어떠세요?")
                    .font(.bold, size: 14, lineHeight: 20)
                    .foregroundColor(Color.neutral900)
                Spacer()
            }
            .padding(.horizontal, 16)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(dummys, id: \.self) { dummy in
                        VStack(spacing: 8) {
                            KFImage(URL(string: dummy.imageUrl))
                                .placeholder({
                                    ProgressView()
                                })
                                .fade(duration: 0.2)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 140, height: 96)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                
                            Text(dummy.imageName)
                                .font(.medium, size: 14, lineHeight: 20)
                                .foregroundColor(Color.neutral900)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 16)
                
            }
        }
        
    }
}


struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(searchStore: SearchStore())
    }
}
