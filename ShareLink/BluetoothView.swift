import SwiftUI
import CoreNFC

struct BluetoothView: View {
   
    var body: some View {
        
        NavigationStack{
            VStack {
               
                Text("Hold Near Phone")
                    .font(.title)
                    .padding()
                ScrollView {
                    VStack {
                      
          
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



class NFCWriterViewController: UIViewController, NFCNDEFReaderSessionDelegate {
    var nfcSession: NFCNDEFReaderSession?

    func startWriting() {
        guard NFCNDEFReaderSession.readingAvailable else {
            print("NFC is not available on this device")
            return
        }
        nfcSession = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: false)
        nfcSession?.alertMessage = "Hold your iPhone near another NFC-enabled device."
        nfcSession?.begin()
    }

    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        // This function can be used to handle detected NDEFs if necessary
    }

    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        print("NFC Session Invalidated: \(error.localizedDescription)")
    }

    func writeNFCData() {
        let payload = NFCNDEFPayload.wellKnownTypeTextPayload(string: "Business Card Data", locale: Locale.current)!
        let message = NFCNDEFMessage(records: [payload])
        nfcSession?.writeNDEF(message) { error in
            if let error = error {
                print("Failed to write NFC data: \(error.localizedDescription)")
            } else {
                print("Successfully wrote NFC data.")
            }
        }
    }
}

