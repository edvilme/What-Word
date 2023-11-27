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
    @State var unsplashImageUrl: String = ""
    @State var unsplashImageUrls: [String] = []
    
    func loadUnsplashImage(){
        let unsplash_access_key = "GEIoMKbtqPJz0mpgjJp6dtk13HioRzIrU5tBXaHdig0"
        guard let url = URL(string: "https://api.unsplash.com/search/photos/?client_id=\(unsplash_access_key)&orientation=landscape&per_page=4&query=\(wordNode.name)") else {
            return
        }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error { print("Error: \(error)")}
            else if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
                    let results = (json?["results"] ?? []) as! [NSDictionary]
                    if results.count > 0 {
                        if let urls = results.first?["urls"] as? NSDictionary {
                            print("URLS????")
                            unsplashImageUrl = urls["raw"] as? String ?? ""
                        }
                        for result in results {
                            if let url = result["urls"] as? NSDictionary {
                                unsplashImageUrls.append(url["raw"] as? String ?? "")
                            }
                        }
                    }
                } catch {
                    print("Error parsing JSON: \(error)")
                }
            }
        }
        task.resume()
    }
    
    init(word: String) {
        self.wordNode = WordNode(name: word)
    }
    var body: some View {
        NavigationStack {
            ScrollView {
                unsplashImageUrls.count > 0 ?
                ScrollView(.horizontal) {
                    HStack(spacing: 16){
                        ForEach(unsplashImageUrls, id: \.self) { imageUrl in
                            AsyncImage(url: URL(string: imageUrl)) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                // TODO: Adjust size
                                    .frame(height: 250)
                            } placeholder: {
                                ProgressView()
                            }
                        }
                    }
                }
                : nil
                Spacer()
                wordNode.name != "" ? 
                    HStack {
                        Button {
                            wordNode.speak()
                        } label: {
                            Image(systemName: "waveform")
                            Text("Speak")
                        }   .buttonStyle(.borderedProminent)
                            .tint(.gray)
                    }   .padding()
                : nil
                Spacer()
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
                wordNode.name != "" ?
                    HStack{
                        Image(systemName: "wand.and.stars")
                        Text("Related")
                    } .font(.headline)
                : nil
                wordNode.name != "" ?
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 8) {
                        ForEach(wordNode.getRelatedWords(), id: \.self) { related in
                            NavigationLink {
                                WordHierarchyView(word: related)
                            } label: {
                                WordHierarchyNodeView(word: related)
                            } .buttonStyle(.plain)
                        }
                    } .padding()
                : nil
            }
        }
        .navigationTitle(wordNode.name)
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
        .onAppear{ loadUnsplashImage() }
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
    }
}
