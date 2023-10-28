//
//  LocationWeatherView.swift
//  Weather
//
//  Created by Enzhe Gaysina on 29.10.2023.
//

import UIKit
import SnapKit

class LocationWeatherView: UIView {
    private let backgroundImageView: UIImageView = {
	   let imageView = UIImageView(image: UIImage(named: "back_weather"))
	   imageView.translatesAutoresizingMaskIntoConstraints = false
	   return imageView
    }()
    
    let cityLabel: UILabel = {
	   let label = UILabel()
	   label.font = UIFont.systemFont(ofSize: 30)
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
    
    init() {
	   super.init(frame: .zero)
	   setupUI()
    }
    
    required init?(coder: NSCoder) {
	   super.init(coder: coder)
	   setupUI()
    }
    
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
		  make.left.equalToSuperview().inset(50)
		  make.top.equalToSuperview().inset(150)
	   }
	   temperatureLabel.snp.makeConstraints { make in
		  make.left.equalToSuperview().inset(50)
		  make.top.equalTo(cityLabel).inset(40)
	   }
	   weatherImageView.snp.makeConstraints { make in
		  make.left.equalToSuperview().inset(50)
		  make.top.equalTo(descriptionLabel).inset(40)
		  make.width.equalTo(25)
		  make.height.equalTo(200)
		  make.centerX.equalToSuperview()
	   }
	   descriptionLabel.snp.makeConstraints { make in
		  make.left.equalToSuperview().inset(50)
		  make.top.equalTo(temperatureLabel).inset(30)
	   }
    }
}
