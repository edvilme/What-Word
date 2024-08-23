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
    case empty
    case word
    case contact
}

class WWNode: ObservableObject {
    var externalId: String = "ww.node.empty.empty"
    var name: String = "empty"
    var type: WWNodeType = .empty
    
    // Internal private stored property to trigger updates
    @Published private var pinnedNodeIdsInternal: [String] = []
    
    // Computed property to access pinnedNodeIds
    var pinnedNodeIds: [String] {
        get {
            return pinnedNodeIdsInternal
        }
        set {
            pinnedNodeIdsInternal = Array(Set(newValue))  // Ensure uniqueness
            UserDefaults.standard.set(pinnedNodeIdsInternal, forKey: externalId)
        }
    }
    
    init (externalId: String) {
        if let regexMatches = try! /ww\.node\.(\w+)\.(\w+)/.firstMatch(in: externalId) {
            self.externalId = externalId
            self.name = String(regexMatches.2)
            pinnedNodeIdsInternal = UserDefaults.standard.array(forKey: externalId) as? [String] ?? []
            switch regexMatches.1 {
                case "contact":
                    self.type = .contact
                default:
                    self.type = .word
            }
        }
    }
        
    func getRelatedNodeExternalIds() -> [String]{
        var relatedNodeExternalIds: [String] = []
        // Word embeddings
        NLEmbedding.wordEmbedding(for: .english)?.enumerateNeighbors(
            for: self.name,
            maximumCount: 30
        ) { neighbor, distance in
            relatedNodeExternalIds.append("ww.node.word.\(neighbor)")
            return true
        }
        return relatedNodeExternalIds
    }
}
