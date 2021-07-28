//
//  BaseViewController.swift
//  HOPNHAT
//
//  Created by Trọng Tín on 18/06/2021.
//

import UIKit

class BaseViewController: UIViewController {
    
    let backgroundImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.alpha = 0.8
        imageView.image = UIImage(named: "background_5")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        Support().blurEffect(imageView: imageView, completion: {
            imageView = $0
        })
        return imageView
    }()
    
    let titleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let leftButton: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleRightButton), for: .touchUpInside)
        return button
    }()
    
    @objc func handleRightButton() { }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView () {
        self.navigationController?.navigationBar.isHidden = true
        
        self.view.backgroundColor = .black
        self.view.addSubview(backgroundImageView)
        self.view.addSubview(titleView)
        
        setupBackgroundImageView()
        setupTitleView()
    }
    
    private func setupBackgroundImageView () {
        backgroundImageView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    private func setupTitleView () {
        titleView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        titleView.heightAnchor.constraint(equalToConstant: self.view.frame.height * 0.1).isActive = true
        titleView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        titleView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    
        titleView.addSubview(leftButton)
        
        leftButton.centerYAnchor.constraint(equalTo: titleView.centerYAnchor).isActive = true
        leftButton.leadingAnchor.constraint(equalTo: titleView.leadingAnchor, constant: 17).isActive = true
        leftButton.widthAnchor.constraint(equalTo: leftButton.heightAnchor, multiplier: 1.2).isActive = true
        leftButton.heightAnchor.constraint(lessThanOrEqualTo: titleView.heightAnchor, multiplier: 0.35).isActive = true
    }
}
