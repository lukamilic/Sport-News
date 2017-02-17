//
//  WebViewController.swift
//  Sports News
//
//  Created by Luka Milic on 2/1/17.
//  Copyright © 2017 Luka Milic. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    var url: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.loadRequest(URLRequest(url: URL(string: url!)!))

    }

}
