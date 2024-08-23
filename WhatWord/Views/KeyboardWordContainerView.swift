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
    @Binding var currentWord: String
    var body: some View {
        HStack {
            Button("", systemImage: deleteKeyIcon, action: {
                onWordDelete()
            })
                .buttonStyle(.bordered)
                .tint(.red)
                .labelStyle(.iconOnly)
                .controlSize(.regular)
            Text(currentWord)
                .frame(maxWidth: .infinity)
                .fontWeight(.black)
                .fontDesign(.rounded)
            Button("", systemImage: "return", action: {
                onWordSubmit(currentWord)
            })
                .buttonStyle(.borderedProminent)
                .labelStyle(.iconOnly)
                .controlSize(.regular)
        }
            .padding(.horizontal)
            .padding(.bottom, 1)
        Divider()
    }
}
