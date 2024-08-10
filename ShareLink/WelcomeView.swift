//
//  WelcomeView.swift
//  ShareLink
//
//  Created by Atharva Waykar on 8/10/24.
//

import SwiftUI

struct WelcomeView: View {
    @State private var name: String = ""
    @State private var jobTitle: String = ""
    @State private var company: String = ""
    @State private var phoneNumber: String = ""
    @State private var email: String = ""
    var body: some View {
        VStack {
            Text("Welcome to ShareLink")
                .font(.title)
                .padding(.top)
           
            
            Button("Set Up") {
                
                print("Name: \(name)")
                print("Job Title: \(jobTitle)")
                print("Company: \(company)")
                print("Phone Number: \(phoneNumber)")
                print("Email: \(email)")
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            
        }
    }
}

#Preview {
    WelcomeView()
}
