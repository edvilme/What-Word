//
//  WWNode.swift
//  WhatWord
//
//  Created by Eduardo  Villalpando  on 12/08/24.
//

import Foundation
import NaturalLanguage

enum WWNodeType {
    case empty
    case word
    case contact
}

class WWNode {
    var externalId: String = "ww.node.empty.empty"
    var name: String = "empty"
    var type: WWNodeType = .empty
    var pinnedNodeIds: Set<String> = []
    
    init (externalId: String) {
        if let regexMatches = try! /ww\.node\.(\w+)\.(\w+)/.firstMatch(in: externalId) {
            self.externalId = externalId
            self.name = String(regexMatches.2)
            self.pinnedNodeIds = Set(
                UserDefaults.standard.array(forKey: externalId) as? [String] ?? []
            )
            switch regexMatches.1 {
                case "contact":
                    self.type = .contact
                default:
                    self.type = .word
            }
        }
    }
    
    func pinNode(externalId: String) {
        self.pinnedNodeIds.insert(externalId)
        UserDefaults.standard.set(
            Array(self.pinnedNodeIds), forKey: self.externalId
        )
    }
    
    func unpinNode(externalId: String) {
        self.pinnedNodeIds.remove(externalId)
        UserDefaults.standard.set(
            Array(self.pinnedNodeIds), forKey: self.externalId
        )
    }
    
    func getRelatedNodeExternalIds() -> [String]{
        var relatedNodeExternalIds: [String] = []
        // Word embeddings
        NLEmbedding.wordEmbedding(for: .english)?.enumerateNeighbors(
            for: self.name,
            maximumCount: 20
        ) { neighbor, distance in
            relatedNodeExternalIds.append("ww.node.word.\(neighbor)")
            return true
        }
        return relatedNodeExternalIds
    }
}
