//
//  HeaderAnimation.swift
//  SwiftToolSet
//
//  Created by cat on 2024/3/14.
//

import SwiftUI

struct HeaderAnimation: View {
    var safeArea: EdgeInsets
    var size: CGSize
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                ArtWork()
                
                GeometryReader { proxy in
                    Button {
                        
                    }label: {
                        Text("SHUFFLE PLAY")
                            .font(.callout)
                            .fontWeight(.bold)
                            .foregroundStyle(Color.white)
                            .padding(.horizontal, 45)
                            .padding(.vertical, 15)
                            .background{
                                Capsule()
                                    .fill(Color.green.gradient)
                            }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .frame(height: 50)
                .padding(.top, -34)
                
                VStack {
                    Text("Popular")
                        .fontWeight(.heavy)
                }
                .padding(.top, 10)
                
                AlbumView()
            }
            //???: alignment 干啥的
            .overlay(alignment: .top) {
                HeaderView()
            }
        }
        .coordinateSpace(name: "SCROLL")
    }

    @ViewBuilder
    func ArtWork() -> some View {
        let height = size.height * 0.45
        GeometryReader { proxy in
            let size = proxy.size
            let minY = proxy.frame(in: .named("SCROLL")).minY
            let progress = minY / (height * (minY > 0 ? 0.5 : 0.8))
            Image("IMG_0006")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size.width, height: size.height + (minY > 0 ? minY : 0))
                .clipped()
                .overlay(content: {
                    ZStack(alignment: .bottom){
                        // MARK: Gradient Overlay
                        Rectangle()
                            .fill(
                                .linearGradient(colors: [
                                    .black.opacity(0 - progress),
                                    .black.opacity(0.1 - progress),
                                    .black.opacity(0.3 - progress),
                                    .black.opacity(0.5 - progress),
                                    .black.opacity(0.8 - progress),
                                    .black.opacity(1),
                                ],startPoint: .top, endPoint: .bottom)
                            )
                        
                        VStack {
                            Text("Jan\nBlomqvist")
                                .font(.system(size: 45))
                                .foregroundStyle(Color.white)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                            
                            Text("456,234 Monthly Listeners".uppercased())
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundStyle(Color.gray)
                                .padding(.top,15)
                        }
                        .opacity(1+(progress > 0 ? -progress : progress))
                        .padding(.bottom, 55)
                        // Moving with scroll
                        .offset(y: minY < 0 ? minY : 0)
                    }
                })
                .offset(y: -minY)
        }
        .frame(height: height + safeArea.top)
    }
    
    @ViewBuilder
    func AlbumView() -> some View {
        VStack(spacing: 25) {
            ForEach(1..<16,id:\.self) { index in
                HStack(spacing: 25) {
                    Text("\(index+1)")
                        .font(.callout)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.gray)
                    VStack(alignment: .leading,spacing: 6) {
                        Text("More")
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.purple)
                        Text("2.344,555")
                            .font(.caption)
                            .foregroundStyle(Color.gray)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Image(systemName: "ellipsis")
                        .foregroundStyle(Color.gray)
                }
            }
            .padding(15)
        }
    }
    
    // MARK: HeaderView
    @ViewBuilder
    func HeaderView() -> some View {
        
        GeometryReader { proxy in
            let minY = proxy.frame(in: .named("SCROLL")).minY
            let height = size.height * 0.45
            let progress = minY / (height * (minY > 0 ? 0.5 : 0.8))

            HStack(spacing: 15) {
                Button {
                    
                }label: {
                    Image(systemName: "chevron.left")
                        .font(.title3)
                        .foregroundStyle(Color.white)
                }
                
                Spacer(minLength: 0)
                
                Button {
                    
                } label: {
                    Text("FOLLOWING")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.white)
                        .padding(.horizontal,10)
                        .padding(.vertical,6)
                        .border(.white, width: 1.5)
                }
                .opacity( 1 + progress)
                
                Button {
                    
                } label: {
                    Image(systemName: "ellipsis")
                        .font(.title3)
                        .foregroundStyle(Color.white)
                    
                }
            }
            .padding(.top, safeArea.top + 10)
            .padding([.horizontal, .bottom], 15)
            .offset(y: -minY)
        }
        .frame(height: 35)
        
    }
}

#Preview {
    HeaderAnimationHome()
}
