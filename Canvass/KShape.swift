//
//  KShape.swift
//  Canvass
//
//  Created by KAWRANTIN LE GOFF on 05/05/2021.
//

import SwiftUI

class KShape: ObservableObject, Identifiable {
    let id: Int
    
    @Published var x: CGFloat
    @Published var y: CGFloat
    @Published var width: CGFloat
    @Published var height: CGFloat
    
    @Published var color: Color
    
    init(id: Int, x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, color: Color = .blue) {
        self.id = id
        self.x = x
        self.y = y
        self.width = width
        self.height = height
        self.color = color
    }
}
