//
//  ProfileViewModel.swift
//  Tinder_Clone
//
//  Created by Hanh Nguyen Xuan on 26/9/24.
//

import Foundation

class CardStackViewModel: ObservableObject {
    @Published var actionState = ActionState.none
    @Published var swipeAction = ActionState.none

    @Published var discoverUser: [User] = [
        User(name: "Hanh Nguyen", age: 22, interest: ["football", "gym", "tenis"], immages: [Constants.Images.avUser1, Constants.Images.avUser11]),
        User(name: "Justin", age: 19, interest: ["football", "gym", "tenis"], immages: [Constants.Images.avUser2, Constants.Images.avUser21]),
        User(name: "Sakura chan", age: 30, interest: ["football", "gym", "tenis"], immages: [Constants.Images.avUser3, Constants.Images.avUser31, Constants.Images.avUser32, Constants.Images.avUser33]),
        User(name: "Sakura chan", age: 30, interest: ["football", "gym", "tenis"], immages: [Constants.Images.avUser3, Constants.Images.avUser31, Constants.Images.avUser32, Constants.Images.avUser33]),
        User(name: "Sakura chan", age: 30, interest: ["football", "gym", "tenis"], immages: [Constants.Images.avUser3, Constants.Images.avUser31, Constants.Images.avUser32, Constants.Images.avUser33]),
        User(name: "Sakura chan", age: 30, interest: ["football", "gym", "tenis"], immages: [Constants.Images.avUser3, Constants.Images.avUser31, Constants.Images.avUser32, Constants.Images.avUser33]),
        User(name: "Sakura chan", age: 30, interest: ["football", "gym", "tenis"], immages: [Constants.Images.avUser3, Constants.Images.avUser31, Constants.Images.avUser32, Constants.Images.avUser33]),
    ]

    func removeUser(_ user: User) {
        guard let index = discoverUser.firstIndex(where: { $0.id == user.id }) else {
            return
        }
        
        discoverUser.remove(at: index)
    }
}
