//
//  SearchListView.swift
//  DiningCoach
//
//  Created by SHSEO on 2023/06/26.
//

import SwiftUI
import Foundation

struct SearchListView<T: SearchStoreProtocol>: View {
    @ObservedObject var searchStore: T
    
    var body: some View {
        List(searchStore.suggestionWord.filter{ $0.contains(searchStore.searchedText)}, id: \.self) { food in
            HStack {
                Text(food)
                    .font(.semiBold, size: 14, lineHeight: 16)
                    .foregroundColor(.neutral900)
                    .overlay(findAndHighlightText(food, searchTerm: searchStore.searchedText, highlightColor: .primary500)
                        .font(.semiBold, size: 14, lineHeight: 16))
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.white)
            .onTapGesture {
                if searchStore.path.count == 1 { searchStore.path.removeLast() }
                searchStore.searchedText = food
                searchStore.isTextFieldFocus = false
                searchStore.addRecentSearch(word: searchStore.searchedText)
                searchStore.path.append(.result)
            }
            
        }
        .padding([ .trailing], 16)
        .listStyle(.plain)
        .environment(\.defaultMinListRowHeight, 56) //set rowheight
        .scrollIndicators(ScrollIndicatorVisibility.hidden)
        .scrollDismissesKeyboard(.immediately)
    }
    func findAndHighlightText(_ originalText: String, searchTerm: String, highlightColor: Color) -> some View {
            guard !searchTerm.isEmpty else {
                return Text(originalText)
            }
            
            let textComponents = originalText.components(separatedBy: searchTerm)
            
            var highlightedText = Text("")
            for (index, component) in textComponents.enumerated() {
                if index > 0 {
                    highlightedText = highlightedText + Text(searchTerm)
                        .foregroundColor(highlightColor)
                }
                
                highlightedText = highlightedText + Text(component)
            }
            
            return highlightedText
        }
}

struct SearchListView_Previews: PreviewProvider {
    static var previews: some View {
        SearchListView(searchStore: SearchStore())
    }
}
