//
//  WordDrawView.swift
//  WhatWord
//
//  Created by Eduardo  Villalpando  on 19/11/23.
//

import Foundation
import SwiftUI
import PencilKit
import CoreML
import Vision
import UIKit

struct WordDrawView: View {
    
    func preprocessImage(canvasView: PKCanvasView) -> UIImage{
        let image = self.canvas.drawing.image(from: canvasView.drawing.bounds, scale: 10.0)
        return image
    }
    
    func predictInput(canvasView: PKCanvasView) -> String? {
            let image = self.preprocessImage(canvasView: canvasView)
            let trainedImageSize = CGSize(width: 256, height: 256)
            if let resizedImage = image.fit(in: trainedImageSize, background: .white), let pixelBuffer = resizedImage.toCVPixelBuffer() {
                guard let result = try? cnnsketchclassifier().prediction(image: pixelBuffer) else {
                    return nil
                }
                return result.classLabel
            }
            return nil
        }
    
    @State var canvas = PKCanvasView()
    @State var isDrawing = true
    var body: some View {
        NavigationView{
            VStack{
                _WordDrawView(canvas: $canvas, isDrawing: $isDrawing)
                Text("HI")
                    .navigationTitle("Draw")
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarItems(
                        leading: Button {
                            print(self.predictInput(canvasView: canvas))
                            print("AAA")
                        } label: {
                            Image(systemName: "wand.and.stars")
                        }, trailing: HStack {
                            Button {
                                print("Draw/Erase")
                                isDrawing.toggle()
                            } label: {
                                Image(systemName: isDrawing ? "eraser.fill": "pencil.tip")
                            }
                            Button {
                                canvas.drawing = PKDrawing()
                            } label: {
                                Image(systemName: "delete.left.fill")
                            }
                        }
                    )
            }
        }
    }
}

struct _WordDrawView: UIViewRepresentable {
    @Binding var canvas: PKCanvasView
    @Binding var isDrawing: Bool
    let ink = PKInkingTool(.pencil, color: .black, width: 10)
    let eraser = PKEraserTool(.bitmap)
    
    func makeUIView(context: Context) -> PKCanvasView {
        canvas.drawingPolicy = .anyInput
        canvas.tool = isDrawing ? ink : eraser
        return canvas
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        uiView.tool = isDrawing ? ink : eraser
    }
}
