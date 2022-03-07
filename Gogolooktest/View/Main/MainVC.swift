//
//  MainVC.swift
//  Gogolooktest
//
//  Created by Chih-Yi Chiang on 2022/3/2.
//

import UIKit
import RxSwift
import RxCocoa
import BetterSegmentedControl
import MHLoadingButton

// 主畫面
class MainVC: UIViewController {

    @IBOutlet weak var typeControl: BetterSegmentedControl!
    @IBOutlet weak var goButton: LoadingButton!
    
    var viewModel = MainViewModel()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupBindings()
    }
    
    private func setupUI() {
        self.title = "GoGoLook Test"
        
        // init type control
        self.typeControl.segments = LabelSegment.segments(withTitles: MainType.typeStrings, normalFont: .systemFont(ofSize: 24), normalTextColor: .systemGray, selectedFont: .systemFont(ofSize: 24), selectedTextColor: .white)
        
        // init go button
        self.goButton.indicator = BallPulseSyncIndicator(color: .white)
    }
    
    private func setupBindings() {
        // bind loading
        viewModel.loading.subscribe(onNext: { isLoading in
            self.typeControl.isEnabled = !isLoading
            
            if isLoading {
                self.goButton.showLoader(userInteraction: false) {}
            }
            else {
                self.goButton.hideLoader {}
            }
        }).disposed(by: disposeBag)
        
        // bind error
        viewModel.error.subscribe(onNext: { error in
            self.alertError(error: error)
        }).disposed(by: disposeBag)
        
        // bind load datas
        viewModel.topInfos.subscribe(onNext: { topInfos in
            self.goTopInfoList(topInfos: topInfos)
        }).disposed(by: disposeBag)
    }
    
    // choose type
    @IBAction func onTypeControlChanged(_ sender: BetterSegmentedControl) {
        print("type:\(sender.index)")
        
        self.viewModel.type = .init(idx: sender.index)
    }
    
    // go button action
    @IBAction func onGoButtonClick(_ sender: LoadingButton) {
        self.viewModel.fetchTopInfos()
    }
    
    private func goTopInfoList(topInfos: [TopInfo]?) {
        if let topInfos = topInfos, !topInfos.isEmpty {
//            print("topInfos:\(topInfos)")
            
            let viewController = TopInfoListVC.instantiate(viewModel: TopInfoListViewModel(type: viewModel.type, topInfos: topInfos))
            
            self.navigationController?.pushViewController(viewController, animated: true)
        }
        else {
            print("no data")
            
            let alertController = UIAlertController(title: "", message: "NO data!!!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .cancel)
            alertController.addAction(okAction)
            self.present(alertController, animated: true)
        }
    }
    
    private func alertError(error: GGLServiceError) {
        print("fetch topInfos error")
        
        let alertController = UIAlertController(title: "", message: error.message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel)
        alertController.addAction(okAction)
        self.present(alertController, animated: true)
    }
    
}
