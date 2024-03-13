//
//  IndicatorHome.swift
//  SwiftToolSet
//
//  Created by cat on 2024/3/13.
// https://www.bilibili.com/video/BV1Se411v7p5/?vd_source=9be2a622b24d05b50e9951fc391de92b

import SwiftUI

struct IndicatorHome: View {
    @State private var colors: [Color] = [.red, .blue, .green, .yellow]
    @State private var opacityEffect: Bool = false
    @State private var clipEdges: Bool = false
    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                LazyHStack(spacing: 0) {
                    ForEach(colors, id: \.self) { color in
                        RoundedRectangle(cornerRadius: 25.0)
                            .fill(color.gradient)
                            .padding(.horizontal, 15)
                            .containerRelativeFrame(.horizontal) // TODO: 理解这个
                    }
                }
                .scrollTargetLayout() // 配合 viewAligned
                .overlay(alignment: .bottom) {
                    PagingIndicator(
                        activeTint: .white,
                        inActiveTint: .black.opacity(0.25),
                        opacityEffect: opacityEffect,
                        clipEdges: clipEdges
                    )
                }
            }
            .scrollIndicators(.never)
            .scrollTargetBehavior(.viewAligned)
            .frame(height: 220)
            .safeAreaPadding(.vertical, 15)
            .safeAreaPadding(.horizontal, 25)

            List {
                Section("Options") {
                    Toggle("Opacity Effect", isOn: $opacityEffect)
                    Toggle("Clip Edges", isOn: $clipEdges)

                    Button("Add Item") {
                        colors.append(.purple)
                    }
                }
            }
            .clipShape(.rect(cornerRadius: 15))
            .padding(15)
        }
    }
}

#Preview {
    IndicatorHome()
}
