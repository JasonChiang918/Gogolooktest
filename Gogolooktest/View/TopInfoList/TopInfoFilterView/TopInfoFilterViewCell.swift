//
//  TopInfoFilterViewCell.swift
//  Gogolooktest
//
//  Created by Chih-Yi Chiang on 2022/3/5.
//

import UIKit

class TopInfoFilterViewCell: UICollectionReusableView {

    @IBOutlet weak var subtypeCollectionView: UICollectionView!
    
    final let CellIdentifier = "TopInfoFilterViewLabelCell"
    
    var viewModel: TopInfoFilterViewModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.subtypeCollectionView.register(UINib.init(nibName: "TopInfoFilterViewLabelCell", bundle: nil), forCellWithReuseIdentifier: CellIdentifier)
    }
    
}
