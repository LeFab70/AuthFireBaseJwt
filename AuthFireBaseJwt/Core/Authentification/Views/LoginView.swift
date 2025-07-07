//
//  LoginView.swift
//  AuthFireBaseJwt
//
//  Created by Fabrice Kouonang on 2025-07-06.
//

import SwiftUI

struct LoginView: View {
    @State var email: String = ""
    @State var password: String = ""
    @EnvironmentObject var viewModel:AuthViewModel
    var body: some View {
        NavigationStack{
            VStack{
                //Image
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .cornerRadius(90)
                    .padding(.vertical,32)
                    
                //form fields
                VStack(spacing: 24){
                    InputView(text: $email, title: "Email", placeholder: "name@example.com")
                        .autocapitalization(.none)
                    InputView(text: $password, title: "Password", placeholder: "Enter your Password",isSecure: true)
                }.padding(.horizontal)
                    .padding(.top,12)
               
                //sign in button
                Button(action: {
                    Task{
                        try await viewModel.signIn(withEmail: email, password: password)
                        //print("\(email) \(password)")
                    }
                }) {
                    HStack{
                      Text("Sign In")
                            .font(.title2.bold())
                        Image(systemName:"arrow.right.circle")
                            .resizable()
                            .frame(width: 20, height: 20)
                    } .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width - 32, height: 50)
                } .background(Color.green)
                    .disabled(!formValid)
                    .opacity(formValid ? 1 : 0.5)
                    .cornerRadius(10)
                    .padding(.top,24)

                Spacer()
                
                //sign up button
                NavigationLink(destination: SignUpView()
                   // .navigationBarBackButtonHidden(true)
                ) {
                    HStack(spacing:3){
                        Text("Don't have an account?")
                        Text("Sign Up")
                            .fontWeight(.bold)
                    }.font(.system(size: 14))
                 
                }
            }
        }
    }
}
extension LoginView:AuthentificationView {
    var formValid: Bool {
       return !email.isEmpty && !password.isEmpty
        && password.count >= 6
        && email.contains("@")
    }
    
    
}
#Preview {
    LoginView()
}
