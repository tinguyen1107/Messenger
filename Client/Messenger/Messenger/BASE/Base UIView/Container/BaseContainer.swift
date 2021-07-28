//
//  BaseContainer.swift
//  HOPNHAT
//
//  Created by Trọng Tín on 16/06/2021.
//

import UIKit
import SnapKit

class BaseContainer: UIViewController {
    
        let containerView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .white
            view.layer.cornerRadius = 7
            view.layer.masksToBounds = true
            return view
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        setup()
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() { view.endEditing(true) }
    
    private func setup() {
        view.backgroundColor = .clear
//            BaseColor.gray_80.value
        self.view.addSubview(containerView)
        setupContainerView()
    }
    
    private func setupContainerView() {
        containerView.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view)
            make.width.equalTo(view).offset(-20)
//            make.height.equalTo(259)
        }
    }
}
