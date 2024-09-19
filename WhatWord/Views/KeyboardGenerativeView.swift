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
    static var rootNodeExternalId = "ww.node.root.root"
    var onWordSubmit: (String) -> Void
    var onWordDelete: () -> Void
    
    @State var wwNodeExternalIdsStack: [String] = [KeyboardGenerativeView.rootNodeExternalId]
    @State var showingWordDetail: Bool = false
    @State var showingContactDetail: Bool = false
    
    var currentWWNode: Binding<WWNode> { Binding(
        get: {WWNode(externalId: self.wwNodeExternalIdsStack.last!)},
        set: {_ in }
    )}
    
    func generateKeysFromExternalIds(externalIds: [String]) -> ForEach<[String], String, some View>{
        return ForEach(externalIds, id: \.self) { externalId in
            let node = WWNode(externalId: externalId)
            ButtonKeyWord(node: node, action: {
                wwNodeExternalIdsStack.append(externalId)
            })
        }
    }
    
    var body: some View {
        VStack{
            KeyboardWordContainerView(
                onWordSubmit: { word in
                    onWordSubmit(word)
                    wwNodeExternalIdsStack = [KeyboardGenerativeView.rootNodeExternalId]
                },
                onWordDelete: {
                    if(currentWWNode.wrappedValue.externalId != KeyboardGenerativeView.rootNodeExternalId){
                        wwNodeExternalIdsStack.removeLast()
                    }
                    else {
                        onWordDelete()
                    }
                },
                deleteKeyIcon: currentWWNode.wrappedValue.externalId == KeyboardGenerativeView.rootNodeExternalId ? "delete.backward.fill" : "chevron.backward", 
                currentWwNode: currentWWNode
            )
            ScrollView(content: {
                // Pinned words
                Section {
                    HFlow(horizontalAlignment: .center, verticalAlignment: .top) {
                        Button("Edit…", systemImage: "pencil", action: {
                            showingWordDetail.toggle()
                        })
                        .font(.title3)
                        .buttonStyle(.bordered)
                        self.generateKeysFromExternalIds(externalIds: currentWWNode.pinnedNodeIds.wrappedValue)
                    }
                }
                    .padding(.bottom)
                    .padding(.horizontal)
                Divider()
                // Related words
                Section {
                    if (currentWWNode.type.wrappedValue == .contact && currentWWNode.contact.wrappedValue != nil) {
                        Button("Contact info…", systemImage: "person.fill", action: {
                            showingContactDetail.toggle()
                        })
                            .buttonStyle(.borderedProminent)
                    } else {
                        HFlow(horizontalAlignment: .center, verticalAlignment: .top) {
                            self.generateKeysFromExternalIds(externalIds: currentWWNode.wrappedValue.getRelatedNodeExternalIds())
                        }
                    }
                }
                    .padding(.horizontal)
            })
                .frame(maxWidth: .infinity)
        }
            .sheet(isPresented: $showingWordDetail, content: {
                WordDetailView(currentNode: currentWWNode.wrappedValue)
            })
            .sheet(isPresented: $showingContactDetail, content: {
                AccessoryContactDetailView(contact: currentWWNode.wrappedValue.contact!)
            })
    }
}
