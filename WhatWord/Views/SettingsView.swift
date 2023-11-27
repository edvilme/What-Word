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
    /// Environment
    @EnvironmentObject private var userGeneratedText: UserGeneratedText
    /// Language
    @State var selectedLanguage: String = "English"
    /// Delete app data?
    @State var shouldShowDeletionConfirmation: Bool = false
    
    func deleteAppData(){
        if let appDomain = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: appDomain)
            UserDefaults.standard.synchronize()
            userGeneratedText.text = ""
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Language"){
                    Picker("Language", selection: $selectedLanguage){
                        Text("English")
                    }
                    Text("More languages coming soon")
                }
                Section("App Data"){
                    Button {
                        shouldShowDeletionConfirmation.toggle()
                    } label: {
                        Text("Delete App Data")
                    }   .tint(.red)
                }
                Section("Aknowledgments"){
                    Text("Joshua Newnham CNN Sketch Classifier (https://github.com/wikibook/coreml) for sketch classification")
                    Text("Images fetched from Unsplash API (https://unsplash.com)")
                }
                Section{
                    Text("@edvilme • Eduardo Villalpando Mello")
                }
            }
        }
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
