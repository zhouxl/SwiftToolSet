//
//  MagnifyingClassHome.swift
//  SwiftToolSet
//
//  Created by cat on 2024/3/14.
//

import SwiftUI


struct MagnifyingClassHome: View {
    // Magnification Properties
    @State var scale: CGFloat = 0
    @State var rotation: CGFloat = 0
    @State var size: CGFloat = 0
    
    var body: some View {
        
        
        VStack(spacing: 0) {
            GeometryReader {
                let size = $0.size
                Image("IMG_0006")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: size.width, height: size.height)
                    .magnificationEffect(scale, rotation: rotation, size: self.size, tint: .gray)
            }
            .padding(50)
            .containerShape(Rectangle())
            
            VStack(alignment:.leading, spacing: 0) {
                Text("Customizations")
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.black.opacity(0.5))
                    .padding(.bottom, 20)
                
                HStack {
                    Text("Scale")
                        .font(.caption)
                        .foregroundStyle(Color.gray)
                        .frame(width: 35, alignment: .leading)
                    Slider(value: $scale)
                    
                    Text("Rotation")
                        .font(.caption)
                        .foregroundStyle(Color.gray)
                        .lineLimit(1)
                    Slider(value: $rotation)
                }
                .tint(.black)
                
                HStack {
                    Text("Scale")
                        .font(.caption)
                        .foregroundStyle(Color.gray)
                        .frame(width: 35, alignment: .leading)
                    Slider(value: $size, in: -20...100)
                }
                .tint(.black)
                .padding(.top)
            }
            .padding(15)
            .background {
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .fill(.white)
                    .ignoresSafeArea()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(content: {
            Color.black
                .opacity(0.08)
                .ignoresSafeArea()
        })
        .preferredColorScheme(.light)
    }
}

#Preview {
    MagnifyingClassHome()
}

// MARK: custom view modifier
extension View {
    @ViewBuilder
    func magnificationEffect(_ scale: CGFloat, rotation: CGFloat, size: CGFloat = 0,tint: Color = .white) -> some View {
        MagnificationEffectHelper(scale: scale, rotation: rotation, size: size, tint: tint) {
            self
        }
    }
    
    
}

fileprivate struct MagnificationEffectHelper<Content: View>: View {
    
    var scale: CGFloat
    var rotation: CGFloat
    var size: CGFloat
    var tint: Color = .white
    var content: Content
    
    init(scale: CGFloat, rotation: CGFloat, size: CGFloat,tint: Color,@ViewBuilder content: @escaping ()->Content) {
        self.scale = scale
        self.rotation = rotation
        self.size = size
        self.tint = tint
        self.content = content()
    }
    
    @State var offset: CGSize = .zero
    @State var lastStoredOffset: CGSize = .zero
    
    var body: some View {
        content
            .reverseMask(content: {
                let newCircleSize = 150.0 + size
                Circle()
                    .frame(width: newCircleSize,height: newCircleSize)
                    .offset(offset)
            })
            .overlay {
                GeometryReader {
                    let newCircleSize = 150.0 + size
                    let size = $0.size
                    content
                        // Now Clipping it into Circle Form
                        // Moving Content Inside(Reversing)
                        .offset(x:-offset.width, y:-offset.height)
                        .frame(width: newCircleSize,height: newCircleSize)
                        // Apply Scaling Here
                        .scaleEffect(1+scale)
                        .clipShape(Circle())
                        // Applying offset
                        .offset(offset)
                        // Making it Center
                        .frame(width: size.width, height: size.height)
                    
                    // MARK: optional magnifyingglass Image overlay
                    Circle()
                        .fill(.clear )
                        .frame(width: newCircleSize, height: newCircleSize)
                        .overlay(alignment: .topLeading) {
                            Image(systemName: "magnifyingglass")
                                .resizable()
                                .renderingMode(.template)
                                .aspectRatio(contentMode: .fit)
                                .scaleEffect(1.4, anchor: .topLeading)
                                .offset(x: -10, y: -5)
                                .foregroundStyle(tint)
                        }
                        .rotationEffect(.init(degrees: rotation * 360.0))
                        .offset(offset)
                        .frame(width: size.width, height: size.height)
                }
            }
            .contentShape(Rectangle())
            .gesture(
                DragGesture()
                    .onChanged({ value in
                        offset = CGSize(width: value.translation.width+lastStoredOffset.width, height: value.translation.height+lastStoredOffset.height)
                    })
                    .onEnded({ _ in
                        lastStoredOffset = offset
                    })
            )
    }
}

extension View {
    @ViewBuilder
    func reverseMask<Content: View>(@ViewBuilder content: @escaping ()->Content)-> some View {
        self
            .mask {
                Rectangle()
                    .overlay{
                        content()
                            .blendMode(.destinationOut)
                    }
            }
    }
}
