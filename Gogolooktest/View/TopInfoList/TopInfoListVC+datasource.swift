//
//  TopInfoListVC+datasource.swift
//  Gogolooktest
//
//  Created by Chih-Yi Chiang on 2022/3/4.
//

import UIKit
import RxSwift
import Kingfisher

// UICollectionViewDataSource
extension TopInfoListVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let topInfos = self.viewModel.getCurrentTopInfoDic().topInfos
        if let topInfos = topInfos {
            return topInfos.count
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let topInfos = self.viewModel.getCurrentTopInfoDic().topInfos
            
        if let topInfo = topInfos?[indexPath.row], let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier, for: indexPath) as? TopInfoContentViewCell {
            cell.viewModel = TopInfoContentViewModel(topInfo: topInfo)
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if self.viewModel.getCurrentTopInfoDic().noMoreData {
            return
        }
        
        let topInfos = self.viewModel.getCurrentTopInfoDic().topInfos
        
        if let topInfos = topInfos, indexPath.row == topInfos.count-1  {
            self.getNextPage()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            if let filterView = filterView {
                return filterView
            }
            
            if let aHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: FilterViewIdentifier, for: indexPath) as? TopInfoFilterViewCell {
                filterView = aHeaderView
                filterView?.viewModel = TopInfoFilterViewModel(subtypes: self.viewModel.subTypes)
                filterView?.viewModel.selectSubtype
                    .observe(on: MainScheduler.instance)
                    .bind(to: viewModel.selectSubtype)
                    .disposed(by: disposeBag)
                
                return aHeaderView
            }
        }
        else if kind == UICollectionView.elementKindSectionFooter {
            if let loadingView = loadingView {
                return loadingView
            }
            
            if let aFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: LoadingIdentifier, for: indexPath) as? TopInfoLoadingViewCell {
                loadingView = aFooterView
                loadingView?.backgroundColor = UIColor.clear
                
                return aFooterView
            }
        }
        
        return UICollectionReusableView()
    }
    
}
