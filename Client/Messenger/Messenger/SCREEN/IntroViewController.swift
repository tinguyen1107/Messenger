//
//  IntroViewController.swift
//  Messenger
//
//  Created by Trọng Tín on 28/07/2021.
//

import UIKit

class IntroViewController: UIViewController {
    
    let appIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "person")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = loginColor
        view.addSubview(appIcon)
        setupAppIcon()
    }
    
    private func setupAppIcon() {
        appIcon.snp.makeConstraints({
            $0.centerX.equalTo(view)
            $0.centerY.equalTo(view)
            $0.width.equalTo(50)
            $0.height.equalTo(appIcon.snp.width)
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let loginSuccess: Bool = true
            if (!loginSuccess) {
                let login = LoginViewController()
                login.modalPresentationStyle = .fullScreen
                self.present(login, animated: true, completion: nil)
            } else {
                let home = HomeViewController()
                let naviHome = UINavigationController(rootViewController: home)
                naviHome.modalPresentationStyle = .fullScreen
                self.present(naviHome, animated: true, completion: nil)
            }
        }
    }
}
