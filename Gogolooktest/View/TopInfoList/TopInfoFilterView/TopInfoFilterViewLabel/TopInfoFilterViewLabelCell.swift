//
//  TopInfoFilterViewLabel.swift
//  Gogolooktest
//
//  Created by Chih-Yi Chiang on 2022/3/6.
//

import UIKit

class TopInfoFilterViewLabelCell: UICollectionViewCell {

    @IBOutlet weak var wordLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.layer.cornerRadius = 6.0
        contentView.layer.masksToBounds = true
        layer.cornerRadius = 6.0
        layer.masksToBounds = false
        
        self.refreshStyle()
    }
    
    override var isSelected: Bool {
        didSet {
            self.refreshStyle()
        }
    }
    
    private func refreshStyle() {
        if isSelected {
            self.wordLabel.textColor = .systemBlue
            
            self.contentView.backgroundColor = UIColor(red: 50.0/256, green: 50.0/256, blue: 50.0/256, alpha: 1.0)
        }
        else {
            self.wordLabel.textColor = .white
            
            self.contentView.backgroundColor = UIColor.clear
        }
        
        
    }
    
}
