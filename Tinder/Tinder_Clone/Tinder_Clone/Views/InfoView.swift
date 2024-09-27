//
//  InfoView.swift
//  Tinder_Clone
//
//  Created by Hanh Nguyen Xuan on 26/9/24.
//

import SwiftUI

struct InfoView: View {
    let user: User
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(user.name)
                    .font(.title)
                    .fontWeight(.bold)
                Text("\(user.age)")
                    .font(.title)
                    .fontWeight(.medium)
                Spacer()
                Button(action: {
                    
                }, label: {
                    Image(systemName: "arrow.up.circle")
                })
            }
            Text("iOS developer")
                .font(.subheadline)
        }
        .foregroundStyle(Color.white)
        .padding()
        .background {
            LinearGradient(colors: [.clear, .black], startPoint: .top, endPoint: .bottom)
        }
    }
}
