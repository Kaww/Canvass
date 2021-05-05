//
//  CanvassViewModel.swift
//  Canvass
//
//  Created by KAWRANTIN LE GOFF on 05/05/2021.
//

import SwiftUI

class CanvassViewModel: ObservableObject {
    @Published var shapes: [KShape] = [
        KShape(id: 1, x: 100, y: 100, width: 200, height: 500, color: .red),
        KShape(id: 2, x: 500, y: 100, width: 150, height: 100, color: .green),
        KShape(id: 3, x: 650, y: 500, width: 200, height: 200)
    ]
    
    let canva: CGSize
    
    init(in canva: CGSize) {
        self.canva = canva
    }
    
    func updateShape(id: Int, _ newShape: KShape) {
        if isShapeValid(newShape),
           let index = shapes.firstIndex(where: { $0.id == id }) {
            shapes[index] = newShape
        }
    }
    
    func shape(fromId id: Int) -> KShape? {
        shapes.first(where: { $0.id == id })
    }
    
    func remove(id: Int) {
        if let index = shapes.firstIndex(where: { $0.id == id }) {
            shapes.remove(at: index)
        }
    }
    
    func addShape() {
        shapes.append(
            KShape(
                id: shapes.count + 1,
                x: canva.width / 2 - 50,
                y: canva.height / 2 - 50,
                width: 100,
                height: 100,
                color: Color(
                    red: .random(in: 0...1),
                    green: .random(in: 0...1),
                    blue: .random(in: 0...1)
                )
            )
        )
    }
    
    func isShapeValid(_ shape: KShape) -> Bool {
        shape.width > 0 && shape.height > 0
    }
}
