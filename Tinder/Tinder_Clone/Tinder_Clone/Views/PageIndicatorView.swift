//
//  PageIndicatorView.swift
//  Tinder_Clone
//
//  Created by Hanh Nguyen Xuan on 26/9/24.
//

import SwiftUI

struct PageIndicatorView: View {
    @Binding var selectedIndex: Int
    let maxIndex: Int
    
    var body: some View {
        HStack(spacing: 5) {
            ForEach(0 ..< maxIndex, id: \.self) { index in
                Rectangle()
                    .frame(height: 3)
                    .foregroundStyle(index == selectedIndex ? .white : .gray)
            }
        }
        .padding(.horizontal)
    }
}
