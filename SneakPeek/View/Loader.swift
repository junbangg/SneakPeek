//
//  Loader.swift
//  SneakPeek
//
//  Created by Jun suk Bang on 2020/12/19.
//  Copyright © 2020 Jun suk Bang. All rights reserved.
//

import SwiftUI

struct Loader: View {
    @State private var isLoading = false
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color(.systemGray5), lineWidth: 14)
                .frame(width: 100, height: 100)
            
            Circle()
                .trim(from: 0, to: 0.2)
                .stroke(MyColors.pantoneBlue, lineWidth: 7) //pantoneBlue //midgrey
                .frame(width: 100, height: 100)
                .rotationEffect(Angle(degrees: isLoading ? 360 : 0))
                .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
                .onAppear() {
                    self.isLoading = true
            }
        }
    }
}

struct Loader_Previews: PreviewProvider {
    static var previews: some View {
        Loader()
    }
}
