//
//  KeyboardWordContainerView.swift
//  WhatWord
//
//  Created by Eduardo  Villalpando  on 22/08/24.
//

import SwiftUI

struct KeyboardWordContainerView: View {
    var onWordSubmit: (String) -> Void
    var onWordDelete: () -> Void
    var deleteKeyIcon: String = "delete.backward.fill"
    @Binding var currentWwNode: WWNode
    @State var showingReferenceLibraryView: Bool = false
    var body: some View {
        HStack {
            Button("", systemImage: deleteKeyIcon, action: {
                onWordDelete()
            })
                .buttonStyle(.bordered)
                .tint(.red)
                .labelStyle(.iconOnly)
                .controlSize(.regular)
            Text(currentWwNode.name)
                .fontWeight(.black)
                .fontDesign(.rounded)
                .padding(.horizontal)
                .font(.title3)
            Spacer()
            if (currentWwNode.type != .empty && currentWwNode.type != .root) {
                Menu("", systemImage: "ellipsis.circle"){
                    Button("Speak word", systemImage: "waveform", action: {
                        currentWwNode.speak()
                    })
                    if (currentWwNode.type == .word) {
                        Button("Open dictionary...", systemImage: "character.book.closed.fill", action: {
                            showingReferenceLibraryView.toggle()
                        })
                    }
                }
                    .buttonStyle(.plain)
                    .labelStyle(.iconOnly)
                    .controlSize(.regular)
                    .padding(.horizontal)
            }
            Button("", systemImage: "return", action: {
                if (currentWwNode.name != "") {
                    onWordSubmit(currentWwNode.name)
                }
            })
                .buttonStyle(.borderedProminent)
                .labelStyle(.iconOnly)
                .controlSize(.regular)
                .disabled(currentWwNode.type == .empty || currentWwNode.name == "")
        }
            .padding(.horizontal)
            .padding(.bottom, 1)
            .sheet(isPresented: $showingReferenceLibraryView, content: {
                AccessoryWordReferenceView(term: currentWwNode.name)
            })
    }
}
