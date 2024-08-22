//
//  KeyboardGenerativeView.swift
//  WhatWord
//
//  Created by Eduardo  Villalpando  on 21/08/24.
//

import SwiftUI
import Flow

struct KeyboardGenerativeView: View {
    static var rootNodeExternalId = "ww.node.word.apple"
    var onWordSubmit: (String) -> Void
    var onWordDelete: (String) -> Void
    
    @State var wwNodeExternalIdsStack: [String] = [rootNodeExternalId]
    
    var currentWWNode: Binding<WWNode> { Binding(
        get: {WWNode(externalId: self.wwNodeExternalIdsStack.last!)},
        set: {_ in }
    )}
    
    func generateWordKeysFromExternalIds(externalIds: [String]) -> ForEach<[String], String, some View>{
        return ForEach(externalIds, id: \.self) { externalId in
            let node = WWNode(externalId: externalId)
            Button(node.name, action: {
                wwNodeExternalIdsStack.append(externalId)
            })
                .buttonStyle(.bordered)
                .fontWeight(.bold)
                .fontDesign(.rounded)
        }
    }
    
    var body: some View {
        VStack{
            KeyboardWordContainerView(
                onWordSubmit: onWordSubmit,
                onWordDelete: {
                    if(currentWWNode.wrappedValue.externalId != KeyboardGenerativeView.rootNodeExternalId){
                        wwNodeExternalIdsStack.removeLast()
                    }
                },
                currentWord: currentWWNode.name
            )
            ScrollView(content: {
                // Pinned words
                if (!currentWWNode.wrappedValue.pinnedNodeIds.isEmpty) {
                    Section {
                        HFlow {
                            self.generateWordKeysFromExternalIds(externalIds: Array(currentWWNode.wrappedValue.pinnedNodeIds))
                        }
                    } header: {
                        Text("Pinned Nodes")
                            .font(.headline)
                    }
                    .padding(.horizontal)
                }
                // Related words
                Section {
                    HFlow {
                        HFlow {
                            self.generateWordKeysFromExternalIds(externalIds: currentWWNode.wrappedValue.getRelatedNodeExternalIds())
                        }
                    }
                } header: {
                    Text("Related Nodes")
                        .font(.headline)
                }
                    .padding(.horizontal)
            })
        }
    }
}
