//
//  ContactPickerView.swift
//  WhatWord
//
//  Created by Eduardo  Villalpando  on 27/08/24.
//  https://sharaththegeek.substack.com/p/contactpicker-in-swiftui

import Foundation
import SwiftUI
import ContactsUI

public struct ContactPicker: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    var onSelect: (CNContact) -> Void

    public func makeUIViewController(context: Context) -> some UIViewController {
        let navController = UINavigationController()
        let pickerVC = CNContactPickerViewController()
        pickerVC.delegate = context.coordinator
        navController.pushViewController(pickerVC, animated: false)
        navController.isNavigationBarHidden = true
        return navController
    }

    public func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
  
    public func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    public class Coordinator: NSObject, CNContactPickerDelegate {
        var parent: ContactPicker
        init(parent: ContactPicker) {
            self.parent = parent
        }
        public func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        }
        public func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
            parent.onSelect(contact)
        }
    }
}
