//
//  TopInfoListViewController+datasource.swift
//  Gogolooktest
//
//  Created by Chih-Yi Chiang on 2022/3/4.
//

import UIKit
import Kingfisher

// UICollectionViewDataSource
extension TopInfoListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.topInfos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier, for: indexPath) as? TopInfoCollectionViewCell {
            let topInfo = self.viewModel.topInfos[indexPath.row]
            cell.titleLabel.text = topInfo.title
            cell.typeLabel.text = topInfo.type
            cell.rankLabel.text = "\(topInfo.rank)"
            if let imageUrlString = topInfo.image_url, let imageUrl = URL(string: imageUrlString) {
                let resource = ImageResource(downloadURL: imageUrl, cacheKey: imageUrlString)
                cell.infoImageView.kf.setImage(with: resource)
                
            }
            else {
                cell.infoImageView.image = .init(systemName: "book.fill")
            }
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if noMoreData {
            return
        }
        
        if indexPath.row == self.viewModel.topInfos.count-2  {
            self.getNextPage()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            if let aFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: LoadingIdentifier, for: indexPath) as? TopInfoFooterCollectionReusableView {
                loadingView = aFooterView
                loadingView?.backgroundColor = UIColor.clear
                
                return aFooterView
            }
        }
        
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter {
            self.loadingView?.loadingIndicatorView.startAnimating()
        }
    }

    func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter {
            self.loadingView?.loadingIndicatorView.stopAnimating()
        }
    }
    
}
