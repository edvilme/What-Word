//
//  WordHierarchy.swift
//  WhatWord
//
//  Created by Eduardo  Villalpando  on 19/11/23.
//

import Foundation
import SwiftUI

struct WordHierarchyNodeCardView: View {
    @EnvironmentObject private var userGeneratedText: UserGeneratedText
    @Environment(\.colorScheme) var colorScheme
    var word: String
    init(word: String) {
        self.word = word
    }
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(height: 60)
            .padding()
            .overlay(
                HStack {
                    Text(word)
                        .foregroundColor(colorScheme == .dark ? .black : .white)
                        .font(.title)
                        .fontWeight(.bold)
                        .fixedSize() .padding()
                    Spacer()
                    HStack {
                        Button {
                            UIPasteboard.general.string = self.word
                        } label: {
                            Image(systemName: "doc.on.doc.fill")
                        } .fixedSize()
                        Button {
                            userGeneratedText.text.append(" " + word)
                        } label: {
                            Image(systemName: "square.and.pencil")
                        } .fixedSize() .buttonStyle(.borderedProminent) .padding([.leading])
                    } .padding()
                } .padding()
            )
    }
}

struct WordHierarchyNodeView: View {
    @Environment(\.colorScheme) var colorScheme
    var word: String
    init(word: String) {
        self.word = word
    }
    var body: some View {
        Circle()
            .frame(width: 100, height: 100)
            .overlay(
                Text(word)
                    .foregroundColor(colorScheme == .dark ? .black : .white)
            )
    }
}

struct WordHierarchyView: View {
    @EnvironmentObject private var userGeneratedText: UserGeneratedText
    var wordNode: WordNode
    @State var pinWordPromptIsOpen: Bool = false
    @State var pinWordPromptValue: String = ""
    
    init(word: String) {
        self.wordNode = WordNode(name: word)
    }
    var body: some View {
        NavigationStack {
            ScrollView {
                HStack{
                    Image(systemName: "pin.fill")
                    Text("Pinned")
                } .font(.headline)
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 8) {
                    Button {
                        pinWordPromptIsOpen.toggle()
                    } label: {
                        WordHierarchyNodeView(word: "Add new word...")
                    }
                    .alert("Enter a new word",
                           isPresented: $pinWordPromptIsOpen,
                           actions: {
                        TextField("New word", text: $pinWordPromptValue)
                        Button("Pin", action: {
                            wordNode.pinWord(name: pinWordPromptValue)
                        })
                        Button("Cancel", role: .cancel, action: {
                            pinWordPromptValue = ""
                        })
                    })
                    
                    ForEach(Array(wordNode.pinnedWords), id: \.self) { pinned in
                        NavigationLink {
                            WordHierarchyView(word: pinned)
                        } label: {
                            WordHierarchyNodeView(word: pinned)
                        }   .buttonStyle(.plain)
                            .contextMenu{
                                Button {
                                    wordNode.unpinWord(name: pinned)
                                } label: {
                                    Image(systemName: "trash.fill")
                                    Text("Remove")
                                }
                            }
                    }
                } .padding()
                Spacer()
                Divider()
                Spacer()
                HStack{
                    Image(systemName: "wand.and.stars")
                    Text("Related")
                } .font(.headline)
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 8) {
                    ForEach(wordNode.getRelatedWords(), id: \.self) { related in
                        NavigationLink {
                            WordHierarchyView(word: related)
                        } label: {
                            WordHierarchyNodeView(word: related)
                        } .buttonStyle(.plain)
                    }
                } .padding()
                
            }   .navigationTitle(wordNode.name)
                .navigationBarTitleDisplayMode(.large)
                .navigationBarItems(trailing: HStack {
                    Button {
                        UIPasteboard.general.string = self.wordNode.name
                    } label: {
                        Image(systemName: "doc.on.doc.fill")
                        // Text("Copy")
                    } .buttonStyle(.bordered)
                    Button {
                        userGeneratedText.text.append(" " + wordNode.name)
                    } label: {
                        Image(systemName: "square.and.pencil")
                        // Text("Use")
                    } .buttonStyle(.borderedProminent)
                })
        }
    }
}
