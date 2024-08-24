//
//  KeyboardGenerativeViewSettings.swift
//  WhatWord
//
//  Created by Eduardo  Villalpando  on 22/08/24.
//

import SwiftUI

struct WordDetailView: View {
    @ObservedObject var currentNode: WWNode
    
    @State private var newNodeAlertShowing: Bool = false
    @State private var newNodeAlertName: String = ""
    
    var body: some View {
        NavigationView {
            Form{
                Section("Pinned") {
                    Button("New...", systemImage: "plus", action: {
                        newNodeAlertShowing.toggle()
                    })
                    ForEach(currentNode.pinnedNodeIds, id: \.self){ externalId in
                        Text(WWNode(externalId: externalId).name)
                    }
                    .onDelete(perform: { indexSet in
                        currentNode.pinnedNodeIds.remove(atOffsets: indexSet)
                    })
                }
            }
            .navigationBarItems(leading: Button("Done", action: {
            }))
            .navigationBarTitle(currentNode.name, displayMode: .large)
            .alert("New node", isPresented: $newNodeAlertShowing) {
                TextField("", text: $newNodeAlertName)
                Button("OK", action: {
                    currentNode.pinnedNodeIds.append("ww.node.word.\(newNodeAlertName.lowercased())")
                })
            }
        }
            
    }
}
