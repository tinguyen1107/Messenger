//
//  AddContainer.swift
//  HOPNHAT
//
//  Created by Trọng Tín on 12/07/2021.
//

import UIKit
import SnapKit

class AddContainer: BaseContainer {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.text = "Add Home"
        label.textAlignment = .left
        label.font = BaseFont.bold.value(size: 22)
        label.textColor = .black
        return label
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle("HUỶ", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleDone), for: .touchUpInside)
        return button
    }()
    
    let addButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle("THÊM", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.modalPresentationStyle = .overFullScreen
        setup()
    }
    
    private func setup () {
        self.containerView.addSubview(titleLabel)
        self.containerView.addSubview(addButton)
        self.containerView.addSubview(cancelButton)
        
        setupTitleLabel()
        setupAddButton()
        setupCancelButton()
    }
    
    private func setupTitleLabel() {
        titleLabel.snp.makeConstraints{ make in
            make.top.equalTo(self.containerView.snp.top).offset(15)
            make.left.equalTo(self.containerView.snp.left).offset(15)
            make.width.equalTo(self.containerView.snp.width).dividedBy(2)
        }
    }
    
    private func setupAddButton() {
        addButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.containerView.snp.bottom).offset(-15)
            make.right.equalTo(self.containerView.snp.right).offset(-15)
            make.width.equalTo(self.containerView.snp.width).dividedBy(4)
            make.height.equalTo(titleLabel.snp.height)
        }
    }
    
    private func setupCancelButton() {
        cancelButton.snp.makeConstraints { make in
            make.bottom.equalTo(addButton.snp.bottom)
            make.right.equalTo(addButton.snp.left).offset(-15)
            make.width.equalTo(addButton.snp.width)
            make.height.equalTo(addButton.snp.height)
        }
    }

    @objc func handleDone() {
        dismissKeyboard()
        dismiss(animated: true, completion: nil)
    }
}
