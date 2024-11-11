//
//  ContentView.swift
//  WhatWord
//
//  Created by Eduardo  Villalpando  on 19/11/23.
//

import SwiftUI
import AirKit


struct ContentView: View {
    @State private var wwGeneratedText: String = ""
    @State private var systemKeyboardHidden: Bool = true
    var body: some View {
        NavigationStack {
            TextEditor(text: $wwGeneratedText)
                .font(.system(size: 30, weight: .black, design: .rounded))
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding()
                .disabled(systemKeyboardHidden)
                .airPlay()
                .toolbar {
                    ToolbarItemGroup(placement: .topBarLeading) {
                        Button("", systemImage: "trash", action: {
                            wwGeneratedText = ""
                        })
                            .labelStyle(.iconOnly)
                            .disabled(wwGeneratedText.isEmpty)
                    }
                    ToolbarItemGroup(placement: .topBarTrailing) {
                        Button("", systemImage: "sparkles", action: {})
                            .disabled(true)
                        ShareLink("", item: wwGeneratedText)
                            .labelStyle(.iconOnly)
                            .disabled(wwGeneratedText.isEmpty)
                    }
                }
            KeyboardContainerView(
                onKeyboardTypeChange: { keyboardType in
                    systemKeyboardHidden = keyboardType.name != "keyboard"
                },
                onWordSubmit: { word in
                    wwGeneratedText += " \(word)"
                },
                onWordDelete: {
                    wwGeneratedText = wwGeneratedText.replacing(/\S+\s*$/, with: "")
                }
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
