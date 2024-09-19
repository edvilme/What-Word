//
//  KeyboardGenerativeViewSettings.swift
//  WhatWord
//
//  Created by Eduardo  Villalpando  on 22/08/24.
//

import SwiftUI
import ContactsUI

struct WordDetailView: View {
    @ObservedObject var currentNode: WWNode
    
    @State private var newWordNodeShowing: Bool = false
    @State private var newWordNodeAlertName: String = ""
    
    @State private var newContactNodeShowing: Bool = false
    
    var body: some View {
        NavigationView {
            Form{
                Section("Pinned") {
                    Menu("Add...", systemImage: "plus") {
                        Button("Add word...", systemImage: "note.text.badge.plus", action: {
                            newWordNodeShowing.toggle()
                        })
                        Button("Add contact...", systemImage: "person.crop.circle.badge.plus", action: {
                            newContactNodeShowing.toggle()
                        })
                    }
                    ForEach(currentNode.pinnedNodeIds, id: \.self){ externalId in
                        let node = WWNode(externalId: externalId)
                        HStack {
                            if (node.type == .contact) {
                                Image(systemName: "person.crop.circle")
                            } else {
                                Image(systemName: "pin.fill")
                            }
                            Text(node.name)
                        }
                    }
                    .onDelete(perform: { indexSet in
                        currentNode.pinnedNodeIds.remove(atOffsets: indexSet)
                    })
                }
            }
            .navigationBarItems(leading: Button("Done", action: {
            }))
            .navigationBarTitle(currentNode.name, displayMode: .large)
            
            .alert("New node", isPresented: $newWordNodeShowing) {
                TextField("", text: $newWordNodeAlertName)
                Button("Cancel", action: {
                    newWordNodeShowing.toggle()
                })
                Button("OK", action: {
                    currentNode.pinnedNodeIds.append("ww.node.word.\(newWordNodeAlertName.lowercased())")
                })
            }
            
            .sheet(isPresented: $newContactNodeShowing) {
                AccessoryContactPickerView(isPresented: $newContactNodeShowing, onSelect: { contact in
                    currentNode.pinnedNodeIds.append("ww.node.contact.\(contact.identifier)")
                })
            }
        }
            
    }
}
