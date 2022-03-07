//
//  TopInfoContentView.swift
//  Gogolooktest
//
//  Created by Chih-Yi Chiang on 2022/3/5.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class TopInfoContentViewCell: UICollectionViewCell {
    
    @IBOutlet weak var infoImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    private var heartImage: UIImage!
    private var heartFillImage: UIImage!
    
    var viewModel: TopInfoContentViewModel! {
        didSet {
            self.setupValues()
            self.setupBindings()
        }
    }
    
    let disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setupView()
    }
    
    private func setupView() {
        self.contentView.layer.cornerRadius = 6.0
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.black.cgColor
        self.contentView.layer.masksToBounds = true

        self.infoImageView.layer.cornerRadius = 6.0
        self.infoImageView.layer.masksToBounds = true
        
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular, scale: .small)
        self.heartImage = .init(systemName: "heart", withConfiguration: imageConfig)
        self.heartFillImage = .init(systemName: "heart.fill", withConfiguration: imageConfig)
    }
    
    private func setupBindings() {
        viewModel.updatingLike.subscribe(onNext: { isUpdating in
            print("isUpdating:\(isUpdating)")
            self.favoriteButton.isEnabled = !isUpdating
            
            if !isUpdating {
                self.refreshFavoriteButton()
            }
        }).disposed(by: disposeBag)
    }
    
    private func setupValues() {
        self.titleLabel.text = self.viewModel.title
        self.typeLabel.text = self.viewModel.type
        self.rankLabel.text = self.viewModel.rank
        self.dateLabel.text = self.viewModel.date
        if let imageResource = self.viewModel.imageResource {
            self.infoImageView.kf.setImage(with: imageResource)
        }
        else {
            self.infoImageView.image = nil
        }
        self.refreshFavoriteButton()
    }
    
    private func refreshFavoriteButton() {
        self.favoriteButton.setImage(self.viewModel.isLike ? heartFillImage : heartImage, for: .normal)
    }
    
    @IBAction func onLikeClick(_ sender: Any) {
        self.viewModel.updateLike()
    }
    
}
