//
//  DefaultPins.swift
//  WhatWord
//
//  Created by Eduardo  Villalpando  on 25/08/24.
//

import Foundation

let DEFAULT_PIN_HIERARCHY = [
    "ww.node.root.root": [
        "ww.node.word.\(NSLocalizedString("DEFAULT_YES", comment: "default word"))": [],
        "ww.node.word.\(NSLocalizedString("DEFAULT_NO", comment: "default word"))": [],
        "ww.node.word.\(NSLocalizedString("DEFAULT_DIRECTIONS", comment: "default word"))": [
            "ww.node.word.\( NSLocalizedString("DEFAULT_UP", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_DOWN", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_LEFT", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_RIGHT", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_INSIDE", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_OUTSIDE", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_FRONT", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_BACK", comment: "default word"))"
        ],
        "ww.node.word.\( NSLocalizedString("DEFAULT_HOUSE", comment: "default word"))": [
            "ww.node.word.\( NSLocalizedString("DEFAULT_BED", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_BATHROOM", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_KITCHEN", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_DOOR", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_LIGHTS", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_STAIRS", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_LIVING", comment: "default word"))"
        ],
        "ww.node.word.\( NSLocalizedString("DEFAULT_ACTIVITY", comment: "default word"))": [
            "ww.node.word.\( NSLocalizedString("DEFAULT_EAT", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_DRINK", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_BATH", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_SHOWER", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_SLEEP", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_TV", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_READ", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_SPEAK", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_THERAPY", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_DRESS", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_TRAVEL", comment: "default word"))"
        ],
        "ww.node.word.\( NSLocalizedString("DEFAULT_PLACE", comment: "default word"))": [
            "ww.node.word.\( NSLocalizedString("DEFAULT_HOUSE", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_HOSPITAL", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_SCHOOL", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_STORE", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_MARKET", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_MALL", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_CINEMA", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_BANK", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_PARK", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_DINING", comment: "default word"))"
        ],
        "ww.node.word.\( NSLocalizedString("DEFAULT_THING", comment: "default word"))": [
            "ww.node.word.\( NSLocalizedString("DEFAULT_PHONE", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_KEY", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_WALLET", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_CARD", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_CAR", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_CLOTHES", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_GLASSES", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_PANTS", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_JACKET", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_SHIRT", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_SHOE", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_WATCH", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_PEN", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_REMOTE", comment: "default word"))"
        ],
        "ww.node.word.\( NSLocalizedString("DEFAULT_FEELING", comment: "default word"))": [
            "ww.node.word.\( NSLocalizedString("DEFAULT_HAPPY", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_SAD", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_ANGRY", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_NERVOUS", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_LOVE", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_TIRED", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_PAIN", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_ILL", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_THIRSTY", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_HUNGRY", comment: "default word"))"
        ],
        "ww.node.word.\( NSLocalizedString("DEFAULT_BODY", comment: "default word"))": [
            "ww.node.word.\( NSLocalizedString("DEFAULT_HEAD", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_EYE", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_NOSE", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_MOUTH", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_EARS", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_TOOTH", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_HAND", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_FOOT", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_ARM", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_LEG", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_TORSO", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_KNEE", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_ELBOW", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_FINGER", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_HAIR", comment: "default word"))"
        ],
        "ww.node.word.\( NSLocalizedString("DEFAULT_PEOPLE", comment: "default word"))": [
            "ww.node.word.\( NSLocalizedString("DEFAULT_NURSE", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_FRIEND", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_DOCTOR", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_COOK", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_THERAPIST", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_DRIVER", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_MAN", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_WOMAN", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_CHILD", comment: "default word"))"
        ],
        "ww.node.word.\( NSLocalizedString("DEFAULT_FAMILY", comment: "default word"))": [
            "ww.node.word.\( NSLocalizedString("DEFAULT_WIFE", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_HUSBAND", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_MOTHER", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_FATHER", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_SISTER", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_BROTHER", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_SON", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_DAUGHTER", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_GRANDSON", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_GRANDAUGHTER", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_UNCLE", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_AUNT", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_COUSIN", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_NIECE", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_INLAW", comment: "default word"))"
        ],
        "ww.node.word.\( NSLocalizedString("DEFAULT_EXPRESSION", comment: "default word"))": [
            "ww.node.word.\( NSLocalizedString("DEFAULT_HELLO", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_BYE", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_PLEASE", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_THANKS", comment: "default word"))",
            "ww.node.word.\( NSLocalizedString("DEFAULT_QUESTION", comment: "default word"))"
        ]
    ]
]

func loadDefaultPins() {
    let rootNode = WWNode(externalId: "ww.node.root.root")
    for (category, words) in DEFAULT_PIN_HIERARCHY["ww.node.root.root"]! {
        rootNode.pinnedNodeIds.append(category)
        let categoryNode = WWNode(externalId: category)
        for word in words {
            categoryNode.pinnedNodeIds.append(word)
        }
    }
}
