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
        NavigationView {
            Form {
                Section("App Data"){
                    Button {
                        shouldShowDeletionConfirmation.toggle()
                    } label: {
                        Text("Restore App Data")
                    }   .tint(.red)
                }
                Section("Aknowledgments"){
                    Text("Joshua Newnham CNN Sketch Classifier (https://github.com/wikibook/coreml) for sketch classification")
                    Text("Images fetched from Unsplash API (https://unsplash.com)")
                }
                Section("Translations"){
                    Text("More translations coming soon. Reach out to suggest new languages")
                }
                Section{
                    Text("Designed and developed with <3 by Eduardo Villalpando Mello (@edvilme)")
                        .font(.caption)
                    Text("Version 2.0")
                        .font(.caption2)
                }
            }
        }
            .navigationBarTitleDisplayMode(.large)
            /// Navigation options
            .navigationTitle("Settings")
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
