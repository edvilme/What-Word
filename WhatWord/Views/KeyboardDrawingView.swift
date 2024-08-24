//
//  KeyboardDrawingView.swift
//  WhatWord
//
//  Created by Eduardo  Villalpando  on 23/08/24.
//

import SwiftUI
import PencilKit

struct DrawingView: UIViewRepresentable {
    @Binding var canvas: PKCanvasView
     
    func makeUIView(context: Context) -> PKCanvasView {
        canvas.drawingPolicy = .anyInput
        canvas.backgroundColor = .systemBackground
        return canvas
    }
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        //
    }
}

struct KeyboardDrawingView: View {
    var onWordSubmit: (String) -> Void
    var onWordDelete: () -> Void
    
    @State var canvas: PKCanvasView = PKCanvasView()
    @State var currentWord = "Hello"
    
    var body: some View {
        VStack{
            KeyboardWordContainerView(
                onWordSubmit: { word in
                    onWordSubmit(word)
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
                currentWord: $currentWord
            )
            DrawingView(canvas: $canvas)
        }
    }
}
