//
//  BaseDeviceViewController.swift
//  HOPNHAT
//
//  Created by Trọng Tín on 22/06/2021.
//

import UIKit

class BaseDeviceViewController: BaseViewController {

    let titileLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = BaseFont.bold.value(size: 22)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(titileLabel)
        
        setupTitleLabel()
    }
    
    override func handleRightButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func setupTitleLabel () {
        titileLabel.centerYAnchor.constraint(equalTo: leftButton.centerYAnchor).isActive = true
        titileLabel.leadingAnchor.constraint(equalTo: leftButton.trailingAnchor, constant: 10).isActive = true
    }
}
