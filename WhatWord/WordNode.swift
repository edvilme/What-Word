//
//  WordNode.swift
//  WhatWord
//
//  Created by Eduardo  Villalpando  on 19/11/23.
//

import Foundation
import NaturalLanguage
import AVFoundation

let synth = AVSpeechSynthesizer() //initialize synthesizer outside the function.

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
    
    func speak(){
        do {
            let utterance = AVSpeechUtterance(string: self.name)
            // TODO: Review language
            utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
            utterance.rate = 0.2
            try synth.speak(utterance)
        } catch {}
    }
    
    // Get related words
    func getRelatedWords(maximumNeighborCount: Int = 20) -> [String] {
        var relatedWords: [String] = []
        // TODO: Review language
        NLEmbedding.wordEmbedding(for: .english)?.enumerateNeighbors(for: self.name, maximumCount: maximumNeighborCount){ neighbor, distance in
            relatedWords.append(neighbor)
            return true
        }
        return relatedWords
    }
}
