//
//  KeyboardGenerativeViewSettings.swift
//  WhatWord
//
//  Created by Eduardo  Villalpando  on 22/08/24.
//

import SwiftUI

struct KeyboardGenerativeViewSettings: View {
    @ObservedObject var currentNode: WWNode
    
    var body: some View {
        NavigationView {
            Form{
                Section("Pinned") {
                    Button("New...", systemImage: "plus", action: {
                        currentNode.pinnedNodeIds.append("ww.node.word.corn")
                    })
                    ForEach(currentNode.pinnedNodeIds, id: \.self){ externalId in
                        Text(externalId)
                    }
                    .onDelete(perform: { indexSet in
                        currentNode.pinnedNodeIds.remove(atOffsets: indexSet)
                    })
                }
            }
            .navigationBarItems(leading: Button("Done", action: {
            }))
            .navigationBarTitle(currentNode.name, displayMode: .large)
        }
            
    }
}
