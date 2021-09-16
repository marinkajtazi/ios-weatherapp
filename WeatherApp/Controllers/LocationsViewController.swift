//
//  LocationsViewController.swift
//  WeatherApp
//
//  Created by Marin Kajtazi on 13/10/2020.
//  Copyright © 2020 Marin Kajtazi. All rights reserved.
//

import RxSwift
import RxCocoa
import RxDataSources
import UIKit

class LocationsViewController: UIViewController {
    
    typealias LocationSectionModel = AnimatableSectionModel<String, Location>
    
    private let disposeBag = DisposeBag()
    private var locationsView: LocationsView { view as! LocationsView }
    private var tableView: UITableView { locationsView.tableView }
    private var viewModel: LocationsViewModel
    private lazy var dataSource = createDataSource()
    
    init(viewModel: LocationsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = LocationsView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBindings()
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        title = "My Locations"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTable))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(searchLocation))
    }
    
    @objc private func editTable() {
        tableView.setEditing(!tableView.isEditing, animated: true)
    }

    @objc private func searchLocation() {
        switch LocationLoader.shared.state {
        case .loaded(let locations):
            presentSearch(locations: locations)
        case .notLoaded:
            let ac = UIAlertController(
                title: "Search not ready",
                message: "Locations are still being loaded. Please try again in a few seconds.",
                preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Okay", style: .default))
            present(ac, animated: true)
        }
    }
    
    private func presentSearch(locations: [Location]) {
        let searchViewModel = SearchViewModel(locations: locations)
        let searchViewController = SearchViewController(viewModel: searchViewModel)
        
        searchViewController
            .locationSelected
            .bind(onNext: { [weak self] location in
                self?.viewModel.locations.acceptAppending(location)
            })
            .disposed(by: disposeBag)
        
        present(searchViewController, animated: true)
    }
    
    private func setupBindings() {
        viewModel
            .locations
            .asDriver()
            .map { [LocationSectionModel(model: "", items: $0)] }
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        tableView
            .rx
            .itemMoved
            .asDriver()
            .drive(onNext: { [weak self] event in
                let src = event.sourceIndex
                let dst = event.destinationIndex
                self?.viewModel.locations.moveElement(from: src.row, to: dst.row)
            })
            .disposed(by: disposeBag)
        
        tableView
            .rx
            .modelSelected(Location.self)
            .asDriver()
            .drive(onNext: { [weak self] location in
                let weatherViewModel = WeatherViewModel(location: location)
                let weatherViewController = WeatherViewController(viewModel: weatherViewModel)
                self?.navigationController?.pushViewController(weatherViewController, animated: true)
            })
            .disposed(by: disposeBag)
        
        tableView
            .rx
            .itemDeleted
            .asDriver()
            .drive(onNext: { [weak self] indexPath in
                _ = self?.viewModel.locations.remove(at: indexPath.row)
            })
            .disposed(by: disposeBag)
    }
    
    private func createDataSource() -> RxTableViewSectionedAnimatedDataSource<LocationSectionModel> {
        return RxTableViewSectionedAnimatedDataSource<LocationSectionModel>(
            animationConfiguration: AnimationConfiguration(
                insertAnimation: .automatic,
                reloadAnimation: .automatic,
                deleteAnimation: .automatic
            ),
            configureCell: { _, tableView, indexPath, location in
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: LocationsView.cellReuseID,
                    for: indexPath)
                cell.textLabel?.text = location.name
                return cell
            },
            canEditRowAtIndexPath: { [weak self] _, _ -> Bool in
                self?.tableView.isEditing ?? false
            },
            canMoveRowAtIndexPath: { _, _ -> Bool in true })
    }
}
