//
//  WWNode.swift
//  WhatWord
//
//  Created by Eduardo  Villalpando  on 12/08/24.
//

import Foundation
import NaturalLanguage
import Combine

enum WWNodeType {
    case root
    case empty
    case word
    case contact
}

class WWNode: ObservableObject {
    var externalId: String = "ww.node.empty.empty"
    var name: String = "empty"
    var type: WWNodeType = .empty
    
    // Internal private stored property to trigger updates
    @Published private var _pinnedNodeIds: [String] = []
    
    // Computed property to access pinnedNodeIds
    var pinnedNodeIds: [String] {
        get {
            return _pinnedNodeIds
        }
        set {
            _pinnedNodeIds = Array(Set(newValue))  // Ensure uniqueness
            UserDefaults.standard.set(_pinnedNodeIds, forKey: externalId)
        }
    }
    
    init (externalId: String) {
        if let regexMatches = try! /ww\.node\.(\w+)\.(\w+)/.firstMatch(in: externalId) {
            self.externalId = externalId
            _pinnedNodeIds = UserDefaults.standard.array(forKey: externalId) as? [String] ?? []
            switch regexMatches.1 {
                case "contact":
                    self.type = .contact
                case "root":
                    self.type = .root
                default:
                    self.type = .word
            }
            if (self.type != .root) {
                self.name = String(regexMatches.2)
            } else {
                self.name = ""
            }
            
        }
    }
        
    func getRelatedNodeExternalIds() -> [String]{
        var relatedNodeExternalIds: [String] = []
        // Word embeddings
        if (type == .word){
            NLEmbedding.wordEmbedding(
                for: NLLanguage(rawValue: NSLocale.current.language.languageCode?.identifier ?? "en_US")
            )?.enumerateNeighbors(
                for: self.name,
                maximumCount: 50
            ) { neighbor, distance in
                relatedNodeExternalIds.append("ww.node.word.\(neighbor)")
                return true
            }
        }
        return relatedNodeExternalIds
    }
}
