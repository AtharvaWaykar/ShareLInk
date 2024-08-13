//
//  HomeView.swift
//  ShareLink
//
//  Created by Atharva Waykar on 8/11/24.
//

import SwiftUI
import CoreBluetooth

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
        Card(name: "Bobqwerq", jobTitle: "Software Engineer", company: "Tech", phoneNumber: "111-111-1111", email: "bob@gmail.com"),
        Card(name: "Bob", jobTitle: "Software Engineer", company: "TechCO", phoneNumber: "111-111-1111", email: "bob@gmail.com"),
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
                .frame(maxWidth: .infinity,  alignment: .center )
            
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
        
        
      
    }
}


class BluetoothManager: NSObject, CBPeripheralManagerDelegate, CBCentralManagerDelegate {
    var peripheralManager: CBPeripheralManager?
    var centralManager: CBCentralManager?
    
    override init() {
        super.init()
        peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }

    func startAdvertising() {
        let advertisementData: [String: Any] = [
            CBAdvertisementDataLocalNameKey: "BusinessCard",
            
        ]
        peripheralManager?.startAdvertising(advertisementData)
    }

    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            centralManager?.scanForPeripherals(withServices: nil, options: nil)
        }
    }

    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        if peripheral.state == .poweredOn {
            startAdvertising()
        }
    }

   
}


#Preview {
    HomeView()
}
