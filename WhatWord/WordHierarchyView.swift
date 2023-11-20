//
//  WordHierarchy.swift
//  WhatWord
//
//  Created by Eduardo  Villalpando  on 19/11/23.
//

import Foundation
import SwiftUI

struct WordHierarchyNodeView: View {
    var word: String
    init(word: String) {
        self.word = word
    }
    var body: some View {
        Circle()
            .frame(width: 150, height: 150)
            .overlay(
                Text(word)
                    .foregroundColor(.white)
            )
    }
}

struct WordHierarchyView: View {
    var body: some View {
        NavigationStack{
            WordHierarchyNodeView(word: "AA")
            Text("HIII")
                .navigationTitle("Hello")
        }
    }
}
