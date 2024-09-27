//
//  SwipeActionWatermarkView.swift
//  Tinder_Clone
//
//  Created by Hanh Nguyen Xuan on 26/9/24.
//

import SwiftUI

struct SwipeActionWatermarkView: View {
    @Binding var offset: CGSize
    let screenCutoff: CGFloat
    
    var body: some View {
        HStack {
            Text("LIKE")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(.green)
                .background(
                    RoundedRectangle(cornerRadius: 10).stroke(Color.green, lineWidth: 4)
                    .frame(width: 100, height: 40)
                )
                .rotationEffect(.degrees(-45))
                .opacity(Double(offset.width / screenCutoff))
            
            Spacer()
            
            Text("NOPE")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(.red)
                .background(
                    RoundedRectangle(cornerRadius: 10).stroke(Color.red, lineWidth: 4)
                    .frame(width: 100, height: 40)
                )
                .rotationEffect(.degrees(45))
                .opacity(Double(offset.width / screenCutoff) * -1)
        }
        .padding()
    }
}

#Preview {
    SwipeActionWatermarkView(offset: .constant(CGSize(width: 20, height: 20)), screenCutoff: 1)
}
