//
//  ViewController.swift
//  WeatherApp
//
//  Created by Marin Kajtazi on 05/10/2020.
//  Copyright © 2020 Marin Kajtazi. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    private var weatherView: WeatherView { view as! WeatherView }
    private var viewModel: WeatherViewModel
    var id: Int?
    
    init(viewModel: WeatherViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = WeatherView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchWeatherData()
        weatherView.locationsButton.addTarget(self, action: #selector(goToLocations), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @objc func goToLocations() {
        navigationController?.popViewController(animated: true)
    }
    
    func fetchWeatherData() {
        weatherView.spinner.startAnimating()
        viewModel.fetchWeatherData(
            onSuccess: { [weak self] in
                DispatchQueue.main.async {
                    self?.updateUI()
                    self?.weatherView.spinner.stopAnimating()
                }
            },
            onFail: { [weak self] in
                DispatchQueue.main.async {
                    self?.showError()
                }
            })
    }
    
    func updateUI() {
        guard let weatherInfo = viewModel.weatherInfo else { return }
        
        weatherView.locationLabel.text = weatherInfo.name
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        weatherView.dayLabel.text = dateFormatter.string(from: date)
        
        let iconName = weatherInfo.weather[0].icon
        weatherView.conditionImageView.image = UIImage(named: iconName)
        
        weatherView.conditionLabel.text = weatherInfo.weather[0].main
        weatherView.temperatureLabel.text = String(weatherInfo.main.temp)
    }

    func showError() {
        let ac = UIAlertController(title: "Connection error", message: "Could not fetch weather data.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }

}

