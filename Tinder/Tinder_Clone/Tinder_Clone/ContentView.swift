//
//  ContentView.swift
//  Tinder_Clone
//
//  Created by Hanh Nguyen Xuan on 26/9/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        TabView(selection: $appState.tabIndex) {
            CardStackView()
                .tabItem {
                    Image(.icTinder)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                }
            Text("Second Tab")
                .tabItem {
                    Image(.icTinder)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                }
            Text("Third Tab")
                .tabItem {
                    Image(.icTinder)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AppState())
}
