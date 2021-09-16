//
//  SearchViewController.swift
//  WeatherApp
//
//  Created by Marin Kajtazi on 13/10/2020.
//  Copyright © 2020 Marin Kajtazi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

protocol LocationSelected {
    func selected(location: Location)
}

class SearchViewController: UIViewController {
    
    typealias SearchSectionModel = AnimatableSectionModel<String, Location>

    private let disposeBag = DisposeBag()
    private var searchView: SearchView { view as! SearchView }
    private var tableView: UITableView { searchView.tableView }
    private var viewModel: SearchViewModel
    
    var locationSelected = PublishRelay<Location>()
    
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = SearchView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchView.searchBar.becomeFirstResponder()
    }
    
    func setupBindings() {
        let dataSource = RxTableViewSectionedAnimatedDataSource<SearchSectionModel>(
            animationConfiguration: AnimationConfiguration(
                insertAnimation: .automatic,
                reloadAnimation: .automatic,
                deleteAnimation: .automatic
            ),
            configureCell: { _, tableView, indexPath, location in
                let cell = tableView.dequeueReusableCell(withIdentifier: SearchView.cellReuseID, for: indexPath)
                cell.textLabel?.text = location.name
                return cell
            },
            canEditRowAtIndexPath: { [weak self] _, _ -> Bool in
                self?.tableView.isEditing ?? false
            },
            canMoveRowAtIndexPath: { _, _ -> Bool in true })
        
        viewModel
            .filteredLocations
            .asDriver()
            .map { [SearchSectionModel(model: "", items: $0)] }
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        tableView
            .rx
            .modelSelected(Location.self)
            .asDriver()
            .drive(onNext: { [weak self] location in
                guard let self = self else { return }
                
                self.locationSelected.accept(location)
                self.searchView.searchBar.text = ""
                self.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
        
        searchView
            .searchBar
            .rx
            .text
            .orEmpty
            .asDriver()
            .debounce(.milliseconds(500))
            .drive(onNext: { [weak self] searchText in
                self?.viewModel.filter(by: searchText)
                self?.searchView.tableView.reloadData()
            })
            .disposed(by: disposeBag)
        
        searchView
            .searchBar
            .rx
            .cancelButtonClicked
            .asDriver()
            .drive(onNext: { [weak self] _ in
                self?.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
    }
}
