//
//  LoadingView.swift
//  OrderingApp
//
//  Created by Rosa Long on 9/5/2024.
//

import SwiftUI

struct LoadingView: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    @State var isAnimating: Bool = false
    
    var body: some View {
        if isActive {
            AppTabView()
        }
        else {
            VStack {
                VStack {
                    Image(systemName: "mug.fill")
                        .font(.system(size: 80))
                        .foregroundColor(Color("brandColor"))
                    Text("Coffee House")
                        .font(Font.custom("Times New Roman", size: 20))
                        .fontWeight(.semibold)
                        .padding(4)
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeInOut(duration: 2)) {
                        self.size = 0.8
                        self.opacity = 1.0
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

#Preview {
    LoadingView()
        .environmentObject(Cart())
}
