//
//  WordDrawView.swift
//  WhatWord
//
//  Created by Eduardo  Villalpando  on 23/11/23.
//

import Foundation
import SwiftUI
import PencilKit

struct WordDrawView: View {
    /// Canvas
    @State var canvas: PKCanvasView = PKCanvasView()
    @State var isDrawing: Bool = true
    /// Drawing classification
    @State var drawingClassification: String = ""
    
    /// Process image from canvas to be analyzed by ML model
    func getCanvasImage(canvasView: PKCanvasView) -> UIImage {
        return self.canvas.drawing.image(from: canvasView.drawing.bounds, scale: 10.0)
    }
    /// Get drawing classification
    func getCanvasDrawingClassification(canvasView: PKCanvasView) -> String? {
        // Get image and adjust
        let image = self.getCanvasImage(canvasView: canvasView)
        let sizeTrainedImage = CGSize(width: 256, height: 256)
        if let resizedImage = image.fit(in: sizeTrainedImage, background: .white), let pixelBuffer = resizedImage.toCVPixelBuffer() {
            // Try to get prediction
            guard let predictionResult = try? cnnsketchclassifier().prediction(image: pixelBuffer) else {
                return nil
            }
            // Return prediction
            return predictionResult.classLabel
        }
        return nil
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                WordDrawViewController(canvas: $canvas, isDrawing: $isDrawing)
                // SHow only when there is a classification
                if (drawingClassification != "") {
                    NavigationLink {
                        WordHierarchyView(word: drawingClassification)
                    } label: {
                        WordHierarchyNodeCardView(word: drawingClassification)
                    }   .buttonStyle(.plain)
                }
            }
            /// Navigation options
            .navigationTitle("Draw")
            .navigationBarTitleDisplayMode(.inline)
            // TODO: Replace with `.toolbar`
            .navigationBarItems(
                leading: Button {
                    drawingClassification = getCanvasDrawingClassification(canvasView: canvas) ?? ""
                } label: {
                    Image(systemName: "wand.and.stars")
                },
                trailing: HStack {
                    Button {
                        isDrawing.toggle()
                    } label: {
                        Image(systemName: isDrawing ? "eraser.fill" : "pencil.tip")
                    }
                    Button {
                        canvas.drawing = PKDrawing()
                        drawingClassification = ""
                    } label: {
                        Image(systemName: "goforward")
                    }
                }
            )
        }
    }
}

struct WordDrawViewController: UIViewRepresentable {
    @Binding var canvas: PKCanvasView
    @Binding var isDrawing: Bool
    /// Canvas tools
    let ink = PKInkingTool(.pencil, color: .black, width: 10)
    let eraser = PKEraserTool(.bitmap)
    
    func makeUIView(context: Context) -> PKCanvasView {
        // Allow input without Pencil
        canvas.drawingPolicy = .anyInput
        canvas.tool = isDrawing ? ink : eraser
        return canvas
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        uiView.tool = isDrawing ? ink : eraser
    }
}
