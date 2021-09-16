//
//  SearchView.swift
//  WeatherApp
//
//  Created by Marin Kajtazi on 13/10/2020.
//  Copyright © 2020 Marin Kajtazi. All rights reserved.
//

import UIKit

class SearchView: UIView {

    // MARK: Properties
    var searchBar: UISearchBar!
    var tableView: UITableView!
    
    static let cellReuseID = "SearchResultCell"
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    private func setup() {
        searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Search..."
        searchBar.barTintColor = .darkGray
        searchBar.barStyle = .black
        searchBar.showsCancelButton = true
        addSubview(searchBar)
        
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = 55
        tableView.alpha = 0.8
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: SearchView.cellReuseID)
        addSubview(tableView)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
