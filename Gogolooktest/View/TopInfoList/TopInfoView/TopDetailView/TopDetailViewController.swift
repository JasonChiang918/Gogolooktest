//
//  TopDetailViewController.swift
//  Gogolooktest
//
//  Created by Chih-Yi Chiang on 2022/3/5.
//

import UIKit
import WebKit

class TopDetailViewController: UIViewController {

    var viewModel: TopDetailViewModel!
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var backwardButton: UIBarButtonItem!
    @IBOutlet weak var forwardButton: UIBarButtonItem!
    @IBOutlet weak var loadingIndicatorView: UIActivityIndicatorView!
    
    // 建立 TopDetailViewController
    static func instantiate(viewModel: TopDetailViewModel) -> TopDetailViewController {
        let viewController = TopDetailViewController()
        viewController.viewModel = viewModel
        
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        loadURL()
    }
    
    private func setupUI() {
        self.title = viewModel.detailTitle
        
        self.backwardButton.isEnabled = false
        self.forwardButton.isEnabled = false
        
        self.loadingIndicatorView.isHidden = false
        
        self.webView.navigationDelegate = self
    }
    
    private func loadURL() {
        webView.load(.init(url: viewModel.detailUrl))
        print("load url:\(viewModel.detailUrl)")
    }
        
    @IBAction func onBackwardAction(_ sender: Any) {
        if webView.goBack() == nil {
            print("No more page to back")
        }
    }
    
    @IBAction func onForwardAction(_ sender: Any) {
        if webView.goForward() == nil {
            print("No more page to forward")
        }
    }

}
