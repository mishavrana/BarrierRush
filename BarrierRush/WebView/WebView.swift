import SwiftUI

struct WebView: View {
    
    @StateObject private var viewModel = WebViewModel()
    
    var body: some View {
        VStack {
            WebViewView(url: URL(string: "https://www.google.com"))
                
        }
        .onAppear {
            Task { await viewModel.regeisterDevice() }
        }
        .alert(isPresented: $viewModel.isShowingRegistrationAlert) {
            getAppropriateAlert()
        }
    }
    
    private func getAppropriateAlert() -> Alert {
        
        switch viewModel.activeAlert {
            
        case .basic:
            Alert(title: Text("Message"))
        case .registrationFalidedAlert:
            Alert(
                title: Text("ERROR"),
                message: Text("\(viewModel.registrationDeviceError?.description ?? "")"),
                dismissButton: .default(Text("Got it!"))
            )
        case .registrationSucceedAlert:
            Alert(
                title: Text("Your app was registered successfully"),
                message: Text("Restart the app to play the game"),
                dismissButton: .default(Text("Got it!"))
            )
        }
    }
}

#Preview {
    WebView()
}
