//
//  LandingView.swift
//  OrderingApp
//
//  Created by Rosa Long on 9/5/2024.
//

//import SwiftUI
//
//struct LandingView: View {
//    @State private var isLoading = true
//    @State private var showLogin = false
//    @State private var showRegistration = false
//    @State private var showAppTabView = false //new
//    
//    var body: some View {
//        VStack {
//            if isLoading {
//                LoadingView()
//                    .onAppear {
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
//                            isLoading = false;
//                            showLogin = true
//                        }
//                    }
//            }
//            else if showLogin {
//                LoginView(showRegistration: $showRegistration, showAppTabView: $showAppTabView)
//            }
//            else if showRegistration {
//                RegisterView()
//            }
//            else {
//                Text("Home View")
//            }
//        }
//    }
//}
//
//#Preview {
//    LandingView()
//}
