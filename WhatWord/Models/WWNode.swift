//
//  WWNode.swift
//  WhatWord
//
//  Created by Eduardo  Villalpando  on 12/08/24.
//

import Foundation
import NaturalLanguage
import Combine
import AVFoundation
import Contacts

enum WWNodeType {
    case root
    case empty
    case word
    case contact
    case data
}

class WWNode: ObservableObject {
    var externalId: String = "ww.node.empty. "
    var name: String = ""
    var type: WWNodeType = .empty
    
    // Internal private stored property to trigger updates
    @Published private var _pinnedNodeIds: [String] = []
    
    // Computed property to access pinnedNodeIds
    var pinnedNodeIds: [String] {
        get {
            return _pinnedNodeIds
        }
        set {
            if (self.type != .data) {
                _pinnedNodeIds = Array(Set(newValue))  // Ensure uniqueness
                UserDefaults.standard.set(_pinnedNodeIds, forKey: externalId)
            }
        }
    }
    
    // For contacts
    var contact: CNContact? = nil
    
    init (externalId: String) {
        if let regexMatches = try! /ww\.node\.(\w+)\.(.+)/.firstMatch(in: externalId) {
            self.externalId = externalId
            _pinnedNodeIds = UserDefaults.standard.array(forKey: externalId) as? [String] ?? []
            switch regexMatches.1 {
                case "data":
                    self.type = .data
                case "contact":
                    self.type = .contact
                case "root":
                    self.type = .root
                default:
                    self.type = .word
            }
            // Contact assign
            if (self.type == .contact) {
                let contactStore = CNContactStore()
                contactStore.requestAccess(for: .contacts, completionHandler: {permissionGranted, error in
                    if (permissionGranted) {
                        self.contact = try? contactStore.unifiedContact(withIdentifier: String(regexMatches.2), keysToFetch: [
                            CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
                            CNContactPhoneNumbersKey as CNKeyDescriptor,
                            CNContactEmailAddressesKey as CNKeyDescriptor,
                        ])
                    }
                })
            }
            // Name
            switch self.type {
            case .data:
                self.name = String(regexMatches.2)
            case .word:
                self.name = String(regexMatches.2)
            case .contact:
                self.name = self.contact != nil ? CNContactFormatter.string(from: self.contact!, style: .fullName)! : ""
            default:
                self.name = ""
            }
        }
    }
        
    func getRelatedNodeExternalIds() -> [String]{
        var relatedNodeExternalIds: [String] = []
        // Word embeddings
        if (type == .word){
            NLEmbedding.wordEmbedding(
                for: NLLanguage(rawValue: NSLocale.current.language.languageCode?.identifier ?? "en_US")
            )?.enumerateNeighbors(
                for: self.name,
                maximumCount: 50
            ) { neighbor, distance in
                relatedNodeExternalIds.append("ww.node.word.\(neighbor)")
                return true
            }
        }
        // Contact
        if (type == .contact && self.contact != nil) {
            for phoneNumber in self.contact!.phoneNumbers {
                relatedNodeExternalIds.append("ww.node.data.\( phoneNumber.value.stringValue )")
            }
            for email in self.contact!.emailAddresses {
                relatedNodeExternalIds.append("ww.node.data.\( email.value )")
            }
        }
        return relatedNodeExternalIds
    }
    
    func speak() -> Void {
        let utterance = AVSpeechUtterance(string: self.name)
        utterance.voice = AVSpeechSynthesisVoice(language: NSLocale.current.language.languageCode?.identifier)
        AVSpeechSynthesizer().speak(utterance)
    }
}
