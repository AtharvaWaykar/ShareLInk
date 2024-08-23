import SwiftUI

struct BluetoothView: View {
    @StateObject private var multipeerManager = MultipeerConnectivityManager()
    @State private var messageToSend: String = ""
    @State private var showingBrowser = false
    
    var body: some View {
        NavigationView {
            VStack {
//                List(multipeerManager.receivedMessages, id: \.self) { message in
//                    Text(message)
//                }
//                
                HStack {
                    TextField("Enter message", text: $messageToSend)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button(action: {
                        multipeerManager.sendMessage(messageToSend)
                        messageToSend = ""
                    }) {
                        Text("Send")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                .padding()
                
                HStack {
                    Button("Host Session") {
                        multipeerManager.startHosting()
                    }
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    
                    Button("Join Session") {
                        showingBrowser = true
                    }
                    .padding()
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
                .padding()
                
                List(multipeerManager.connectedPeers, id: \.self) { peer in
                    Text(peer.displayName)
                }
                
            }
            .navigationTitle("Multipeer Chat")
            .sheet(isPresented: $showingBrowser) {
                MultipeerBrowserView(controller: multipeerManager.joinSession())
            }
        }
    }
}

struct MultipeerBrowserView: UIViewControllerRepresentable {
    var controller: MCBrowserViewController
    
    func makeUIViewController(context: Context) -> MCBrowserViewController {
        return controller
    }
    
    func updateUIViewController(_ uiViewController: MCBrowserViewController, context: Context) {}
}
import SwiftUI
import MultipeerConnectivity

class MultipeerConnectivityManager: NSObject, ObservableObject, MCSessionDelegate, MCBrowserViewControllerDelegate {
    @Published var connectedPeers: [MCPeerID] = []
    @Published var receivedCards: [BusinessCard] = []
    
    var peerID: MCPeerID!
    var mcSession: MCSession!
    var mcAdvertiserAssistant: MCAdvertiserAssistant?
    
    override init() {
        super.init()
        peerID = MCPeerID(displayName: UIDevice.current.name)
        mcSession = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)
        mcSession.delegate = self
    }
    
    func startHosting() {
        mcAdvertiserAssistant = MCAdvertiserAssistant(serviceType: "my-app", discoveryInfo: nil, session: mcSession)
        mcAdvertiserAssistant?.start()
    }
    
    func joinSession() -> MCBrowserViewController {
        let mcBrowser = MCBrowserViewController(serviceType: "my-app", session: mcSession)
        mcBrowser.delegate = self
        return mcBrowser
    }
    
    func sendCard(_ card: BusinessCard) {
        guard mcSession.connectedPeers.count > 0 else { return }
        
        if let data = card.toData() {
            do {
                try mcSession.send(data, toPeers: mcSession.connectedPeers, with: .reliable)
            } catch {
                print("Error sending card: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - MCSessionDelegate Methods
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        DispatchQueue.main.async {
            self.connectedPeers = session.connectedPeers
        }
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        if let card = BusinessCard.fromData(data) {
            DispatchQueue.main.async {
                self.receivedCards.append(card)
            }
        }
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {}
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {}
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {}
    
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        browserViewController.dismiss(animated: true, completion: nil)
    }
    
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        browserViewController.dismiss(animated: true, completion: nil)
    }
}


#Preview {
    BluetoothView()
}

