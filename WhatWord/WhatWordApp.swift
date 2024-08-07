//
//  WhatWordApp.swift
//  WhatWord
//
//  Created by Eduardo  Villalpando  on 19/11/23.
//

import SwiftUI


class UserGeneratedText: ObservableObject {
    @Published var text: String
    init(text: String) {
        self.text = text
    }
}

@main
struct WhatWordApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(UserGeneratedText(text: ""))
        }
    }
}
