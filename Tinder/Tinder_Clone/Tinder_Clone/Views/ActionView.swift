//
//  ActionView.swift
//  Tinder_Clone
//
//  Created by Hanh Nguyen Xuan on 27/9/24.
//

import SwiftUI

struct ActionView: View {
    @Binding var swipeAction: ActionState
    @Binding var stateAction: ActionState
    private let highlighScaleFactor = CGSize(width: 1.2, height: 1.2)
    private let normalScaleFactor = CGSize(width: 1.0, height: 1.0)
    
    private let iconWidth: CGFloat = 25
    
    enum ButtonType {
        case like
        case superLike
        case nope
    }
    
    var body: some View {
        HStack(spacing: 40) {
            Button(action: {
                swipeAction = .nope
            }, label: {
                Image(systemName: "xmark")
                    .resizable()
                    .fontWeight(.heavy)
                    .foregroundStyle(.red)
                    .background {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 2 * iconWidth, height: 2 * iconWidth)
                            .shadow(radius: 10)
                    }
            })
            .frame(width: iconWidth, height: iconWidth)
            .scaleEffect(scaleFactor(.nope), anchor: .center)
            .buttonStyle(PlainButtonStyle())
            
            Button(action: {
                swipeAction = .superLike
            }, label: {
                Image(systemName: "star.fill")
                    .resizable()
                    .foregroundStyle(.blue)
                    .background {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 1.6 * iconWidth, height: 1.6 * iconWidth)
                            .shadow(radius: 10)
                    }
            })
            .frame(width: iconWidth / 1.2, height: iconWidth / 1.2)
            .scaleEffect(scaleFactor(.superLike), anchor: .center)
            .buttonStyle(PlainButtonStyle())
            
            Button(action: {
                swipeAction = .like
            }, label: {
                Image(systemName: "heart.fill")
                    .resizable()
                    .foregroundStyle(.green)
                    .background {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 2 * iconWidth, height: 2 * iconWidth)
                            .shadow(radius: 10)
                    }
            })
            .frame(width: iconWidth, height: iconWidth)
            .scaleEffect(scaleFactor(.like), anchor: .center)
            .buttonStyle(PlainButtonStyle())
        }
        
    }
    
    func scaleFactor(_ button: ButtonType) -> CGSize {
        withAnimation(.bouncy(duration: 0.5)) {
            switch button {
            case .like:
                return stateAction == .like ? highlighScaleFactor : (stateAction == .none ? normalScaleFactor : .zero)
            case .superLike:
                return stateAction == .superLike ? highlighScaleFactor : (stateAction == .none ? normalScaleFactor : .zero)
            case .nope:
                return stateAction == .nope ? highlighScaleFactor : (stateAction == .none ? normalScaleFactor : .zero)
            }
        }
        
    }
}

#Preview {
    @State var swipeAction = ActionState.none
    @State var stateAction = ActionState.none
    return ActionView(swipeAction: $swipeAction, stateAction: $stateAction)
}
