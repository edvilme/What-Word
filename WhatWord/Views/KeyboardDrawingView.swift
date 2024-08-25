//
//  KeyboardDrawingView.swift
//  WhatWord
//
//  Created by Eduardo  Villalpando  on 23/08/24.
//

import Foundation
import Combine
import Vision
import VisionKit
import SwiftUI
import PencilKit

struct DrawingView: UIViewRepresentable {
    @Binding var canvas: PKCanvasView
    var onCanvasViewDrawingDidChange: (PKCanvasView) -> Void
    func makeUIView(context: Context) -> PKCanvasView {
        canvas.drawingPolicy = .anyInput
        canvas.backgroundColor = .white
        canvas.delegate = context.coordinator
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
    @State var currentWord = "Hello"
    @State private var generatedImage: UIImage?
    
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
                    .resizable()
                    .frame(width: 32.0, height: 32.0)
            }
            DrawingView(canvas: $canvas, onCanvasViewDrawingDidChange: { canvasView in
                print("NEW FUNCTION HERE!")
                generatedImage = canvasView.drawing.image(from: canvasView.drawing.bounds, scale: 1)
                let modelConfig = MLModelConfiguration()
                #if targetEnvironment(simulator)
                modelConfig.computeUnits = .cpuOnly
                #endif
                let model = try? DrawingDetection(configuration: modelConfig)
                do {
                    let prediction = try? model?.prediction(input: .init(imageWith: generatedImage!.cgImage!))
                    currentWord = prediction?.target ?? ""
                }
            })
        }
    }
}
