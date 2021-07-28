//
//  BaseViewController.swift
//  HOPNHAT
//
//  Created by Trọng Tín on 15/06/2021.
//

import UIKit

class BaseListViewController: BaseViewController {
    
    let CellID = "ahvfkjhawbgkwnlawv"
    
//    var delegate: HomeControllerDelegate?

    @objc override func handleRightButton() {
//        delegate?.handleMenuToggle(forMenuOption: nil) /// Default for menuButton
    }
    
    let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .clear
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView () {
        self.view.addSubview(tableView)
        
        setupTableView()
    }
    
    private func setupTableView () {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: CellID)
        
        tableView.separatorStyle = .none
        
        tableView.topAnchor.constraint(equalTo: titleView.bottomAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
}

extension BaseListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID)
        return cell!
    }
}
