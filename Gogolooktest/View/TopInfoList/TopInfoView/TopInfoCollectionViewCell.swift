//
//  TopInfoCollectionViewCell.swift
//  Gogolooktest
//
//  Created by Chih-Yi Chiang on 2022/3/5.
//

import UIKit

class TopInfoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var infoImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    var viewModel: TopInfoCollectionViewModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.layer.cornerRadius = 6.0
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.black.cgColor
        self.contentView.layer.masksToBounds = true

//        self.layer.shadowColor = UIColor.darkGray.cgColor
//        self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
//        self.layer.shadowRadius = 6.0
//        self.layer.shadowOpacity = 0.5
//        self.layer.masksToBounds = true
//        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
       
        self.infoImageView.layer.cornerRadius = 6.0
        self.infoImageView.layer.masksToBounds = true
    }
    
}
