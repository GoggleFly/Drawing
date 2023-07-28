//
//  ContentView.swift
//  Drawing
//
//  Created by David Ash on 17/07/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var petalOffset = -20.0
    @State private var petalWidth = 100.0
    
    @State private var colorCycle = 0.0
    
    @State private var sfxAmount = 0.0
    
    @State private var insetAmount = 50.0
    
    @State private var rows = 4
    @State private var columns = 4
    
    var body: some View {
        TabView {
            NavigationView {
                List {
                    NavigationLink("Triangle") {
                        Triangle()
                            .stroke(.red, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                            .frame(width: 150, height: 150)
                    }
                    
                    NavigationLink("Arc") {
                        Arc(startAngle: .degrees(45), endAngle: .degrees(235), clockwise: true)
                            .strokeBorder(.blue, lineWidth: 60)
                    }
                    
                    NavigationLink("Flower") {
                        VStack {
                            Flower(petalOffset: petalOffset, petalWidth: petalWidth)
                                .fill(.red, style: FillStyle(eoFill: true))
                            
                            Text("Offset")
                            Slider(value: $petalOffset, in: -40...40)
                                .padding([.horizontal, .bottom])
                            
                            Text("Width")
                            Slider(value: $petalWidth, in: 0...100)
                                .padding(.horizontal)
                        }
                    }
                    
                    NavigationLink("ImagePaint") {
                        Capsule()
                            .strokeBorder(ImagePaint(image: Image("Example"), sourceRect: CGRect(x: 0, y: 0.25, width: 1, height: 0.5), scale: 0.3), lineWidth: 20)
                            .frame(width: 300, height: 200)
                    }
                    
                    NavigationLink("ColorCyclingCircle") {
                        VStack {
                            ColorCyclingCircle(amount: colorCycle)
                                .frame(width: 300, height: 300)
                            
                            Slider(value: $colorCycle)
                                .padding([.top, .horizontal])
                        }
                    }
                    
                    NavigationLink("SFX Screen Blend Mode") {
                        VStack {
                            ZStack {
                                Circle()
                                    .fill(Color(red: 1, green: 0, blue: 0))
                                    .frame(width: 200 * sfxAmount)
                                    .offset(x: -50, y: -80)
                                    .blendMode(.screen)
                                
                                Circle()
                                    .fill(Color(red: 0, green: 1, blue: 0))
                                    .frame(width: 200 * sfxAmount)
                                    .offset(x: 50, y: -80)
                                    .blendMode(.screen)
                                
                                Circle()
                                    .fill(Color(red: 0, green: 0, blue: 1))
                                    .frame(width: 200 * sfxAmount)
                                    .blendMode(.screen)
                            }
                            .frame(width: 300, height: 300)
                            
                            Slider(value: $sfxAmount)
                                .padding()
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(.black)
                        .ignoresSafeArea()
                    }
                    
                    NavigationLink("SFX Blur & Saturation") {
                        VStack {
                            Image("PaulHudson")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200, height: 200)
                                .saturation(sfxAmount)
                                .blur(radius: (1 - sfxAmount) * 20)
                            
                            Slider(value: $sfxAmount)
                                .padding()
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(.black)
                        .ignoresSafeArea()
                    }
                }
                .navigationTitle("Drawings")
            }
            .tabItem {
                Label("Drawings", systemImage: "paintbrush.pointed.fill")
            }
            
            
            Trapezoid(insetAmount: insetAmount)
                .frame(width: 200, height: 100)
                .onTapGesture {
                    withAnimation { // relies on animatableData property - see Trapezoid definition
                        insetAmount = Double.random(in: 10...90)
                    }
                }
                .tabItem {
                    Label("Trapezoid", systemImage: "trapezoid.and.line.vertical.fill")
                }
            
            Checkerboard(rows: rows, columns: columns)
                .onTapGesture {
                    withAnimation(.linear(duration: 3)) {
                        rows = 8
                        columns = 16
                    }
                }
                .tabItem {
                    Label("Checkerboard", systemImage: "checkerboard.rectangle")
                }
            
            SpiroView()
                .tabItem {
                    Label("Spiro", systemImage: "circle.hexagonpath")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
