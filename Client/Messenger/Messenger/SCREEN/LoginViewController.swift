//
//  LoginViewController.swift
//  Messenger
//
//  Created by Trọng Tín on 23/07/2021.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {
    
    override open var shouldAutorotate: Bool {
        // screen rotate
        return false
    }
    
    var inputContainerHeightAnchor: NSLayoutConstraint?
    var nameUserTextFieldHeightAnchor: NSLayoutConstraint?
    
    let iconForApp: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "person.circle")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let inputContainerView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let loginRegisterButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.setTitle("Login", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(loginColor, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(loginOrRegister), for: .touchUpInside)
        return button
    }()
    
    @objc func loginOrRegister() {
        let isLogin = loginRegisterSegmentedControl.selectedSegmentIndex == 0
        let home = HomeViewController()
        let naviHome = UINavigationController(rootViewController: home)
        naviHome.modalPresentationStyle = .fullScreen
        if (isLogin) {
            let user = User(id: idTextField.text!, password: passwordTextField.text!)
            API.alamofire.login(user: user, complete: {
                self.present(naviHome, animated: true, completion: nil)
            })
        } else {
            
        }
        
        
    }
    
    let nameUserTextField: BaseInput = {
        let textfied = BaseInput()
        textfied.placeholder = "User Name"
        textfied.translatesAutoresizingMaskIntoConstraints = false
        return textfied
    }()
    
    let idTextField: BaseInput = {
        let textfield = BaseInput()
        textfield.placeholder = "ID"
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()

    let passwordTextField: BaseInput = {
        let textfied = BaseInput()
        textfied.placeholder = "Password"
        textfied.translatesAutoresizingMaskIntoConstraints = false
        textfied.isSecureTextEntry = true
        return textfied
    }()
    
    lazy var loginRegisterSegmentedControl: UISegmentedControl = {
        let segmented = UISegmentedControl(items: ["Login", "Register"])
        segmented.translatesAutoresizingMaskIntoConstraints = false
        segmented.layer.borderColor = CGColor.init(gray: 1, alpha: 1)
        segmented.layer.borderWidth = 0.5
        segmented.selectedSegmentIndex = 0
        segmented.addTarget(self, action: #selector(handleLoginRegisterChange), for: .valueChanged)
        return segmented
    }()
    
    @objc func handleLoginRegisterChange() {
        let title = loginRegisterSegmentedControl.titleForSegment(at: loginRegisterSegmentedControl.selectedSegmentIndex)
        loginRegisterButton.setTitle(title, for: .normal)
        
        let which = loginRegisterSegmentedControl.selectedSegmentIndex == 0 //login: true, register: false
        // change height of inputContainer
        inputContainerHeightAnchor?.constant = which ? 100 : 150
        
        // change height of nameUser tf
        nameUserTextFieldHeightAnchor?.constant = which ? 0 : 50
        
        clearAllDidInput()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = loginColor
        
        self.view.addSubview(iconForApp)
        self.view.addSubview(inputContainerView)
        self.view.addSubview(loginRegisterButton)
        self.view.addSubview(loginRegisterSegmentedControl)
        
        setupIconForApp()
        setupInputContainerView()
        setupLoginRegisterButton()
        setupLoginRegisterSegmentedControl()
    }
    
    private func setupIconForApp() {
        iconForApp.snp.makeConstraints({
            $0.centerX.equalTo(view)
            $0.width.equalTo(view).dividedBy(3)
            $0.height.equalTo(iconForApp.snp.width)
            $0.top.equalTo(view).offset(20)
        })
    }
    
    private func setupInputContainerView() {
        inputContainerView.snp.makeConstraints({
            $0.centerX.equalTo(view)
            $0.centerY.equalTo(view)
            $0.width.equalTo(view).offset(-30)
        })

        inputContainerHeightAnchor = inputContainerView.heightAnchor.constraint(equalToConstant: 100)
        inputContainerHeightAnchor?.isActive = true
        
        inputContainerView.addSubview(nameUserTextField)
        inputContainerView.addSubview(idTextField)
        inputContainerView.addSubview(passwordTextField)
        
        setupNameUserTextField()
        setupIdTextField()
        setupPasswordTextField()
    }
    
    private func setupLoginRegisterButton () {
        loginRegisterButton.snp.makeConstraints({
            $0.centerX.equalTo(view)
            $0.top.equalTo(inputContainerView.snp.bottom).offset(20)
            $0.width.equalTo(inputContainerView)
            $0.height.equalTo(50)
        })
    }
    
    func setupNameUserTextField() {
        nameUserTextField.snp.makeConstraints({
            $0.left.equalTo(inputContainerView)
            $0.right.equalTo(inputContainerView)
            $0.top.equalTo(inputContainerView)
        })
        nameUserTextFieldHeightAnchor = nameUserTextField.heightAnchor.constraint(equalToConstant: 0)
        nameUserTextFieldHeightAnchor?.isActive = true
    }
    
    func setupIdTextField() {
        idTextField.snp.makeConstraints({
            $0.left.equalTo(inputContainerView)
            $0.right.equalTo(inputContainerView)
            $0.top.equalTo(nameUserTextField.snp.bottom)
            $0.height.equalTo(50)
        })
    }

    func setupPasswordTextField() {
        passwordTextField.snp.makeConstraints({
            $0.left.equalTo(inputContainerView)
            $0.right.equalTo(inputContainerView)
            $0.top.equalTo(idTextField.snp.bottom)
            $0.height.equalTo(50)
        })
    }
    
    
    func setupLoginRegisterSegmentedControl() {
        loginRegisterSegmentedControl.snp.makeConstraints({
            $0.centerX.equalTo(view)
            $0.bottom.equalTo(inputContainerView.snp.top).offset(-20)
            $0.width.equalTo(inputContainerView)
            $0.height.equalTo(idTextField).dividedBy(1.5)
        })
    }

    func clearAllDidInput () {
        nameUserTextField.text = ""
        idTextField.text = ""
        passwordTextField.text = ""
    }
    
    func createTabViewController() {

    }
}
