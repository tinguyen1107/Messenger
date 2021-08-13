//
//  ChatViewController.swift
//  Messenger
//
//  Created by Trọng Tín on 23/07/2021.
//

import UIKit

class ChatViewController: UIViewController {
//    let socket = Socket.init(url: "http://localhost:7000")

    let CellID = "asjkdhflak"
    
    var data: [[String]] = [["user", "hello"], ["friend", "hi"]]
    
    let containerView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.addBorders(edges: .top, color: UIColor(red: 0, green: 0, blue: 0, alpha: 0.2))
        return view
    }()
    
    let messageTextField: BaseInput = {
        let tf = BaseInput()
        tf.placeholder = "Enter message..."
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = .clear
        tf.textColor = .black
        return tf
    }()
    
    let sendButton: UIButton = {
        let bt = UIButton()
        bt.setTitle("Send", for: .normal)
        bt.layer.cornerRadius = 10
        bt.backgroundColor = .link
        bt.setTitleColor(.white, for: .normal)
        bt.translatesAutoresizingMaskIntoConstraints = false
        
        bt.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
        return bt
    }()
    
    @objc func handleSend () {
        let message = messageTextField.text!
        messageTextField.text = ""
        if message != "" {
            print (message)
            /// send message
            data.append(["user", message])
            tableView.reloadData()
        }
    }
    
    let tableView: UITableView = {
        let tbv =  UITableView()
        tbv.translatesAutoresizingMaskIntoConstraints = false
        tbv.backgroundColor = .white
        tbv.allowsSelection = false
        return tbv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        let backButton = UIBarButtonItem()
        backButton.target = self
        backButton.action = #selector(handleBack)
        backButton.title = "Back"
        self.navigationItem.leftBarButtonItem = backButton
        
        setupView()
        
        API.socket.closureListMessageChange = { message in
            
        }
    }
    
    @objc func handleBack () {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func setupView () {
        self.view.backgroundColor = .white
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MessageTableViewCell.self, forCellReuseIdentifier: CellID)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
        tableView.separatorStyle = .none
        
        self.view.addSubview(containerView)
        self.containerView.addSubview(messageTextField)
        self.containerView.addSubview(sendButton)
        self.view.addSubview(tableView)
        
        containerView.snp.makeConstraints({
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            $0.left.equalTo(self.view)
            $0.right.equalTo(self.view)
            $0.height.equalTo(50)
        })
        
        messageTextField.snp.makeConstraints({
            $0.left.equalTo(containerView.snp.left).offset(10)
            $0.top.equalTo(containerView.snp.top).offset(5)
            $0.bottom.equalTo(containerView).offset(-5)
        })
        
        sendButton.snp.makeConstraints({
            $0.right.equalTo(containerView.snp.right).offset(-10)
            $0.top.equalTo(containerView.snp.top).offset(5)
            $0.centerY.equalTo(messageTextField)
            $0.left.equalTo(messageTextField.snp.right).offset(10)
            $0.width.equalTo(60)
        })
        
        tableView.snp.makeConstraints({
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.left.equalTo(self.view)
            $0.right.equalTo(self.view)
            $0.bottom.equalTo(containerView.snp.top)
        })
    }
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID) as! MessageTableViewCell
        cell.data = data[indexPath.row]
        return cell
    }
    
    
}
