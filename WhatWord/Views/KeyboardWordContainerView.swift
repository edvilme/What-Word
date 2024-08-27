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
    var body: some View {
        HStack {
            Button("", systemImage: deleteKeyIcon, action: {
                onWordDelete()
            })
                .buttonStyle(.bordered)
                .tint(.red)
                .labelStyle(.iconOnly)
                .controlSize(.regular)
            Text(self.currentWwNode.name)
                .fontWeight(.black)
                .fontDesign(.rounded)
                .padding(.horizontal)
            Spacer()
            if (currentWwNode.type != .empty && currentWwNode.type != .root) {
                Button("", systemImage: "speaker.wave.3.fill", action: {
                    currentWwNode.speak()
                })
                    .buttonStyle(.plain)
                    .labelStyle(.iconOnly)
                    .controlSize(.regular)
                    .padding(.horizontal)
            }
            Button("", systemImage: "return", action: {
                if (self.currentWwNode.name != "") {
                    onWordSubmit(self.currentWwNode.name)
                }
            })
                .buttonStyle(.borderedProminent)
                .labelStyle(.iconOnly)
                .controlSize(.regular)
        }
            .padding(.horizontal)
            .padding(.bottom, 1)
    }
}
