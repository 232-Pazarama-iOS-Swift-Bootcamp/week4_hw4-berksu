//
//  MainView.swift
//  FlickerApiApp
//
//  Created by Berksu Kısmet on 13.10.2022.
//

import UIKit

class MainView: UIView {
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(MainViewCustomCell.self, forCellReuseIdentifier: MainViewCustomCell.identifier)
        return tableView
    }()
    
    // MARK: - Init
    init() {
        super.init(frame: .zero)
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
            make.leading.equalTo(self.snp.leading)
            make.trailing.equalTo(self.snp.trailing)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
