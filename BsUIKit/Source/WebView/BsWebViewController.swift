//
//  BsWebViewController.swift
//  BsUIKit
//
//  Created by crzorz on 2022/8/24.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import UIKit
import WebKit
import BsFoundation

open class BsWebViewController: BsViewController, WKUIDelegate, WKNavigationDelegate {
    
    open class func setupDefaultWebView() -> WKWebView {
        WKWebView(frame: .zero)
    }
    
    @NullResetable(body: setupDefaultWebView)
    open var webView: WKWebView!
        
    open override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(webView)
        webView.bs.edgesEqualToSuperview()
        webView.uiDelegate = self
        webView.navigationDelegate = self
    }
    
}
