//
//  SettingsView.swift
//  WhatWord
//
//  Created by Eduardo  Villalpando  on 23/11/23.
//

import Foundation
import SwiftUI

/// # Settings Page
struct SettingsView: View {
    /// Delete app data?
    @State var shouldShowDeletionConfirmation: Bool = false
    func deleteAppData(){
        if let appDomain = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: appDomain)
            UserDefaults.standard.synchronize()
            loadDefaultPins()
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("App Data"){
                    Button {
                        shouldShowDeletionConfirmation.toggle()
                    } label: {
                        Text("Restore App Data")
                    }   .tint(.red)
                }
                Section("Aknowledgments"){
                    Text("[Joshua Newnham CNN Sketch Classifier](https://github.com/wikibook/coreml) model for sketch classification")
                    Text("[YOLOv3](https://github.com/pjreddie/darknet) for image object detection (beta)")
                    Text("Images fetched from Unsplash API (https://unsplash.com)")
                    Text("Dictionary obtained from system")
                }
                Section("Translations"){
                    Text("More translations coming soon. Reach out to suggest new languages")
                }
                Section{
                    Button("Follow us: @whatwordapp", action: {
                        UIApplication.shared.open(URL(string: "https://x.com/whatwordapp")!)
                    })
                        .buttonStyle(.plain)
                    Text("Designed and developed with <3 by Eduardo Villalpando Mello (@edvilme)")
                    Text("Version \(Bundle.main.infoDictionary?["CFBundleShortVersionString"]! as! String)")
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.large)

        }
            /// Attached alerts and sheets
            .confirmationDialog("Are you sure", isPresented: $shouldShowDeletionConfirmation) {
                Button {
                    deleteAppData()
                } label: {
                    Text("Delete")
                }   .tint(.red)
                Button("Cancel", role: .cancel, action: {})
            }
    }
}
