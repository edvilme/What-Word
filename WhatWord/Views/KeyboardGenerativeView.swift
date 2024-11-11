//
//  KeyboardGenerativeView.swift
//  WhatWord
//
//  Created by Eduardo  Villalpando  on 21/08/24.
//

import SwiftUI
import Flow
import ContactsUI

struct KeyboardGenerativeView: View {
    static var ROOT_EXTERNAL_ID = "ww.node.root.root"
    
    var onWordSubmit: (String) -> Void
    var onWordDelete: () -> Void
    
    @State var wwNodeExternalIdsStack: [String] = ["ww.node.root.root"]
    var currentWWNode: Binding<WWNode> { Binding(
        get: {WWNode(externalId: self.wwNodeExternalIdsStack.last!)},
        set: {_ in }
    )}
    
    var body: some View {
        KeyboardGenerativeViewOld(
            onWordSubmit: {word in
                onWordSubmit(word)
                wwNodeExternalIdsStack = ["ww.node.root.root"]
            },
            onWordDelete: {
                if currentWWNode.wrappedValue.externalId != "ww.node.root.root" {
                    wwNodeExternalIdsStack.removeLast()
                } else {
                    onWordDelete()
                }
            },
            onWordSelect: {word in
                wwNodeExternalIdsStack.append(word)
            },
            node: currentWWNode
        )
    }
}

struct KeyboardGenerativeViewOld: View {
    var onWordSubmit: (String) -> Void
    var onWordDelete: () -> Void
    var onWordSelect: (String) -> Void
    
    @Binding var node: WWNode
    @State var showingWordDetail: Bool = false
    @State var showingContactDetail: Bool = false
    
    func generateKeysFromExternalIds(externalIds: [String]) -> ForEach<[String], String, some View>{
        return ForEach(externalIds, id: \.self) { externalId in
            let node = WWNode(externalId: externalId)
            ButtonKeyWord(node: node, action: {
                onWordSelect(node.externalId)
            })
        }
    }
    
    var body: some View {
        VStack{
            KeyboardWordContainerView(
                onWordSubmit: onWordSubmit,
                onWordDelete: onWordDelete,
                deleteKeyIcon: node.externalId == KeyboardGenerativeView.ROOT_EXTERNAL_ID ? "delete.backward.fill" : "chevron.backward",
                currentWwNode: $node
            )
            ScrollView(content: {
                Text("Tap a word to see related words. Tap \(Image(systemName: "return")) to enter the word")
                    .font(.caption)
                    .foregroundStyle(.tertiary)
                // Pinned words
                Section {
                    HFlow(horizontalAlignment: .center, verticalAlignment: .top) {
                        Button("Edit…", systemImage: "pencil", action: {
                            showingWordDetail.toggle()
                        })
                        .font(.title3)
                        .buttonStyle(.bordered)
                        self.generateKeysFromExternalIds(externalIds: node.pinnedNodeIds)
                    }
                }
                    .padding(.bottom)
                    .padding(.horizontal)
                // Additional Info
                Divider()
                Section {
                    // Contacts: Contact Info
                    if (node.type == .contact && node.contact != nil) {
                        /*Button("Contact info…", systemImage: "person.fill", action: {
                            showingContactDetail.toggle()
                        })
                            .buttonStyle(.borderedProminent)
                            .font(.title2)
                            .padding()
                         */
                        AccessoryContactDetailView(contact: node.contact!)
                            .frame(height: 300)
                    // Words: Related words
                    } else {
                        HFlow(horizontalAlignment: .center, verticalAlignment: .top) {
                            self.generateKeysFromExternalIds(externalIds: node.getRelatedNodeExternalIds())
                        }
                    }
                }
                    .padding(.horizontal)
            })
                .frame(maxWidth: .infinity)
        }
            .sheet(isPresented: $showingWordDetail, content: {
                WordDetailView(currentNode: node)
            })
            .sheet(isPresented: $showingContactDetail, content: {
                AccessoryContactDetailView(contact: node.contact!)
            })
    }
}
