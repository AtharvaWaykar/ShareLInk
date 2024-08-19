import SwiftUI


struct BluetoothView: View {
   
    var body: some View {
        
        NavigationStack{
            VStack {
               
                Text("Select a Device")
                    .font(.title)
                    .padding()
                ScrollView {
                    VStack {
                      
                        NavigationStack{
                            
                            ForEach(bluetoothManager.peripheralNames, id: \.self) { name in
                                Text(name)
                                    .padding()
                                    .font(.body)
                            }
                        }
                        .navigationTitle("Devices")
                   
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
