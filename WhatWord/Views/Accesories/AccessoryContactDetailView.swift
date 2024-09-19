//
//  ContactDetailView.swift
//  WhatWord
//
//  Created by Eduardo  Villalpando  on 27/08/24.
//

import SwiftUI
import Contacts
import ContactsUI

struct AccessoryContactDetailView : UIViewControllerRepresentable {
    var contact: CNContact?
    typealias UIViewControllerType = CNContactViewController
    func makeUIViewController(context: Context) -> CNContactViewController {
        let vc = CNContactViewController(for: contact!)
        vc.allowsActions = true
        vc.allowsEditing = false
        return vc
    }
    func updateUIViewController(_ uiViewController: CNContactViewController, context: Context) {
    }
}

#Preview {
    AccessoryContactDetailView()
}
