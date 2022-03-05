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
    
    final let RowCount = 3.0
    final let CellIdentifier = "TopInfoCell"
    final let FilterViewIdentifier = "TopInfoFilterViewCell"
    final let LoadingIdentifier = "TopInfoLoadingViewCell"
    
    var viewModel: TopInfoListViewModel!
    
    var filterView: TopInfoFilterViewCell?
    var loadingView: TopInfoLoadingViewCell?
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
        self.title = self.viewModel.type.rawValue
        
        self.collectionView.register(UINib.init(nibName: "TopInfoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: CellIdentifier)
        self.collectionView.register(UINib.init(nibName: "TopInfoFilterViewCell", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: FilterViewIdentifier)
        self.collectionView.register(UINib.init(nibName: "TopInfoLoadingViewCell", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: LoadingIdentifier)
        
        if let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let space: CGFloat = layout.minimumInteritemSpacing * (RowCount-1) + layout.sectionInset.left + layout.sectionInset.right
            let size: CGFloat = (UIScreen.main.bounds.width - space) / RowCount
            layout.itemSize = CGSize(width: size, height: size * 2.4)
        }
    }
    
    func getNextPage(){
        if fetchingData == true {
            return
        }
        
        fetchingData = true
            
        DispatchQueue.global().async {
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
