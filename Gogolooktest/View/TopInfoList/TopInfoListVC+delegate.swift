//
//  TopInfoListVC+delegate.swift
//  Gogolooktest
//
//  Created by Chih-Yi Chiang on 2022/3/4.
//

import UIKit

// UICollectionViewDelegate
extension TopInfoListVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let topInfos = self.viewModel.getCurrentTopInfoDic().topInfos
        if let topInfo = topInfos?[indexPath.row], let detailUrlString = topInfo.url, let detailUrl = URL(string: detailUrlString) {
            let viewController = TopDetailViewController.instantiate(viewModel: TopDetailViewModel(detailTitle: topInfo.title, detailUrl: detailUrl))
        
            self.navigationController?.pushViewController(viewController, animated: true)
        }
        else {
            print("no detail url")
            
            let alertController = UIAlertController(title: "", message: "NO detail url!!!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .cancel)
            alertController.addAction(okAction)
            self.present(alertController, animated: true)
        }
    }
    
}
