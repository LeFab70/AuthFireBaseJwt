//
//  SignUpView.swift
//  AuthFireBaseJwt
//
//  Created by Fabrice Kouonang on 2025-07-06.
//

import SwiftUI

struct SignUpView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var fullName: String = ""
    @State var confirmPassword: String = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var authViewModel: AuthViewModel
    var body: some View {
       VStack {
           Image(systemName: "person.badge.plus")
               .resizable()
               .frame(width: 100, height: 100)
               .scaledToFit()
               .foregroundColor(.green)
               .padding()
               .padding(.vertical,32)
              
           VStack(spacing: 24){
               InputView(text: $email, title: "Email", placeholder: "name@example.com")
                   .autocapitalization(.none)
               InputView(text: $fullName, title: "Full Name", placeholder: "Enter your full name")
               InputView(text: $password, title: "Password", placeholder: "Enter your Password",isSecure: true)
               ZStack(alignment: .trailing)
               {
                  InputView(text: $confirmPassword, title: "", placeholder: "Confirm Password",isSecure: true)
                   if !password.isEmpty && !confirmPassword.isEmpty{
                       if password == confirmPassword{
                           Image(systemName: "checkmark.circle.fill")
                               .imageScale(.large)
                               .fontWeight(.bold)
                               .foregroundColor(.green)
                       }
                       
                       else
                       {
                           Image(systemName: "xmark.circle.fill")
                               .imageScale(.large)
                               .fontWeight(.bold)
                               .foregroundColor(.red)
                       }
                   }
               }
           }.padding(.horizontal)
               .padding(.top,12)
          
           //sign in button
           Button(action: {
               Task{
                   try await authViewModel.createUser(withEmail: email, password: password, fullName: fullName)
                   //dismiss()
               }
               //print("\(email) \(password)")
              
           }) {
               HStack(spacing:12){
                 Text("Sign Up")
                       .font(.title2.bold())
            
                   Image(systemName:"person.crop.circle.fill")
                       .resizable()
                       .frame(width: 20, height: 20)
                 
               } .font(.headline)
                   .foregroundColor(.white)
                   .frame(width: UIScreen.main.bounds.width - 32, height: 50)
           } .background(Color.green)
               .disabled(!formValid)
               .shadow(radius: 8)
               .opacity(formValid ? 1 : 0.5)
               .cornerRadius(10)
               .padding(.top,24)

           Spacer()
            
        }
      // .navigationBarBackButtonHidden(true)
       .toolbar {
           ToolbarItem(placement: .topBarLeading) {
               Button(action:{dismiss()}) {
                  HStack{
                       Text("to sign in")
                      // .font(.caption)
                      Image(systemName: "person.crop.circle")
                   }
               }
           }
          
       }
    }
}

extension SignUpView:AuthentificationView {
    var formValid: Bool {
        return !email.isEmpty && !password.isEmpty && password.count >= 6
        && !confirmPassword.isEmpty && confirmPassword == password
        && !fullName.isEmpty
        && email.contains("@")
    }
    
    
}
#Preview {
    SignUpView()
}
