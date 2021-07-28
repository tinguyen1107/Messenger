//
//  MessageTableViewCell.swift
//  Messenger
//
//  Created by Trọng Tín on 24/07/2021.
//

import UIKit

class MessageTableViewCell: UITableViewCell {
    
    var data: [String]? = ["user", "message: abcdef"]
    /// ["friend", "message: abcdef", "image"]
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 106/255, green: 116/255, blue: 118/255, alpha: 0.8)
        view.layer.cornerRadius = 19
        view.layer.masksToBounds = false
        return view
    }()
    
    let message: UITextView = {
        let tv = UITextView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.isScrollEnabled = false
        tv.backgroundColor = .clear
        tv.textColor = .white
        tv.isEditable = false
        tv.font = BaseFont.bold.value(size: 15)
        return tv
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setup()
    }
    
    private func setup() {
        self.contentView.addSubview(containerView)
        self.contentView.addSubview(message)
        
        if data![0] == "user" {
            containerView.snp.makeConstraints({
                $0.right.equalTo(self.contentView).offset(-5)
            })
            message.textAlignment = .right
        } else if data![0] == "friend" {
            containerView.snp.makeConstraints({
                $0.left.equalTo(self.contentView).offset(5)
            })
            message.textAlignment = .left
        }
        
        containerView.snp.makeConstraints({
            $0.top.equalTo(self.contentView).offset(5)
            $0.bottom.equalTo(self.contentView).offset(-5)
            $0.width.lessThanOrEqualTo(self.contentView).dividedBy(1.5)
            $0.width.greaterThanOrEqualTo(40.5)
        })
        
        message.snp.makeConstraints({
            $0.top.equalTo(containerView).offset(2)
            $0.bottom.equalTo(containerView).offset(-2)
            $0.right.equalTo(containerView).offset(-5)
            $0.left.equalTo(containerView).offset(5)
        })
        
        message.text = data![1]
        message.sizeToFit()
    }

}
