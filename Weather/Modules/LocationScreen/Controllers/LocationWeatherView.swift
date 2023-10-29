//
//  LocationWeatherView.swift
//  Weather
//
//  Created by Enzhe Gaysina on 29.10.2023.
//

import UIKit
import SnapKit

class LocationWeatherView: UIView {
    //MARK: - Variables
    private let backgroundImageView: UIImageView = {
	   let imageView = UIImageView(image: UIImage(named: "back_weather"))
	   imageView.translatesAutoresizingMaskIntoConstraints = false
	   return imageView
    }()
    
    let cityLabel: UILabel = {
	   let label = UILabel()
	   label.font = UIFont.systemFont(ofSize: Constants.fontCityLabel)
	   label.translatesAutoresizingMaskIntoConstraints = false
	   return label
    }()
    
    let temperatureLabel: UILabel = {
	   let label = UILabel()
	   label.translatesAutoresizingMaskIntoConstraints = false
	   return label
    }()
    
    let weatherImageView: UIImageView = {
	   let imageView = UIImageView()
	   imageView.translatesAutoresizingMaskIntoConstraints = false
	   return imageView
    }()
    
    let descriptionLabel: UILabel = {
	   let label = UILabel()
	   label.translatesAutoresizingMaskIntoConstraints = false
	   return label
    }()
    //MARK: - initialization
    init() {
	   super.init(frame: .zero)
	   setupUI()
    }
    
    required init?(coder: NSCoder) {
	   super.init(coder: coder)
	   setupUI()
    }
    //MARK: - setupUI
    private func setupUI() {
	   addSubview(backgroundImageView)
	   addSubview(cityLabel)
	   addSubview(temperatureLabel)
	   addSubview(weatherImageView)
	   addSubview(descriptionLabel)
	   
	   backgroundImageView.snp.makeConstraints { make in
		  make.edges.equalToSuperview()
	   }
	   cityLabel.snp.makeConstraints { make in
		  make.left.equalToSuperview().inset(Constants.cityLabelLeftSnp)
		  make.top.equalToSuperview().inset(Constants.cityLabelTopSnp)
	   }
	   temperatureLabel.snp.makeConstraints { make in
		  make.left.equalToSuperview().inset(Constants.temperatureLabelLeftSnp)
		  make.top.equalTo(cityLabel).inset(Constants.temperatureLabelTopSnp)
	   }
	   weatherImageView.snp.makeConstraints { make in
		  make.left.equalToSuperview().inset(Constants.weatherImageViewLeftSnp)
		  make.top.equalTo(descriptionLabel).inset(Constants.weatherImageViewTopSnp)
		  make.width.equalTo(Constants.weatherImageViewWidth)
		  make.height.equalTo(Constants.weatherImageViewHeight)
	   }
	   descriptionLabel.snp.makeConstraints { make in
		  make.left.equalToSuperview().inset(Constants.descriptionLabelLeftSnp)
		  make.top.equalTo(temperatureLabel).inset(Constants.descriptionLabelTopSnp)
	   }
    }
}

// MARK: - Constants

fileprivate extension LocationWeatherView {
    
    enum Constants {
	   static let fontCityLabel = 30.0
	   static let cityLabelLeftSnp = 50
	   static let cityLabelTopSnp = 150
	   static let temperatureLabelLeftSnp = 50
	   static let temperatureLabelTopSnp = 40
	   static let weatherImageViewLeftSnp = 50
	   static let weatherImageViewTopSnp = 60
	   static let weatherImageViewWidth = 60
	   static let weatherImageViewHeight = 100
	   static let descriptionLabelLeftSnp = 50
	   static let descriptionLabelTopSnp = 30
    }
}
