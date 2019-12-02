//
//  WebKitController.swift
//  MckinleyRice
//
//  Created by Trivial-5 on 12/2/19.
//  Copyright © 2019 Trivial-5. All rights reserved.
//

import UIKit
import WebKit

class WebKitController: UIViewController {

    let sampleURL = "https://mckinleyrice.com?token=\(Network.shared.getAuthorisationToken())*"
//    let sampleURL = "www.google.com"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let webView = WKWebView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        self.view.addSubview(webView)
        webView.load(URLRequest(url: URL(string: sampleURL)!))
    }
}
