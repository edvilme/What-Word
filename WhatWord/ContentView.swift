//
//  ContentView.swift
//  WhatWord
//
//  Created by Eduardo  Villalpando  on 19/11/23.
//

import SwiftUI

struct WordCameraView: View {
    var body: some View {
        Text("Word Camera")
    }
}

struct SettingsView: View {
    var body: some View {
        Text("Settings")
    }
}

struct ContentView: View {
    var body: some View {
        TabView {
            WordHierarchyView()
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
        Text("Hello")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
