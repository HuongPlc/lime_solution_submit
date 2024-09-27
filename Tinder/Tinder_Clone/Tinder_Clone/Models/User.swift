//
//  User.swift
//  Tinder_Clone
//
//  Created by Hanh Nguyen Xuan on 26/9/24.
//

import Foundation
import SwiftUI

struct User: Identifiable, Equatable {
    let id = UUID()
    
    let name: String
    let age: Int
    let interest: [String]
    let immages: [Image]
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}
