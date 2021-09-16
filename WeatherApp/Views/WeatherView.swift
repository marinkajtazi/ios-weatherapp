//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Marin Kajtazi on 13/10/2020.
//  Copyright © 2020 Marin Kajtazi. All rights reserved.
//

import UIKit

class WeatherView: UIView {

    // MARK: Properties
    var locationsButton: UIButton!
    var locationLabel: UILabel!
    var dayLabel: UILabel!
    var conditionImageView: UIImageView!
    var conditionLabel: UILabel!
    var temperatureLabel: UILabel!
    var unitLabel: UILabel!
    var spinner: UIActivityIndicatorView!
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    private func setup() {
        backgroundColor = .systemBlue
        
        locationsButton = UIButton()
        locationsButton.translatesAutoresizingMaskIntoConstraints = false
        locationsButton.setImage(UIImage(systemName: "list.dash"), for: .normal)
        locationsButton.tintColor = .white
        addSubview(locationsButton)
        
        locationLabel = UILabel()
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        locationLabel.textColor = .white
        addSubview(locationLabel)
        
        dayLabel = UILabel()
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        dayLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        dayLabel.textColor = .white
        addSubview(dayLabel)
        
        conditionImageView = UIImageView()
        conditionImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(conditionImageView)
        
        conditionLabel = UILabel()
        conditionLabel.translatesAutoresizingMaskIntoConstraints = false
        conditionLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        conditionLabel.textColor = .white
        addSubview(conditionLabel)
        
        temperatureLabel = UILabel()
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        temperatureLabel.textColor = .white
        addSubview(temperatureLabel)
        
        unitLabel = UILabel()
        unitLabel.translatesAutoresizingMaskIntoConstraints = false
        unitLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        unitLabel.textColor = .white
        unitLabel.text = "°C"
        addSubview(unitLabel)
        
        spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.style = .large
        spinner.color = .white
        addSubview(spinner)
        
        NSLayoutConstraint.activate([
            locationsButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            locationsButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            //locationsButton.widthAnchor.constraint(equalToConstant: 40),
            //locationsButton.heightAnchor.constraint(equalToConstant: 40),
            
            locationLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 50),
            locationLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            dayLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 5),
            dayLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            conditionImageView.topAnchor.constraint(equalTo: dayLabel.bottomAnchor, constant: 50),
            conditionImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            conditionImageView.widthAnchor.constraint(equalToConstant: 200),
            conditionImageView.heightAnchor.constraint(equalToConstant: 200),
            
            conditionLabel.topAnchor.constraint(equalTo: conditionImageView.bottomAnchor, constant: 5),
            conditionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            temperatureLabel.topAnchor.constraint(equalTo: conditionLabel.bottomAnchor, constant: 100),
            temperatureLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            unitLabel.centerYAnchor.constraint(equalTo: temperatureLabel.centerYAnchor),
            unitLabel.leadingAnchor.constraint(equalTo: temperatureLabel.trailingAnchor, constant: 10),
            
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
