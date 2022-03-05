//
//  MainViewController.swift
//  Gogolooktest
//
//  Created by Chih-Yi Chiang on 2022/3/2.
//

import UIKit
import BetterSegmentedControl
import MHLoadingButton

// 主畫面
class MainViewController: UIViewController {

    // choose view
    @IBOutlet weak var typeControl: BetterSegmentedControl!
    @IBOutlet weak var goButton: LoadingButton!
    
    // view model
    var viewModel: MainViewModel! {
        didSet {
            self.setupUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = MainViewModel()
    }
    
    private func setupUI() {
        self.title = "GoGoLook Test"
        
        // init type control
        self.typeControl.segments = LabelSegment.segments(withTitles: MainType.typeStrings, normalFont: .systemFont(ofSize: 24), normalTextColor: .systemGray, selectedFont: .systemFont(ofSize: 24), selectedTextColor: .white)
        
        // init go button
        self.goButton.indicator = BallPulseSyncIndicator(color: .white)
    }
    
    @IBAction func onTypeControlChanged(_ sender: BetterSegmentedControl) {
        print("type:\(sender.index)")
        
        self.viewModel.type = sender.index == 0 ? .Anime : .Manga
    }
    
    @IBAction func onGoButtonClick(_ sender: LoadingButton) {
        self.typeControl.isEnabled = false
        
        // loading...
        sender.showLoader(userInteraction: false) {}
        
        self.viewModel.fetchTopInfos { topInfos in
            DispatchQueue.main.async {
                if let topInfos = topInfos {
                    print("topInfos:\(topInfos)")
                    
                    let viewController = TopInfoListViewController.instantiate(viewModel: TopInfoListViewModel(mainViewModel: self.viewModel, topInfos: topInfos))
                    
                    self.navigationController?.pushViewController(viewController, animated: true)
                }
                else {
                    print("no data")
                    
                    let alertController = UIAlertController(title: "", message: "NO data!!!", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .cancel)
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true)
                }
                
                sender.hideLoader {}
                self.typeControl.isEnabled = true
            }
        }
    }
    
}
