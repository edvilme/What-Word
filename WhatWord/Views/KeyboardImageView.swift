//
//  KeyboardImageView.swift
//  WhatWord
//
//  Created by Eduardo  Villalpando  on 18/09/24.
//

import SwiftUI
import PhotosUI
import Accelerate
import Vision

struct KeyboardImageView: View {
    let predictionModel: YOLOv3 = YOLOv3()
    var onWordSubmit: (String) -> Void
    var onWordDelete: () -> Void
    
    @State private var currentWwNode: WWNode = WWNode(externalId: "")
    @State private var selectedItems: [PhotosPickerItem] = []
    @State private var selectedUIImage: UIImage?

    @State private var detectedNodesExternalIds: [String] = []
    
    func predictInput() async -> Void {
        /// Clear detected nodes
        detectedNodesExternalIds = []
        /// Load labels
        guard let labels: [String] = predictionModel.model.modelDescription.classLabels as? [String] else {
            return
        }
        /// Get pixel buffer
        if let pixelBuffer = selectedUIImage?.fit(in: .init(width: 416, height: 416))!.toCVPixelBuffer(format: kCVPixelFormatType_32ARGB) {
            guard let result = try? predictionModel.prediction(image: pixelBuffer, iouThreshold: 0.5, confidenceThreshold: 0.5) else {
                return
            }
            parsePredictions(result: result.confidence, labels: labels)
        }
    }
    
    func parsePredictions(result: MLMultiArray, labels: [String]) -> Void {
        let objectCount = result.shape[0].intValue
        // Iterate objects
        for objectIndex in 0..<objectCount {
            let scores = (0..<labels.count).map {
                result[[objectIndex, $0] as [NSNumber]].doubleValue
            }
            let topLabeledScores = Dictionary(uniqueKeysWithValues: zip(labels, scores))
                .sorted { $0.value > $1.value }
                .prefix(5)
                .map { "ww.node.word.\(translateDrawingClassificationLabel(label: $0.key))" }
            // Append
            detectedNodesExternalIds.append(contentsOf: topLabeledScores)
        }
    }
    
    func reset() {
        selectedItems = []
        selectedUIImage = nil
        detectedNodesExternalIds = []
        currentWwNode = WWNode(externalId: "")
    }
    
    var body: some View {
        VStack{
            KeyboardWordContainerView(
                onWordSubmit: { word in
                    onWordSubmit(word)
                    reset()
                },
                onWordDelete: {
                    if currentWwNode.type != .empty {
                        reset()
                    } else {
                        onWordDelete()
                    }
                },
                deleteKeyIcon: "delete.backward.fill",
                currentWwNode: $currentWwNode
            )
            if (selectedUIImage) != nil {
                Image(uiImage: selectedUIImage!)
                    .resizable()
                    .scaledToFit()
            } else {
                Spacer()
                    .overlay {
                        Text("Select an image to continue")
                            .font(.callout)
                    }
                
            }
            Divider()
            ScrollView(.horizontal){
                HStack {
                    PhotosPicker(selection: $selectedItems, maxSelectionCount: 1, matching: .images){
                        Image(systemName: "photo.badge.plus")
                    }
                        .font(.title3)
                        .buttonStyle(.bordered)
                    ForEach(detectedNodesExternalIds, id: \.self) {externalId in
                        let node = WWNode(externalId: externalId)
                        ButtonKeyWord(node: node, action: {
                            currentWwNode = node
                        })
                    }
                }
                    .padding(.horizontal)
                    .padding(.bottom)
            }
        }
        .onChange(of: selectedItems) {
            Task {
                if let imageData = try? await selectedItems.first?.loadTransferable(type: Data.self){
                    selectedUIImage = UIImage(data: imageData)
                    await predictInput()
                }
            }
        }
    }
}
