//
//  AuthFireBaseJwtApp.swift
//  AuthFireBaseJwt
//
//  Created by Fabrice Kouonang on 2025-07-06.
//

import SwiftUI
import Firebase

@main
struct AuthFireBaseJwtApp: App {
    @StateObject var viewModel=AuthViewModel()
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
