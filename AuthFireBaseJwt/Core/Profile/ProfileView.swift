//
//  ProfileView.swift
//  AuthFireBaseJwt
//
//  Created by Fabrice Kouonang on 2025-07-06.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        if let user=viewModel.currentUser{
        List {
            Section{
                HStack(spacing:20){
                    Text(user.initials)
                        .font(.title.bold())
                        .foregroundColor(.white)
                        .frame(width: 72, height: 72)
                        .background(Color(.systemGray))
                        .clipShape(Circle())
                        
                    VStack(alignment: .leading) {
                        Text(user.fullName)
                            .font(.headline)
                            .padding(.top, 5)
                        Text(user.email)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
            }
            Section("General"){
                HStack{
                    SettingsRowView(text: "Version", image:Image(systemName:"gear"), version: "", tintColor: Color(.systemGray))
                    Spacer()
                    Text("1.0.0")
                        .font(.caption)
                        .padding(.trailing, 10)
                        .foregroundStyle(.secondary)
                }
            }
            Section("Account"){
               Button(action: {
                   Task{
                       try await viewModel.signOut()
                   }
                       
               }) {
                   SettingsRowView(text: "Sign Out", image:Image(systemName:"arrow.turn.down.left"), version: "", tintColor: Color(.systemRed))
                }
                   
               Button(action: {
                    Task {
                       try await viewModel.deleteUser()
                   }
                }) {
                    SettingsRowView(text: "Delete Account", image:Image(systemName:"trash"), version: "", tintColor: Color(.systemRed))
                }
                
            }.lineSpacing(.greatestFiniteMagnitude)
        }
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(AuthViewModel())
}
