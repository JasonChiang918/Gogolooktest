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
        if collectionView == self.subtypeCollectionView {
            return SubtypeSectionCount
        }
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.subtypeCollectionView {
            if self.subtypeRowCount == nil {
                subtypeRowCount = abs(self.viewModel.subtypes.count / SubtypeSectionCount)
            }
            
            return section == SubtypeSectionCount-1 ? self.viewModel.subtypes.count - section * subtypeRowCount : subtypeRowCount
        }
        
        return self.viewModel.sourcetypes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier, for: indexPath) as? TopInfoFilterViewLabelCell {
            
            if collectionView == self.subtypeCollectionView {
                cell.wordLabel.text = self.viewModel.subtypes[indexPath.section * subtypeRowCount + indexPath.row]
            }
            else if collectionView == self.sourcetypeCollectionView {
                cell.wordLabel.text = self.viewModel.sourcetypes[indexPath.row]
            }
            
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
