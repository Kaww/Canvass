//
//  ContentView.swift
//  Canvass
//
//  Created by KAWRANTIN LE GOFF on 05/05/2021.
//

import SwiftUI

struct ContentView: View {
    let canva = CGSize(width: 1000.0, height: 800)
    
    @ObservedObject var viewModel: CanvassViewModel
    @State var selectedShapeId: Int? = nil
    
    init() {
        self.viewModel = CanvassViewModel(in: self.canva)
    }
    
    var body: some View {
        ZStack {
            ZStack(alignment: .topLeading) {
                ForEach(viewModel.shapes) { shape in
                    draw(shape)
                        .onTapGesture {
                            selectedShapeId = shape.id
                        }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            
            ShapeEditorBar(viewModel: viewModel, selectedShapeId: $selectedShapeId)
            
            AddButton(viewModel: viewModel)
        }
        .frame(minWidth: 1000, idealWidth: 1000, maxWidth: .infinity, minHeight: 800, idealHeight: 800, maxHeight: .infinity)
        .background(
            Color.white
                .onTapGesture { selectedShapeId = nil }
        )
        .foregroundColor(.black)
    }
    
    private func draw(_ shape: KShape) -> some View {
        RoundedRectangle(cornerRadius: 10, style: .continuous)
            .frame(width: shape.width, height: shape.height)
            .overlay(
                Text("\(shape.id)")
                    .foregroundColor(.white)
                    .font(.system(size: 50))
            )
            .padding(.leading, shape.x)
            .padding(.top, shape.y)
            .foregroundColor(shape.color)
            .shadow(
                color: .black.opacity(0.4),
                radius: 10,
                x: 0.0,
                y: 0.0
            )
    }
}

struct AddButton: View {
    @ObservedObject var viewModel: CanvassViewModel
    
    var body: some View {
        ZStack {
            Button(action: viewModel.addShape) {
                Circle()
                    .frame(width: 50, height: 50)
                    .foregroundColor(Color.blue.opacity(0.5))
                    .overlay(
                        Image(systemName: "plus")
                            .font(.system(size: 25))
                            .foregroundColor(.white)
                    )
                    
            }
            .buttonStyle(PlainButtonStyle())
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
        .padding()
    }
}

struct ShapeEditorBar: View {
    @ObservedObject var viewModel: CanvassViewModel
    @Binding var selectedShapeId: Int?
    
    private let step: CGFloat = 20
    
    var body: some View {
        HStack {
            Spacer()
            VStack(alignment: .leading) {
                if let id = selectedShapeId,
                   let shape = viewModel.shape(fromId: id) {
                    Text("Editing shape \(shape.id)")
                        .font(.title)
                        .padding(.bottom, 40)
                    
                    Text("Color: \(shape.color.description)")
                    
                    editPositionX(in: shape)
                    editPositionY(in: shape)
                    editWidth(in: shape)
                    editHeight(in: shape)
                    
                    Button("Remove") {
                        viewModel.remove(id: shape.id)
                    }
                    .foregroundColor(.red)
                    
                    Spacer()
                } else {
                    VStack {
                        Spacer()
                        Text("Select a shape to edit it")
                        Spacer()
                    }
                }
            }
            .padding()
            .frame(width: 200)
            .background(
                Color.white
                    .opacity(0.8)
                    .shadow(
                        color: .black.opacity(0.4),
                        radius: 20,
                        x: 0.0,
                        y: 0.0
                    )
            )
        }
    }
    
    private func editPositionX(in shape: KShape) -> some View {
        HStack {
            Text("X: \(Int(shape.x))")
            Spacer()
            Button("-") {
                shape.x = shape.x - step
                viewModel.updateShape(id: shape.id, shape)
            }
            Button("+") {
                shape.x = shape.x + step
                viewModel.updateShape(id: shape.id, shape)
            }
        }
    }
    
    private func editPositionY(in shape: KShape) -> some View {
        HStack {
            Text("Y: \(Int(shape.y))")
            Spacer()
            Button("-") {
                shape.y = shape.y - step
                viewModel.updateShape(id: shape.id, shape)
            }
            Button("+") {
                shape.y = shape.y + step
                viewModel.updateShape(id: shape.id, shape)
            }
        }
    }
    
    private func editWidth(in shape: KShape) -> some View {
        HStack {
            Text("Width: \(Int(shape.width))")
            Spacer()
            Button("-") {
                shape.width = shape.width - step
                viewModel.updateShape(id: shape.id, shape)
            }
            Button("+") {
                shape.width = shape.width + step
                viewModel.updateShape(id: shape.id, shape)
            }
        }
    }
    
    private func editHeight(in shape: KShape) -> some View {
        HStack {
            Text("Height: \(Int(shape.height))")
            Spacer()
            Button("-") {
                shape.height = shape.height - step
                viewModel.updateShape(id: shape.id, shape)
            }
            Button("+") {
                shape.height = shape.height + step
                viewModel.updateShape(id: shape.id, shape)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
