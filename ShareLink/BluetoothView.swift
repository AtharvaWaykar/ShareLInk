//
//  BluetoothView.swift
//  ShareLink
//
//  Created by Atharva Waykar on 8/13/24.
//
import SwiftUI
import CoreBluetooth

struct BluetoothView: View {
    @StateObject private var bluetoothManager = BluetoothManager()
    var body: some View {
        
        NavigationStack{
            VStack {
               
                Text("Select a Device")
                    .font(.title)
                    .padding()
                ScrollView {
                    VStack {
                        
                        NavigationStack{
                            List(bluetoothManager.discoveredDevices, id: \.identifier) {peripheral
                                Text(peripheral.name)
                          
                        }
                        .navigationTitle("Devices")
                    }
                        
                    }
                    .padding()
                }
            
                Spacer()
            
             
                NavigationLink(destination: HomeView() ){
                    Text("Home")
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

}
class BluetoothManager: NSObject, ObservableObject, CBCentralManagerDelegate {
    @Published var discoveredDevices: [CBPeripheral] = []
    private var centralManager: CBCentralManager?
    @Published var peripheralNames: [String] = []

    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }



    func stopScanning() {
        centralManager?.stopScan()
    }

    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
                 self.centralManager?.scanForPeripherals(withServices: nil)
             }
            print("succes")
    }

    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String: Any], rssi RSSI: NSNumber) {
        if !discoveredDevices.contains(where: { $0.identifier == peripheral.identifier }) {
                   discoveredDevices.append(peripheral)
               }
//        if !discoveredDevices.contains(peripheral) {
//            self.discoveredDevices.append(peripheral)
//            self.peripheralNames.append(peripheral.name ?? "Unnamed Device")
//            //print(peripheral.name)
    //    }
    }
}


#Preview {
    BluetoothView()
}
