//
//  ButtonBar.swift
//  HPTrivia
//
//  Created by ceboi on 25/02/26.
//

import SwiftUI

struct ButtonBar: View {
    let geo: GeometryProxy
    @Binding var animateViewIn: Bool
    var body: some View {
        HStack {
            Spacer()
            InstructionsButton(animateViewIn: $animateViewIn, geo: geo)
            Spacer()
            PlayButton(animateViewIn: $animateViewIn, geo: geo)
            Spacer()
            SettingsButton(animateViewIn: $animateViewIn, geo: geo)
            Spacer()
        }
        .frame(width: geo.size.width)
    }
}

#Preview {
    GeometryReader { geo in
        ButtonBar(geo: geo, animateViewIn: .constant(true))
    }
}
