import SwiftUI
import WebKit

struct AcademicStaffView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var isLoading = true
    @State private var showError = false
    @State private var errorMessage = ""
    
    var body: some View {
        VStack(spacing: 0) {
        
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.black)
                }
                
                Spacer()
                
                Text("Academic Staff")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.black)
                
                Spacer()
                
                // Refresh button
                Button(action: {
                    // This will trigger a refresh of the WebView
                    isLoading = true
                }) {
                    Image(systemName: "arrow.clockwise")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.black)
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 15)
            .background(Color.white)
            .shadow(color: .black.opacity(0.1), radius: 1, x: 0, y: 1)
            
            // WebView Content
            ZStack {
                // WebView
                AcademicStaffWebView(
                    isLoading: $isLoading,
                    showError: $showError,
                    errorMessage: $errorMessage
                )
                
                // Loading Indicator
                if isLoading {
                    VStack(spacing: 16) {
                        ProgressView()
                            .scaleEffect(1.2)
                            .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                        
                        Text("Loading Academic Staff...")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.white.opacity(0.9))
                }
                
                // Error State
                if showError {
                    VStack(spacing: 20) {
                        Image(systemName: "wifi.exclamationmark")
                            .font(.system(size: 50))
                            .foregroundColor(.gray)
                        
                        Text("Unable to Load")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                        
                        Text(errorMessage)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)
                        
                        Button(action: {
                            showError = false
                            isLoading = true
                        }) {
                            HStack {
                                Image(systemName: "arrow.clockwise")
                                Text("Try Again")
                            }
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.horizontal, 30)
                            .padding(.vertical, 12)
                            .background(Color.blue)
                            .cornerRadius(25)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.white)
                }
            }
        }
        .navigationBarHidden(true)
        .background(Color.white)
    }
}

struct AcademicStaffWebView: UIViewRepresentable {
    @Binding var isLoading: Bool
    @Binding var showError: Bool
    @Binding var errorMessage: String
    
    func makeUIView(context: Context) -> WKWebView {
        let configuration = WKWebViewConfiguration()
        
        // Enable JavaScript
        configuration.preferences.javaScriptEnabled = true
        
        // Allow inline media playback
        configuration.allowsInlineMediaPlayback = true
        
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.navigationDelegate = context.coordinator
        webView.scrollView.bounces = true
        webView.scrollView.alwaysBounceVertical = true
        
        // Load the NIBM academic staff page
        if let url = URL(string: "https://www.nibm.lk/academic-staff") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
        
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        // Update coordinator reference
        context.coordinator.parent = self
        
        // Handle refresh
        if isLoading && !uiView.isLoading {
            if let url = URL(string: "https://www.nibm.lk/academic-staff") {
                let request = URLRequest(url: url)
                uiView.load(request)
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: AcademicStaffWebView
        
        init(_ parent: AcademicStaffWebView) {
            self.parent = parent
        }
        
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            DispatchQueue.main.async {
                self.parent.isLoading = true
                self.parent.showError = false
            }
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            DispatchQueue.main.async {
                self.parent.isLoading = false
                self.parent.showError = false
            }
        }
        
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            DispatchQueue.main.async {
                self.parent.isLoading = false
                self.parent.showError = true
                self.parent.errorMessage = "Failed to load the webpage. Please check your internet connection and try again."
            }
        }
        
        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            DispatchQueue.main.async {
                self.parent.isLoading = false
                self.parent.showError = true
                
                if let urlError = error as? URLError {
                    switch urlError.code {
                    case .notConnectedToInternet:
                        self.parent.errorMessage = "No internet connection. Please check your network settings."
                    case .timedOut:
                        self.parent.errorMessage = "The request timed out. Please try again."
                    case .cannotFindHost:
                        self.parent.errorMessage = "Cannot reach the server. Please try again later."
                    default:
                        self.parent.errorMessage = "Failed to load the webpage. Please try again."
                    }
                } else {
                    self.parent.errorMessage = "An unexpected error occurred. Please try again."
                }
            }
        }
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            // Allow navigation within the NIBM domain and handle external links
            if let url = navigationAction.request.url {
                if url.host?.contains("nibm.lk") == true {
                    // Allow navigation within NIBM website
                    decisionHandler(.allow)
                } else {
                    // For external links, open in Safari
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url)
                    }
                    decisionHandler(.cancel)
                }
            } else {
                decisionHandler(.allow)
            }
        }
    }
}

// MARK: - Preview
struct AcademicStaffView_Previews: PreviewProvider {
    static var previews: some View {
        AcademicStaffView()
    }
}

// MARK: - Usage Example
struct ContentView: View {
    @State private var showAcademicStaff = false
    
    var body: some View {
        NavigationView {
            VStack {
                Button("Show Academic Staff") {
                    showAcademicStaff = true
                }
                .padding()
            }
            .sheet(isPresented: $showAcademicStaff) {
                AcademicStaffView()
            }
        }
    }
}
