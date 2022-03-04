//
//  TopInfoListViewController.swift
//  Gogolooktest
//
//  Created by Chih-Yi Chiang on 2022/3/4.
//

import UIKit

class TopInfoListViewController: UIViewController {

    var viewModel: TopInfoListViewModel!
    
    // 建立 TopInfoListViewController
    static func instantiate(viewModel: TopInfoListViewModel) -> TopInfoListViewController {
        let viewController = TopInfoListViewController()
        viewController.viewModel = viewModel
        
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 設定頁面
        self.setupView()
    }
    
    // 設定頁面
    private func setupView() {
        
    }
    
}
