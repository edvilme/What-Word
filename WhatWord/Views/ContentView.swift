//
//  ContentView.swift
//  WhatWord
//
//  Created by Eduardo  Villalpando  on 19/11/23.
//

import SwiftUI

struct WordCameraView: View {
    var body: some View {
        Text("Word Camera Coming Soon!")
            .font(.largeTitle)
    }
}

struct SettingsView: View {
    var body: some View {
        Text("Settings")
    }
}

struct ContentView: View {
    @EnvironmentObject private var userGeneratedText: UserGeneratedText
    @State var isSheetPresented = true
    var body: some View {
        TabView {
            WordHierarchyView(word: "")
                .tabItem {
                    Label("Pins", systemImage: "pin.fill")
                }
            WordDrawView()
                .tabItem {
                    Label("Draw", systemImage: "hand.draw.fill")
                }
            WordCameraView()
                .tabItem {
                    Label("Camera", systemImage: "camera.fill")
                }
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
        }
        Button {
            isSheetPresented.toggle()
        } label: {
            HStack {
                Text(userGeneratedText.text)
                    .fontWeight(.bold)
                    .padding()
                    .clipped()
                    .truncationMode(.head)
                Spacer()
                Image(systemName: "chevron.up.circle.fill")
                    .padding()
            } .padding()
        }
        .buttonStyle(.plain)
        .frame(height: 50)
        .sheet(isPresented: $isSheetPresented){
            NavigationView {
                VStack{
                    TextField("Content will be generated here...", text: $userGeneratedText.text, axis: .vertical)
                        .font(.largeTitle)
                }
                    .padding()
                    .navigationTitle("Generated Text")
                    .navigationBarItems(
                        leading: Button {UIPasteboard.general.string = userGeneratedText.text} label: {Text("Copy")},
                        trailing: Button {isSheetPresented = false} label: {Text("Cancel")}
                    )
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
