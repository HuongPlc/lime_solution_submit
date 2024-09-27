//
//  HomeView.swift
//  Tinder_Clone
//
//  Created by Hanh Nguyen Xuan on 27/9/24.
//

import SwiftUI

struct CardStackView: View {
    @StateObject var viewModel = CardStackViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    ForEach(viewModel.discoverUser) { user in
                        CardView(viewModel: viewModel, user: user)
                            .zIndex(1)
                    }
                }
                ActionView(swipeAction: $viewModel.swipeAction, stateAction: $viewModel.actionState)
                    .offset(CGSize(width: 0, height: -20.0))
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    HStack {
                        Image(.icTinder)
                            .resizable()
                            .frame(width: 30, height: 30)
                        Text("tinder")
                            .foregroundStyle(Color.clPrimary)
                            .font(.title2)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    HStack(spacing: 20) {
                        Image(systemName: "bell.badge.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                        Image(systemName: "slider.horizontal.3")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                    .padding(.trailing, 10)
                }
            }
        }
    }
}

#Preview {
    CardStackView()
}
