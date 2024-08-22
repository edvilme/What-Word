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
    @Binding var currentWord: String
    var body: some View {
        HStack {
            Text(currentWord)
                .frame(maxWidth: .infinity, alignment: .leading)
                .fontWeight(.black)
                .fontDesign(.rounded)
            Button("", systemImage: "delete.backward.fill", action: {
                onWordDelete()
            })
                .buttonStyle(.bordered)
                .tint(.red)
                .labelStyle(.iconOnly)
                .controlSize(.regular)
            Button("", systemImage: "return", action: {
                onWordSubmit(currentWord)
            })
                .buttonStyle(.borderedProminent)
                .labelStyle(.iconOnly)
                .controlSize(.regular)
        }
            .padding(.horizontal)
            .padding(.bottom, 1)
    }
}
