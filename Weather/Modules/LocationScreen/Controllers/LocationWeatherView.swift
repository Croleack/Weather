//
//  LocationWeatherView.swift
//  Weather
//
//  Created by Enzhe Gaysina on 29.10.2023.
//

import UIKit
import SnapKit
import MapKit
import CoreLocation

final class LocationWeatherView: UIView {
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
    
    let mapViewContainer: UIView = {
	   let view = UIView()
	   view.layer.cornerRadius = Constants.mapViewCornerRadius
	   view.layer.masksToBounds = true
	   view.translatesAutoresizingMaskIntoConstraints = false
	   return view
    }()
    
    let mapView: MKMapView = {
	   let mapView = MKMapView()
	   mapView.translatesAutoresizingMaskIntoConstraints = false
	   return mapView
    }()
    
    let locationManager = CLLocationManager()
    //MARK: - initialization
    init() {
	   super.init(frame: .zero)
	   setupUI()
	   setupLocationManager()
    }
    
    required init?(coder: NSCoder) {
	   super.init(coder: coder)
	   setupUI()
    }
    
    //MARK: - functions
    private func setupLocationManager() {
	   locationManager.delegate = self
	   locationManager.desiredAccuracy = kCLLocationAccuracyBest
	   locationManager.requestWhenInUseAuthorization()
	   locationManager.startUpdatingLocation()
    }
    
    private func setupUI() {
	   addSubview(backgroundImageView)
	   addSubview(cityLabel)
	   addSubview(temperatureLabel)
	   addSubview(weatherImageView)
	   addSubview(descriptionLabel)
	   mapViewContainer.addSubview(mapView)
	   addSubview(mapViewContainer)
	   
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
		  make.centerX.equalToSuperview()
		  make.top.equalTo(descriptionLabel).inset(Constants.weatherImageViewTopSnp)
		  make.width.equalTo(Constants.weatherImageViewWidth)
		  make.height.equalTo(Constants.weatherImageViewHeight)
	   }
	   descriptionLabel.snp.makeConstraints { make in
		  make.left.equalToSuperview().inset(Constants.descriptionLabelLeftSnp)
		  make.top.equalTo(temperatureLabel).inset(Constants.descriptionLabelTopSnp)
	   }
	   mapViewContainer.snp.makeConstraints { make in
		  make.top.equalTo(weatherImageView).inset(Constants.mapViewTop)
		  make.width.equalTo(Constants.mapViewWidth)
		  make.height.equalTo(Constants.mapViewHeight)
		  make.centerX.equalToSuperview()
	   }
	   mapView.snp.makeConstraints { make in
		  make.edges.equalToSuperview()
	   }
    }
}
//MARK: - extension

extension LocationWeatherView: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
	   if let location = locations.first {
		  let annotation = MKPointAnnotation()
		  annotation.coordinate = location.coordinate
		  mapView.addAnnotation(annotation)
		  
		  let region = MKCoordinateRegion(center: location.coordinate,
								    latitudinalMeters: Constants.latitudinalMeters,
								    longitudinalMeters: Constants.longitudinalMeters)
		  mapView.setRegion(region, animated: true)
		  
		  locationManager.stopUpdatingLocation()
	   }
    }
}

// MARK: - Constants

fileprivate extension LocationWeatherView {
    
    enum Constants {
	   static let fontCityLabel = 30.0
	   static let cityLabelLeftSnp = 40
	   static let cityLabelTopSnp = 100
	   static let temperatureLabelLeftSnp = 40
	   static let temperatureLabelTopSnp = 40
	   static let weatherImageViewTopSnp = 60
	   static let weatherImageViewWidth = 60
	   static let weatherImageViewHeight = 100
	   static let descriptionLabelLeftSnp = 40
	   static let descriptionLabelTopSnp = 30
	   static let mapViewTop = 100
	   static let mapViewWidth = 200
	   static let mapViewHeight = 200
	   static let mapViewCornerRadius = 12.0
	   static let latitudinalMeters = 500.0
	   static let longitudinalMeters = 500.0
    }
}
