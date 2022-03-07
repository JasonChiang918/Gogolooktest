//
//  TopDetailViewController+delegate.swift
//  Gogolooktest
//
//  Created by Chih-Yi Chiang on 2022/3/5.
//

import UIKit
import WebKit

// WKNavigationDelegate
extension TopDetailViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("didFailProvisionalNavigation error:\(error.localizedDescription)")
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("didFail error:\(error.localizedDescription)")
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Strat to load")
        self.loadingIndicatorView.startAnimating()
        backwardButton.isEnabled = webView.canGoBack
        forwardButton.isEnabled = webView.canGoForward
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("finish to load")
        self.loadingIndicatorView.isHidden = true
        self.loadingIndicatorView.stopAnimating()
        backwardButton.isEnabled = webView.canGoBack
        forwardButton.isEnabled = webView.canGoForward
    }
    
}
