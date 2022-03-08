//
//  TopInfoListVC.swift
//  Gogolooktest
//
//  Created by Chih-Yi Chiang on 2022/3/4.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class TopInfoListVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    final let RowCount = 3.0
    final let CellIdentifier = "TopInfoCell"
    final let FilterViewIdentifier = "TopInfoFilterViewCell"
    final let LoadingIdentifier = "TopInfoLoadingViewCell"
    
    var filterView: TopInfoFilterViewCell?
    var loadingView: TopInfoLoadingViewCell?
    var subtypeViewHeight: CGFloat!
    
    var fetchingData = false
    
    var viewModel: TopInfoListViewModel!
    
    let disposeBag = DisposeBag()
    
    // 建立 TopInfoListVC
    static func instantiate(viewModel: TopInfoListViewModel) -> TopInfoListVC {
        let viewController = TopInfoListVC()
        viewController.viewModel = viewModel
        
        return viewController
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
        self.setupBindings()
    }
    
    // 設定頁面
    private func setupView() {
        self.title = self.viewModel.type.rawValue
        
        self.collectionView.register(UINib.init(nibName: "TopInfoContentViewCell", bundle: nil), forCellWithReuseIdentifier: CellIdentifier)
        self.collectionView.register(UINib.init(nibName: "TopInfoFilterViewCell", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: FilterViewIdentifier)
        self.collectionView.register(UINib.init(nibName: "TopInfoLoadingViewCell", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: LoadingIdentifier)
        
        if let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let space: CGFloat = layout.minimumInteritemSpacing * (RowCount-1) + layout.sectionInset.left + layout.sectionInset.right
            let size: CGFloat = (UIScreen.main.bounds.width - space) / RowCount
            layout.itemSize = CGSize(width: size, height: size * 2.3)
            layout.sectionHeadersPinToVisibleBounds = true
        }
    }
    
    private func setupBindings() {
        // bind loading
        viewModel.loading.subscribe(onNext: { isLoading in
            self.fetchingData = isLoading
            self.filterView?.isUserInteractionEnabled = !isLoading
        
            self.loadingView?.loadingIndicatorView.isHidden = false
            self.loadingView?.endLabel.isHidden = true
            
            if isLoading {
                self.loadingView?.loadingIndicatorView.startAnimating()
            }
            else {
                self.loadingView?.loadingIndicatorView.stopAnimating()
            }
        }).disposed(by: disposeBag)
        
        // bind error
        viewModel.error.subscribe(onNext: { error in
            switch error {
            case .RequestTimeoutError(_):
                print("retry...")
                self.getNextPage()
                
            case .Response404Error(_):
                print("No more page.")
                self.noMorePage()
                self.viewModel.getCurrentTopInfoDic().noMoreData = true
                self.collectionView.reloadData()
                self.fetchingData = false
            
            case .InternetError(let message), .UnknownError(let message):
                let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .cancel) { _ in
                    print("retry...")
                    self.getNextPage()
                }
                alertController.addAction(okAction)
                self.present(alertController, animated: true)
            }
        }).disposed(by: disposeBag)
        
        // bind has next page
        viewModel.hasNextPage.subscribe(onNext: { hasNextPage in
            DispatchQueue.main.async {
                if !hasNextPage {
                    self.viewModel.getCurrentTopInfoDic().noMoreData = true
                    self.noMorePage()
                }
                
                self.collectionView.reloadData()
                self.fetchingData = false
            }
        }).disposed(by: disposeBag)
        
        // bind select subtype
        viewModel.selectSubtype.subscribe(onNext: { subtype in
            print("selected subtype:\(subtype)")
            
            // record before content offset
            self.viewModel.getCurrentTopInfoDic().point = self.collectionView.contentOffset
            
            self.viewModel.subtypeString = subtype.lowercased()
            self.collectionView.reloadData()
            self.collectionView.setContentOffset(self.viewModel.getCurrentTopInfoDic().point, animated: false)
            
            if !self.viewModel.getCurrentTopInfoDic().noMoreData && self.viewModel.getCurrentTopInfoDic().topInfos.isEmpty {
                self.getNextPage()
            }
            else {
                self.noMorePage()
            }
        }).disposed(by: disposeBag)
        
        // bind select sourcetype
        viewModel.selectSourcetype.subscribe(onNext: { sourcetype in
            print("selected sourcetype:\(sourcetype)")
            
            // record before content offset
            self.viewModel.getCurrentTopInfoDic().point = self.collectionView.contentOffset
             
            self.viewModel.sourcetype = (.init(rawValue: sourcetype) ?? .ServerData)
            self.collectionView.reloadData()
            self.collectionView.setContentOffset(self.viewModel.getCurrentTopInfoDic().point, animated: false)
            
            if !self.viewModel.getCurrentTopInfoDic().noMoreData && self.viewModel.getCurrentTopInfoDic().topInfos.isEmpty {
                self.getNextPage()
            }
            else if self.viewModel.sourcetype == .MyFavorite {
                self.noMorePage()
            }
            
            // 只有 server data 可以選 subtype
            self.refreshHeaderView()
        }).disposed(by: disposeBag)
        
        // bind update like
        viewModel.updateLike.subscribe(onNext: { isUpdating in
            if !isUpdating && self.viewModel.sourcetype == .MyFavorite {
                self.collectionView.reloadData()
                self.collectionView.setContentOffset(.zero, animated: false)
            }
        }).disposed(by: disposeBag)
    }
    
    func getNextPage(){
        if fetchingData == true {
            return
        }
        
        fetchingData = true
        
        self.viewModel.fetchNextTopInfos()
    }
    
    func noMorePage() {
        self.loadingView?.loadingIndicatorView.isHidden = true
        self.loadingView?.endLabel.isHidden = false
    }
    
    private func refreshHeaderView() {
        if self.subtypeViewHeight == nil {
            self.subtypeViewHeight = filterView?.subtypeCollectionView.bounds.height
        }
        
        if let subtypeViewHeight = subtypeViewHeight {
            if let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                var headerSize = layout.headerReferenceSize
                if self.viewModel.sourcetype == .MyFavorite {
                    headerSize.height -= subtypeViewHeight
                }
                else {
                    headerSize.height += subtypeViewHeight
                }
                
                layout.headerReferenceSize = headerSize
            }
        }
    }
    
}
