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
    @State var currentWord = ""
    @State private var generatedImage: UIImage?
    
    @Environment(\.colorScheme) var colorScheme

    func predictInput(canvasView: PKCanvasView) -> Void {
        var image = self.canvas.drawing.image(from: canvasView.drawing.bounds, scale: 10.0)
        if (colorScheme == .dark){
            image = image.invert()
        }
        let trainedImageSize = CGSize(width: 256, height: 256)
        if let resizedImage = image.fit(in: trainedImageSize, background: .white), let pixelBuffer = resizedImage.toCVPixelBuffer() {
            guard let result = try? cnnsketchclassifier().prediction(image: pixelBuffer) else {
                return currentWord = ""
            }
            currentWord = result.classLabel
        }
    }
    var body: some View {
        VStack{
            KeyboardWordContainerView(
                onWordSubmit: { word in
                    onWordSubmit(word)
                    currentWord = ""
                    canvas.drawing = PKDrawing()
                    canvas.backgroundColor = .white
                },
                onWordDelete: {
                    if (canvas.drawing.strokes.isEmpty) {
                        onWordDelete()
                    } else {
                        canvas.drawing = PKDrawing()
                    }
                },
                deleteKeyIcon: $canvas.drawing.strokes.isEmpty ? "delete.backward.fill" : "eraser.fill",
                currentWord: $currentWord
            )
            if (generatedImage != nil) {
                Image(uiImage: generatedImage!)
                    .frame(width: 32.0, height: 32.0)
            }
            DrawingView(canvas: $canvas, onCanvasViewDrawingDidChange: predictInput)
        }
    }
}
