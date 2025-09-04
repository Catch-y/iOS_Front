//
//  ContentView.swift
//  Catchy
//
//  Created by 정의찬 on 1/8/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GlassEffectContainer(content: {
            Text("11")
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Button(action: {
                
            }, label: {
                Text("22")
            })
            .backgroundExtensionEffect()
            .background(.red)
        })
        .padding()
        .backgroundExtensionEffect()
        .background(.yellow)
        
    }
}

#Preview {
    ContentView()
}
