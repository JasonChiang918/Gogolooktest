//
//  TopInfoFilterViewCell+datasource.swift
//  Gogolooktest
//
//  Created by Chih-Yi Chiang on 2022/3/6.
//

import UIKit

// UICollectionViewDataSource
extension TopInfoFilterViewCell: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return SectionCount
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.rowCount == nil {
            rowCount = abs(self.viewModel.subtypes.count / SectionCount)
        }
        
        return section == SectionCount-1 ? self.viewModel.subtypes.count - section * rowCount : rowCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier, for: indexPath) as? TopInfoFilterViewLabelCell {
            
            cell.wordLabel.text = self.viewModel.subtypes[indexPath.section * rowCount + indexPath.row]
            
            // default select
            if indexPath.section == 0 && indexPath.row == 0 {
                if let selectedItems = collectionView.indexPathsForSelectedItems, selectedItems.isEmpty {
                    collectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
                }
            }
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
}
