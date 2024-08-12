//
//  HomeView.swift
//  ShareLink
//
//  Created by Atharva Waykar on 8/11/24.
//

import SwiftUI

struct Card: Identifiable {
    var id = UUID()
    var name: String
    var jobTitle: String
    var company: String
    var phoneNumber: String
    var email: String
}

struct HomeView: View {
    @State private var receivedCards: [Card] = [
        Card(name: "Bobqwerqwerqwerqwer", jobTitle: "Software Engineer", company: "Tech", phoneNumber: "111-111-1111", email: "bob@gmail.com"),
        Card(name: "Bob", jobTitle: "Software Engineer", company: "Tech", phoneNumber: "111-111-1111", email: "bob@gmail.com"),
        Card(name: "Bob", jobTitle: "Software Engineer", company: "Tech", phoneNumber: "111-111-1111", email: "bob@gmail.com"),
        Card(name: "Bob", jobTitle: "Software Engineer", company: "Tech", phoneNumber: "111-111-1111", email: "bob@gmail.com"),
        Card(name: "Bob", jobTitle: "Software Engineer", company: "Tech", phoneNumber: "111-111-1111", email: "bob@gmail.com"),
  
    ]

    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    ForEach(receivedCards) { card in
                       CardView(card: card)
                            .frame(width: 300, height: 150)
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                            .padding(.bottom, 10)
                            
                    }
                    
                }
               
                .padding()
            }

            Spacer()

            Button(action: {
               
            }) {
                Text("Share My Card")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
        }
        .padding(.top)
    }
}

struct CardView: View {
    var card: Card

    var body: some View {
        VStack(alignment: .leading) {
            Text(card.name)
                .font(.title2)
                .bold()
            
            Text(card.jobTitle)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Text(card.company)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Text("Phone: \(card.phoneNumber)")
                .font(.subheadline)
            
            Text("Email: \(card.email)")
                .font(.subheadline)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .shadow(radius: 5)
        .frame(minWidth: 503,maxWidth: .infinity, maxHeight: .infinity, alignment: .center )
        .scaledToFill()
        
      
    }
}

#Preview {
    HomeView()
}
