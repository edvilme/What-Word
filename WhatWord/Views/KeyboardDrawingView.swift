//
//  KeyboardDrawingView.swift
//  WhatWord
//
//  Created by Eduardo  Villalpando  on 23/08/24.
//

import Foundation
import SwiftUI
import PencilKit
import CoreML
import Vision
import UIKit

let TRAINED_IMAGE_SIZE = CGSize(width: 256, height: 256)

struct DrawingView: UIViewRepresentable {
    @Binding var canvas: PKCanvasView
    var onCanvasViewDrawingDidChange: (PKCanvasView) -> Void
    func makeUIView(context: Context) -> PKCanvasView {
        canvas.drawingPolicy = .anyInput
        canvas.backgroundColor = .clear
        canvas.delegate = context.coordinator
        canvas.tool = PKInkingTool(.pencil, color: .black, width: 10)
        return canvas
    }
    func updateUIView(_ uiView: PKCanvasView, context: Context) { }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    class Coordinator: NSObject, PKCanvasViewDelegate {
        var parent: DrawingView
        init(_ parent: DrawingView) {
            self.parent = parent
        }
        func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
            parent.onCanvasViewDrawingDidChange(canvasView)
        }
    }
}

struct KeyboardDrawingView: View {
    var onWordSubmit: (String) -> Void
    var onWordDelete: () -> Void
    
    @State var canvas: PKCanvasView = PKCanvasView()
    @State private var currentWwNode: WWNode = WWNode(externalId: "")
    @State private var generatedImage: UIImage?
    
    @Environment(\.colorScheme) var colorScheme

    func predictInput(canvasView: PKCanvasView) -> Void {
        if self.canvas.drawing.strokes.isEmpty {
            currentWwNode = WWNode(externalId: "")
        } else {
            var image = self.canvas.drawing.image(from: canvasView.drawing.bounds, scale: 10.0)
            if (colorScheme == .dark){
                image = image.invert()
            }
            if let resizedImage = image.fit(in: TRAINED_IMAGE_SIZE, background: .white), let pixelBuffer = resizedImage.toCVPixelBuffer() {
                guard let result = try? cnnsketchclassifier().prediction(image: pixelBuffer) else {
                    return currentWwNode = WWNode(externalId: "")
                }
                currentWwNode = WWNode(externalId: "ww.node.word.\(translateDrawingClassificationLabel(label: result.classLabel))")
            }
        }
    }
    var body: some View {
        VStack{
            KeyboardWordContainerView(
                onWordSubmit: { word in
                    onWordSubmit(word)
                    currentWwNode = WWNode(externalId: "")
                    canvas.drawing = PKDrawing()
                },
                onWordDelete: {
                    if (canvas.drawing.strokes.isEmpty) {
                        onWordDelete()
                    } else {
                        canvas.drawing = PKDrawing()
                    }
                },
                deleteKeyIcon: $canvas.drawing.strokes.isEmpty ? "delete.backward.fill" : "eraser.fill",
                currentWwNode: $currentWwNode
            )
            if (generatedImage != nil) {
                Image(uiImage: generatedImage!)
                    .frame(width: 32.0, height: 32.0)
            }
            DrawingView(canvas: $canvas, onCanvasViewDrawingDidChange: predictInput)
        }
    }
}
