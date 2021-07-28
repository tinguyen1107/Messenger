//
//  HomeViewController.swift
//  Messenger
//
//  Created by Trọng Tín on 23/07/2021.
//

import UIKit
import SnapKit
import SocketIO

class HomeViewController: UIViewController {
    
    let data = [["name": "Nguyen Trong Tin", "image": ""],
                ["name": "tinguyen", "image": ""],
                ["name": "json", "image": ""],
                ["name": "Nodejs", "image": ""],
                ["name": "socket io", "image": ""],
                ["name": "mongodb", "image": ""]]
    
    let CellID = "asdfhjklasfd"
    
    let socket = Socket(url: "http://localhost:7000")
        
    let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .clear
        table.backgroundColor = .white
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .green
//        if (true) { /// neu ch dang nhap
//            logOut()
//        }
        
        
        setupNavigationBar()
        setupTableView()
    }
    
    func setupTableView () {
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: CellID)
        tableView.rowHeight = 60
        
        tableView.snp.makeConstraints({
            $0.top.equalTo(self.view.safeAreaInsets)
            $0.bottom.equalTo(self.view)
            $0.left.equalTo(self.view)
            $0.right.equalTo(self.view)
        })
    }
    
    private func setupNavigationBar () {
        let rightBarButton = UIBarButtonItem()
        
        rightBarButton.title = "Log Out"
        rightBarButton.action = #selector(logOut)
        rightBarButton.target = self
        
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc func logOut () {
        let login = LoginViewController()
        login.modalPresentationStyle = .fullScreen
        present(login, animated: true, completion: nil)
        
//        socket.socket.connect()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID) as! HomeTableViewCell
        
        cell.iconCell.image = UIImage(named: data[indexPath.row]["image"]!) ?? UIImage(systemName: "person.circle.fill")!
        cell.titleLabel.text = data[indexPath.row]["name"]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chatView = ChatViewController()

        chatView.title = data[indexPath.row]["name"]

        let navChatView = UINavigationController(rootViewController: chatView)
//        let view = UIView(frame: CGRect(x: 0, y: 0, width: 1000, height: 1000))
//        view.backgroundColor = .blue
//        chatView.navigationItem.titleView = view
        navChatView.modalPresentationStyle = .fullScreen
        present(navChatView, animated: true, completion: nil)
    }
}
