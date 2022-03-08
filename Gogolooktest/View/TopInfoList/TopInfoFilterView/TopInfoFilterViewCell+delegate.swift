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
        if collectionView == self.subtypeCollectionView {
            let selectedIdx = indexPath.section * subtypeRowCount + indexPath.row
        
            if selectedIdx == self.viewModel.subtypeIdx {
                return
            }
        
            self.viewModel.selectSubtype(idx: selectedIdx)
        }
        else if collectionView == self.sourcetypeCollectionView {
            let selectedIdx = indexPath.row
        
            if selectedIdx == self.viewModel.sourcetypeIdx {
                return
            }
        
            self.viewModel.selectSourcetype(idx: selectedIdx)
        }
    }
    
}
