//
//  LoadingView.swift
//  BarrierRush
//
//  Created by Misha Vrana on 22.01.2024.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Checking authorization...")
                    .font(.subheadline)
                    .padding()
                ProgressView()
            }
        }
        .background(Color.white)
        .ignoresSafeArea()
    }
}

#Preview {
    LoadingView()
}
