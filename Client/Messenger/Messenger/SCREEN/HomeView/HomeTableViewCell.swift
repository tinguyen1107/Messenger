//
//  HomeTableViewCell.swift
//  Messenger
//
//  Created by Trọng Tín on 23/07/2021.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    let iconCell: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .clear
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = BaseFont.medium.value(size: 16)
        label.textAlignment = .left
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView ()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setupView ()
    }

    func setupView () {
        self.backgroundColor = .clear
        self.selectionStyle = .none
        
        self.contentView.addSubview(iconCell)
        self.contentView.addSubview(titleLabel)
        
        setupIconCell()
        setupTitleLabel()
    }
    
    private func setupIconCell() {
        iconCell.layer.cornerRadius = 25
        iconCell.layer.masksToBounds = true
        
        iconCell.snp.makeConstraints({
            $0.centerY.equalTo(self)
            $0.left.equalTo(self).offset(10)
            $0.height.equalTo(self).dividedBy(1.2)
            $0.width.equalTo(iconCell.snp.height)
        })
    }
    
    private func setupTitleLabel () {
        titleLabel.sizeToFit()
        
        titleLabel.centerYAnchor.constraint(equalTo: iconCell.centerYAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: iconCell.trailingAnchor, constant: 10).isActive = true
    }
}
