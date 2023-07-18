//
//  SearchBarView.swift
//  DiningCoach
//
//  Created by SHSEO on 2023/06/23.
//

import SwiftUI

struct SearchBarView<T: SearchStoreProtocol>: View {
    @ObservedObject var searchStore: T
    var body: some View {
        HStack(spacing: 16) {
            if searchStore.isTextFieldFocus || !searchStore.searchedText.isEmpty {
                Button(action: {
                    searchStore.isTextFieldFocus = false
                    if searchStore.path.count > 0 { searchStore.path.removeLast() }
                }, label: {
                    Image("arrow_left")
                })
            }
            
            HStack {
                TextField("", text: $searchStore.searchedText)
                    .accentColor(.primary500)
                    .font(.bold, size: 14, lineHeight: 20)
                    .onChange(of: searchStore.searchedText) { _ in
                        searchStore.updateSuggestions()
                    }
                    .padding(.leading, 16)
                    .background(
                        HStack {
                            if searchStore.searchedText.isEmpty {
                                Text("찾으시는 식품을 검색해 주세요")
                                    .font(.bold, size: 14, lineHeight: 20)
                                    .padding(.leading, 16)
                                    .foregroundColor(.neutral300)
                                Spacer()
                            }
                        }
                    )
                    .onTapGesture {
                        searchStore.isTextFieldFocus = true
                    }
                    .frame(maxWidth: .infinity)
                
                Button(action: {
                    if searchStore.searchedText.isEmpty { return }
                    searchStore.addRecentSearch(word: searchStore.searchedText)
                    searchStore.isTextFieldFocus = false
                    searchStore.path.append(.result)
                }, label: {
                    Image("Search")
                        .renderingMode(.template)
                        .frame(width: 52, height: 40)
                        .foregroundColor(searchStore.isTextFieldFocus ? .primary500 : .neutral400)
                })
            }
            .frame(maxWidth: .infinity)
            .background(.white)
            .cornerRadius(12, corners: .allCorners)
            .shadow(color: !searchStore.isTextFieldFocus ? .black.opacity(0.05) : .primary500.opacity(0.2), radius: 5, x:0, y:0)
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 16)
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchStore: SearchStore())
    }
}
