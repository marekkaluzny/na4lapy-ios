//
//  PomagajViewController.swift
//  Na4Łapy
//
//  Created by scoot on 04.11.2016.
//  Copyright © 2016 Stowarzyszenie Na4Łapy. All rights reserved.
//

import UIKit
import WebKit

class PomagajViewController: UIViewController {
    @IBOutlet var containerView: UIView!
    var webview: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webview = WKWebView()
        self.webview.frame = self.containerView.frame
        self.containerView.addSubview(self.webview)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //link to API
        if let url = URL(string: "https://api.na4lapy.org:4433/payment/form/shelter/1") {
            let paymentRequest = URLRequest(url: url)
            self.webview.load(paymentRequest)
        }
    }
}
