//
//  KeyboardGenerativeView.swift
//  WhatWord
//
//  Created by Eduardo  Villalpando  on 21/08/24.
//

import SwiftUI
import Flow

struct KeyboardGenerativeView: View {
    static var rootNodeExternalId = "ww.node.root.root"
    var onWordSubmit: (String) -> Void
    var onWordDelete: (String) -> Void
    
    @State var wwNodeExternalIdsStack: [String] = [KeyboardGenerativeView.rootNodeExternalId]
    @State var showingSettings: Bool = false
    
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
                .tint(.primary)
        }
    }
    
    var body: some View {
        VStack{
            KeyboardWordContainerView(
                onWordSubmit: {word in
                    onWordSubmit(word)
                    wwNodeExternalIdsStack = [KeyboardGenerativeView.rootNodeExternalId]
                },
                onWordDelete: {
                    if(currentWWNode.wrappedValue.externalId != KeyboardGenerativeView.rootNodeExternalId){
                        wwNodeExternalIdsStack.removeLast()
                    }
                },
                deleteKeyIcon: currentWWNode.wrappedValue.externalId == KeyboardGenerativeView.rootNodeExternalId ? "delete.backward.fill" : "chevron.backward", 
                currentWord: currentWWNode.name
            )
            ScrollView(content: {
                // Pinned words
                Section {
                    HFlow {
                        Button("Edit...", systemImage: "pencil", action: {
                            showingSettings.toggle()
                        })
                        .buttonStyle(.bordered)
                        self.generateWordKeysFromExternalIds(externalIds: currentWWNode.pinnedNodeIds.wrappedValue)
                    }
                    .padding(.bottom)
                } header: {
                    HStack {
                        Image(systemName: "pin.fill")
                        Text("Pinned Nodes")
                            .font(.headline)
                    }
                }
                // Related words
                Section {
                    HFlow {
                        self.generateWordKeysFromExternalIds(externalIds: currentWWNode.wrappedValue.getRelatedNodeExternalIds())
                    }
                    .padding(.bottom)
                } header: {
                    HStack {
                        Image(systemName: "sparkles")
                        Text("Related Nodes")
                            .font(.headline)
                    }
                }
            })
        } .sheet(isPresented: $showingSettings, content: {
            KeyboardGenerativeViewSettings(currentNode: currentWWNode.wrappedValue)
        })
    }
}
