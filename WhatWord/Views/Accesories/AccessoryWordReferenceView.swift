//
//  WordReferenceLibraryView.swift
//  WhatWord
//
//  Created by Eduardo  Villalpando  on 04/09/24.
//

import SwiftUI

struct AccessoryWordReferenceView: UIViewControllerRepresentable {
    var term: String
    func makeUIViewController(context: Context) -> UIReferenceLibraryViewController {
        return UIViewControllerType(term: term)
    }
    func updateUIViewController(_ uiViewController: UIReferenceLibraryViewController, context: Context) {
    }
}

#Preview {
    AccessoryWordReferenceView(term: "example")
}
