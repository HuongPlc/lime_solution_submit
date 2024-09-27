//
//  ProfileView.swift
//  Tinder_Clone
//
//  Created by Hanh Nguyen Xuan on 26/9/24.
//

import SwiftUI

struct CardView: View {
    @State var offset: CGSize = .zero
    @State var rotateAngle: CGFloat = 0
    @State var selectedIndexPhoto = 0
    @State var isOutOfImage = false
    @StateObject var viewModel: CardStackViewModel
    let user: User

    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack(alignment: .top) {
                user.immages[selectedIndexPhoto]
                    .resizable()
                    .scaledToFill()
                PageIndicatorView(selectedIndex: $selectedIndexPhoto, maxIndex: user.immages.count)
                    .frame(width: cardWidth)
                    .padding(.top, 10)
                SwipeActionWatermarkView(offset: $offset, screenCutoff: screenCutoff)
                    .frame(width: cardWidth)
                    .padding(.top, 20)
            }
            InfoView(user: user)
                .frame(width: cardWidth)
        }
        .frame(width: cardWidth, height: cardHeight)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .clipped()
        .offset(offset)
        .transformEffect(.init(rotationAngle: rotateAngle))
        .rotation3DEffect(
            .degrees(isOutOfImage ? ((selectedIndexPhoto == user.immages.count - 1) ? 8 : -8) : 0),
            axis: (x: 0.0, y: 0.5, z: 0.0)
        )
        .gesture(
            DragGesture()
                .onChanged(onDragChange)
                .onEnded(onDragEnd)
        )
        .onClickGesture(count: 1, perform: onClick)
        .onReceive(viewModel.$swipeAction, perform: onReceiveSwipeAction)
    }
}

extension CardView {
    var cardWidth: CGFloat {
        Constants.screenWidth - 40
    }

    var cardHeight: CGFloat {
        Constants.screenHeight / 1.5
    }

    var screenCutoff: CGFloat {
        Constants.screenWidth / 2 * 0.75
    }
}

extension CardView {
    func onReceiveSwipeAction(_ value: ActionState) {
        guard user == viewModel.discoverUser.last else {
            return
        }

        switch value {
        case .like:
            moveToRight()
        case .superLike:
            moveToTop()
        case .nope:
            rotateAngle = -0.2
            moveToLeft()
        default:
            break
        }
        rotateAngle = .zero
    }

    func moveToLeft() {
        withAnimation {
            offset = CGSize(width: -600, height: rotateAngle >= 0 ? -200 : 200)
            viewModel.actionState = .none
        } completion: {
            removeCard()
        }
    }

    func moveToRight() {
        withAnimation {
            offset = CGSize(width: 600, height: rotateAngle >= 0 ? 200 : -200)
            viewModel.actionState = .none
        } completion: {
            removeCard()
        }
    }

    func moveToTop() {
        withAnimation {
            offset = CGSize(width: 0, height: -700)
            viewModel.actionState = .none
        } completion: {
            removeCard()
        }
    }

    func moveToCenter() {
        withAnimation {
            offset = .zero
            rotateAngle = .zero
            viewModel.actionState = .none
        }
    }

    func removeCard() {
        viewModel.removeUser(user)
    }

    func getActionState(xShift: CGFloat, yShift: CGFloat) -> ActionState {
        var actionState: ActionState = xShift >= 0 ? .like : .nope
        if yShift <= 0 && abs(yShift) >= abs(xShift) {
            actionState = .superLike
        }

        return actionState
    }
}

extension CardView {
    func onClick(at point: CGPoint) {
        let tapX = point.x
        guard tapX >= 0, tapX <= cardWidth else {
            return
        }
        let maxPhotoIdx = user.immages.count - 1
        let isTapNext = tapX >= (cardWidth / 2)
        if isTapNext && selectedIndexPhoto < maxPhotoIdx {
            selectedIndexPhoto += 1
        } else if !isTapNext && selectedIndexPhoto > 0 {
            selectedIndexPhoto -= 1
        } else if (isTapNext && selectedIndexPhoto == maxPhotoIdx) || (!isTapNext && selectedIndexPhoto == 0) {
            withAnimation(.bouncy(duration: 0.4)) {
                isOutOfImage = true
            } completion: {
                isOutOfImage = false
            }
        }
    }

    func onDragChange(_ value: DragGesture.Value) {
        offset = CGSize(width: value.translation.width, height: value.translation.height)
        let startPoint = value.startLocation
        let xShift = value.translation.width
        let yShift = value.translation.height

        let isTapBottom = startPoint.y >= cardHeight / 2
        let ySide = cardHeight / 2 + Constants.screenHeight * 2 + (isTapBottom ? -yShift : yShift)

        let v1 = CGVector(dx: ySide, dy: xShift)
        let v2 = CGVector(dx: ySide, dy: 0)
        let angle = atan2(v2.dy, v2.dx) - atan2(v1.dy, v1.dx)
        rotateAngle = isTapBottom ? angle : -angle

        viewModel.actionState = getActionState(xShift: xShift, yShift: yShift)
    }

    func onDragEnd(_ value: _ChangedGesture<DragGesture>.Value) {
        withAnimation(.snappy) {
            let actionState = getActionState(xShift: value.translation.width, yShift: value.translation.height)

            if actionState != .superLike && abs(value.translation.width) <= screenCutoff {
                moveToCenter()
                return
            }

            switch actionState {
            case .like:
                moveToRight()
            case .nope:
                moveToLeft()
            case .superLike:
                moveToTop()
            case .none:
                moveToCenter()
            }
        }
    }
}

#Preview {
    CardView(viewModel: CardStackViewModel(), user: User(name: "Dao", age: 22, interest: ["football", "gym", "tenis"], immages: [Image(.avUser1), Image(.avUser11)]))
}

extension View {
    func onClickGesture(
        count: Int,
        coordinateSpace: CoordinateSpace = .local,
        perform action: @escaping (CGPoint) -> Void
    ) -> some View {
        gesture(ClickGesture(count: count, coordinateSpace: coordinateSpace)
            .onEnded(perform: action)
        )
    }
}
