//
//  ButtonKeyWord.swift
//  WhatWord
//
//  Created by Eduardo  Villalpando  on 18/09/24.
//

import SwiftUI

struct ButtonKeyWord: View {
    var node: WWNode
    var action: () -> Void
    
    var body: some View {
        Button(node.name, action: action)
            .font(.title3)
            .buttonStyle(.bordered)
            .tint(.primary)
            .labelStyle(.automatic)
            .scrollTransition {effect, phase in
                effect
                    .scaleEffect(phase.isIdentity ? 1 : 0.5)
                    .opacity(phase.isIdentity ? 1 : 0.3)
            }
    }
}

