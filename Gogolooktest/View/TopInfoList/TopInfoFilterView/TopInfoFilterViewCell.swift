//
//  TopInfoFilterViewCell.swift
//  Gogolooktest
//
//  Created by Chih-Yi Chiang on 2022/3/5.
//

import UIKit

class TopInfoFilterViewCell: UICollectionReusableView {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var subtypeCollectionView: UICollectionView!
    @IBOutlet weak var sourcetypeCollectionView: UICollectionView!
    
    final let CellIdentifier = "TopInfoFilterViewLabelCell"
    final let SubtypeSectionCount = 3
    var subtypeRowCount: Int!
    
    var viewModel: TopInfoFilterViewModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.bgView.layer.cornerRadius = 6.0
        self.bgView.layer.borderWidth = 1.0
        self.bgView.layer.borderColor = UIColor.black.cgColor
        self.bgView.layer.masksToBounds = true
        
        self.subtypeCollectionView.register(UINib.init(nibName: "TopInfoFilterViewLabelCell", bundle: nil), forCellWithReuseIdentifier: CellIdentifier)
        self.sourcetypeCollectionView.register(UINib.init(nibName: "TopInfoFilterViewLabelCell", bundle: nil), forCellWithReuseIdentifier: CellIdentifier)
    }
    
}
