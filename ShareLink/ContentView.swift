        //
        //  ContentView.swift
        //  ShareLink
        //
        //  Created by Atharva Waykar on 8/10/24.
       

import SwiftUI

struct ContentView: View {
    @State private var name: String = ""
    @State private var jobTitle: String = ""
    @State private var company: String = ""
    @State private var phoneNumber: String = ""
    @State private var email: String = ""

    var body: some View {
        VStack {
            Text("ShareLink")
                .font(.title)
                .padding(.top)

            VStack(alignment: .leading) {
                TextField("Name", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.bottom)

                TextField("Job Title", text: $jobTitle)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.bottom)

                TextField("Company", text: $company)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.bottom)

                TextField("Phone Number", text: $phoneNumber)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.phonePad)
                    .padding(.bottom)

                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.emailAddress)
                    .padding(.bottom)
            }
            .padding(.horizontal)
            Button("Finish") {
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
      

            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

