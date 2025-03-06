//
//  ContentView.swift
//  SupabaseMultiEnvironment
//
//  Created by Marcus Buexenstein on 3/6/25.
//

import SwiftUI

struct ContentView: View {
    @State private var email = ""
    @State private var password = ""
    
    @State private var success = false
    
    var body: some View {
        Form {
            if success {
                Image(systemName: "checkmark")
                    .foregroundStyle(.green)
            } else {
                Section {
                    TextField("Enter your email...", text: $email)
                    SecureField("Enter your password...", text: $password)
                }
                
                Button("Sign Up") {
                    Task {
                        await signUpWithEmail(email: email, password: password)
                    }
                }
            }
        }
    }
    
    func signUpWithEmail(email: String, password: String) async {
        do {
            let response = try await supabase.client.auth.signUp(
                email: email,
                password: password
            )
            
            guard let _ = response.session else { return }
            
            success.toggle()
            self.email = ""
            self.password = ""
        } catch {
            print(error.localizedDescription)
        }
    }
}

#Preview {
    ContentView()
}


