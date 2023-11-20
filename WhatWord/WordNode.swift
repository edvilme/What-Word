//
//  WordNode.swift
//  WhatWord
//
//  Created by Eduardo  Villalpando  on 19/11/23.
//

import Foundation
import NaturalLanguage

class WordNode {
    var name: String
    var pinnedWords: Set<String>
    init (name: String){
        self.name = name.lowercased()
        // Get data
        self.pinnedWords = Set(
            UserDefaults.standard.array(forKey: "word." + self.name) as? [String] ?? []
        )
    }
    // Add a word to pins
    func pinWord(name: String){
        self.pinnedWords.insert(name)
        // Save
        UserDefaults.standard.set(
            Array(self.pinnedWords), forKey: "word." + self.name
        )
    }
    // Remove word from pins
    func unpinWord(name: String){
        self.pinnedWords.remove(name)
        // Save
        UserDefaults.standard.set(
            Array(self.pinnedWords), forKey: "word." + self.name
        )
    }
    
    // Get related words
    func getRelatedWords(maximumNeighborCount: Int = 20) -> [String] {
        var relatedWords: [String] = []
        NLEmbedding.wordEmbedding(for: .english)?.enumerateNeighbors(for: self.name, maximumCount: maximumNeighborCount){ neighbor, distance in
            relatedWords.append(neighbor)
            return true
        }
        return relatedWords
    }
}
