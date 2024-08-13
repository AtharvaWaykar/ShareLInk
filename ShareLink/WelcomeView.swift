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
        NavigationStack{
            VStack {
                Text("Welcome to ShareLink")
                    .font(.title)
                    .padding(.top)
             
                NavigationLink(destination: ContentView()) {
                    
                    Text("Click")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                
                
            }
        }
    }
}

#Preview {

    WelcomeView()
}
