//
//  TopInfoListViewController.swift
//  Gogolooktest
//
//  Created by Chih-Yi Chiang on 2022/3/4.
//

import UIKit
import SnapKit
import Kingfisher

class TopInfoListViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    final let CellIdentifier = "TopInfoCell"
    final let LoadingIdentifier = "LoadingIndicator"
    
    var viewModel: TopInfoListViewModel!
    
    var loadingView: TopInfoFooterCollectionReusableView?
    var fetchingData = false
    var noMoreData = false
    
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
        self.title = "TOP"
        
        self.collectionView.register(UINib.init(nibName: "TopInfoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: CellIdentifier)
        self.collectionView.register(UINib.init(nibName: "TopInfoFooterCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: LoadingIdentifier)
        
        if let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let space: CGFloat = layout.minimumInteritemSpacing + layout.sectionInset.left + layout.sectionInset.right
            let size: CGFloat = (UIScreen.main.bounds.width - space) / 2.0
            layout.itemSize = CGSize(width: size, height: size * 1.8)
        }
    }
    
    func getNextPage(){
        if fetchingData == true {
            return
        }
        
        fetchingData = true
            
        DispatchQueue.global().async {
            
            sleep(1)
            
            self.viewModel.getTopInfos() { hasNewData in
                DispatchQueue.main.async {
                    if !hasNewData {
                        self.noMoreData = true
                        self.loadingView?.loadingIndicatorView.isHidden = true
                        self.loadingView?.endLabel.isHidden = false
                    }
                
                    self.collectionView.reloadData()
                    self.fetchingData = false
                }
            }
        }
    }
    
}
