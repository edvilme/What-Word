//
//  ContentView.swift
//  WhatWord
//
//  Created by Eduardo  Villalpando  on 19/11/23.
//

import SwiftUI


struct ContentView: View {
    @State private var wwGeneratedText: String = ""
    @State private var systemKeyboardHidden: Bool = true
    var body: some View {
        VStack {
            VStack{
                HStack{
                    Button("", systemImage: "xmark", action: {
                        wwGeneratedText = ""
                    })
                    Spacer()
                    Button("", systemImage: "sparkles", action: {})
                        .disabled(true)
                    ShareLink("", item: wwGeneratedText)
                }
                    .padding(.horizontal)
                TextEditor(text: $wwGeneratedText)
                    .font(.system(size: 30, weight: .black, design: .rounded))
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .padding()
                    .disabled(systemKeyboardHidden)
            }
            KeyboardContainerView(
                onKeyboardTypeChange: { keyboardType in
                    systemKeyboardHidden = keyboardType.name != "keyboard"
                },
                onWordSubmit: { word in
                    wwGeneratedText += " \(word)"
                },
                onWordDelete: {
                    wwGeneratedText = wwGeneratedText.replacing(/\w+\s*$/, with: "") 
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
