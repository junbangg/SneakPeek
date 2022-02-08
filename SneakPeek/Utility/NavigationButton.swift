//
//  NavigationButton.swift
//  SneakPeek
//
//  Created by Jun suk Bang on 2020/11/28.
//  Copyright © 2020 Jun suk Bang. All rights reserved.
//

import SwiftUI

/**
 Custom Navigation Button
 - Referenced: https://stackoverflow.com/questions/58897453/how-to-perform-an-action-after-navigationlink-is-tapped

 */
struct NavigationButton<Destination: View, Label: View>: View {
    // MARK: - Properties
    
    var action: () -> Void = { }
    var destination: () -> Destination
    var label: () -> Label

    @State private var isActive: Bool = false

    // MARK: - View Body
    
    var body: some View {
        Button(action: {
            self.action()
            self.isActive.toggle()
        }) {
            self.label()
              .background(
                ScrollView { // Fixes a bug where the navigation bar may become hidden on the pushed view
                    NavigationLink(destination: LazyDestination { self.destination() },
                                                 isActive: self.$isActive) { EmptyView() }
                }
              )
        }.buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Nested Types

extension NavigationButton {
    // This view lets us avoid instantiating our Destination before it has been pushed.
    private struct LazyDestination<Destination: View>: View {
        var destination: () -> Destination
        var body: some View {
            self.destination()
        }
    }
}

