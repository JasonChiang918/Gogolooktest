//
//  TopInfoFilterViewCell+delegate.swift
//  Gogolooktest
//
//  Created by Chih-Yi Chiang on 2022/3/6.
//

import UIKit

// UICollectionViewDelegate
extension TopInfoFilterViewCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedIdx = indexPath.section * rowCount + indexPath.row
        
        if selectedIdx == self.viewModel.subtypeIdx {
            return
        }
        
        self.viewModel.selectSubtype(idx: selectedIdx)
    }
    
}
