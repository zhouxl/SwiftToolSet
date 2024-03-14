//
//  HeaderAnimationHome.swift
//  SwiftToolSet
//
//  Created by cat on 2024/3/14.
//

import SwiftUI

struct HeaderAnimationHome: View {
   
    
    var body: some View {
        GeometryReader {
            let safeArea = $0.safeAreaInsets
            let size = $0.size
            HeaderAnimation(safeArea: safeArea, size: size)
                .ignoresSafeArea(.container, edges: .top)
        }
        
        
    }
}

#Preview {
    HeaderAnimationHome()
}
