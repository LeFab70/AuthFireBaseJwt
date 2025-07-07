//
//  ContentView.swift
//  AuthFireBaseJwt
//
//  Created by Fabrice Kouonang on 2025-07-06.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel:AuthViewModel
    var body: some View {
       Group {
            if viewModel.userSession == nil {
                LoginView()
            } else {
                ProfileView()
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthViewModel()) 
}
