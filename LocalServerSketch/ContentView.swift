//
//  ContentView.swift
//  LocalServerApp
//
//  Created by HIROAKI YAMANE on 15/03/2021.
//

import SwiftUI
import GCDWebServers
import WebKit

struct WebView: UIViewRepresentable {
  let request: URLRequest
    var webServer: GCDWebServer = GCDWebServer()
    let folderPath = Bundle.main.path(forResource: "site", ofType: nil)!
    func initServer() {
        print(self.folderPath)
        webServer.addGETHandler(forBasePath: "/", directoryPath: self.folderPath, indexFilename: nil, cacheAge: 3600, allowRangeRequests: true)
        webServer.start(withPort: 5000, bonjourName: "GCD Web Server")
        
    }
  func makeUIView(context: Context) -> WKWebView  {
    
    self.initServer()
      return WKWebView()
  }
    
  func updateUIView(_ uiView: WKWebView,  context: Context) {
    let _req = URLRequest(url: webServer.serverURL!)
    uiView.load(_req)
  }
}


struct ContentView: View {
    let url: String = "http://localhost:5000/"
    var body: some View {
        WebView(request: URLRequest(url: URL(string:url)!)).statusBar(hidden: true)
            .edgesIgnoringSafeArea(.all)

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
