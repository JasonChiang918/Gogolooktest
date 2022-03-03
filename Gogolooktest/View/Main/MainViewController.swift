//
//  MainViewController.swift
//  Gogolooktest
//
//  Created by Chih-Yi Chiang on 2022/3/2.
//

import UIKit
import BetterSegmentedControl
import iOSDropDown
import MHLoadingButton

// 主畫面
class MainViewController: UIViewController {

    // choose view
    @IBOutlet weak var typeControl: BetterSegmentedControl!
    
    @IBOutlet weak var subtypeDropDown: DropDown!
    
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

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func setupUI() {
        // init type control
        self.typeControl.segments = LabelSegment.segments(withTitles: self.viewModel.mainTypes, normalFont: .systemFont(ofSize: 24), normalTextColor: .systemGray, selectedFont: .systemFont(ofSize: 24), selectedTextColor: .white)
        
        // init subtype dropdown
        self.subtypeDropDown.didSelect { (selectedText, index ,id) in
            print("subtype String:\(selectedText) index:\(index)")
            self.viewModel.subtypeIdx = index
            self.goButton.isEnabled = true
        }
        
        // init go button
        self.goButton.indicator = BallPulseSyncIndicator(color: .white)
        
        self.refreshSubtypes()
    }
    
    private func refreshSubtypes() {
        // 0: anime, 1: manga
        self.subtypeDropDown.optionArray = self.viewModel.subTypes
        
        // reset subtype value
        self.subtypeDropDown.selectedIndex = nil
        self.subtypeDropDown.text = nil
        
        // disable go button
        self.goButton.isEnabled = false
    }
    
    @IBAction func onTypeControlChanged(_ sender: BetterSegmentedControl) {
        print("type:\(sender.index)")
        
        self.viewModel.typeIdx = sender.index
        
        self.refreshSubtypes()
    }
    
    
    @IBAction func onGoButtonClick(_ sender: LoadingButton) {
        self.typeControl.isEnabled = false
        self.subtypeDropDown.isEnabled = false
        
        // loading...
        sender.showLoader(userInteraction: false) {}
        
        self.viewModel.fetchGGLBos { gglBo in
            if let gglBo = gglBo {
                print("gglBo:\(gglBo)")
            }
            else {
                print("no data")
                
                let alertController = UIAlertController(title: "", message: "NO data!!!", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .cancel)
                alertController.addAction(okAction)
                self.present(alertController, animated: true)
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                sender.hideLoader {}
                self.typeControl.isEnabled = true
                self.subtypeDropDown.isEnabled = true
            }
        }
    }
    
}

