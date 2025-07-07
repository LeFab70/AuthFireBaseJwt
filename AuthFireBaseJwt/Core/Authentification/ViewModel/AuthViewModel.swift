//
//  AuthViewModel.swift
//  AuthFireBaseJwt
//
//  Created by Fabrice Kouonang on 2025-07-07.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore
protocol AuthentificationView{
    var formValid: Bool { get }
}
@MainActor
class AuthViewModel:ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    init() {
        self.userSession=Auth.auth().currentUser
        Task {
                    try? await fetchUserProfile()
                }
    }
    
    func signIn(withEmail email:String,password:String) async throws {
        //print("Sign in with email: \(email) and password: \(password)")
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession=result.user
            try await fetchUserProfile()
        }
             catch {
       
            print("Error signing in: \(error.localizedDescription)")
        }
    }
    func signOut() async throws {
        do {
            try  Auth.auth().signOut()
            self.userSession=nil
            self.currentUser=nil
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
    func createUser(withEmail email:String,password:String, fullName: String) async throws {
        //print ("Create user with email: \(email), password: \(password), fullName: \(fullName)")
        do{
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            //await MainActor.run {
                self.userSession=result.user
            //}
            let user=User(id: result.user.uid, fullName: fullName, email: email)
            let encodeUser=try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodeUser)
            try await fetchUserProfile()
            //print("User created: \(result.user)")
        }catch {
            print("Error creating user: \(error.localizedDescription)")
        }
    }
    func deleteUser() async throws {
        do {
            try await Auth.auth().currentUser?.delete()
            self.userSession=nil
            self.currentUser=nil
        } catch {
            print("Error deleting user: \(error.localizedDescription)")
        }
        
    }
    func fetchUserProfile() async throws {
        guard let uid=Auth.auth().currentUser?.uid else { return }
        //guard let uid = userSession?.uid else { return }
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument()
                else { return }
        self.currentUser = try? snapshot.data(as: User.self)
    }
}
