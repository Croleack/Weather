//
//  LocationViewModel.swift
//  Weather
//
//  Created by Enzhe Gaysina on 29.10.2023.
//

import Combine
import CoreLocation
import UIKit

class LocationViewModel: NSObject, CLLocationManagerDelegate {
    //MARK: - Variables
    private let locationManager = CLLocationManager()
    var weatherDetail = WeatherDetail.placeholder
    
    private var cancellables: Set<AnyCancellable> = []
    internal var weatherDetailPublisher = CurrentValueSubject<WeatherDetail, Never>(.placeholder)
    
    var locationWeatherView: LocationWeatherView?
    //MARK: - initialization
    override init() {
	   super.init()
	   setupLocationManager()
    }
    //MARK: - functions
    func setupLocationManager() {
	   locationManager.delegate = self
	   locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
	   locationManager.pausesLocationUpdatesAutomatically = false
	   locationManager.requestWhenInUseAuthorization()
	   locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
	   if let lastLocation = locations.last {
		  fetchWeatherInfo(latitude: lastLocation.coordinate.latitude, longitude: lastLocation.coordinate.longitude)
	   }
    }
    
    func fetchWeatherInfo(latitude: Double, longitude: Double) {
	   WeatherAPI.fetchWeather(latitude: latitude, longitude: longitude)
		  .sink(receiveCompletion: { completion in
			
		  }, receiveValue: { [weak self] weatherDetail in
			 self?.weatherDetailPublisher.value = weatherDetail
		  })
		  .store(in: &cancellables)
    }
    
    func updateView(with weatherDetail: WeatherDetail) {
	   DispatchQueue.main.async { [weak self] in
		  if let name = weatherDetail.name {
			 self?.locationWeatherView?.cityLabel.text = name
		  }
		  if let temperature = weatherDetail.main?.temp {
			 self?.locationWeatherView?.temperatureLabel.text = "Температура \(temperature)ºC"
		  } else {
			 self?.locationWeatherView?.temperatureLabel.text = "Одевайтесь по погоде"
		  }
		  if let weatherIcon = weatherDetail.weather?.first?.icon {
			 self?.locationWeatherView?.weatherImageView.image = UIImage(named: weatherIcon)
		  } else {
			 self?.locationWeatherView?.weatherImageView.image = UIImage(named: "default_icon")
		  }
		  if let weatherDescription = weatherDetail.weather?.first?.description {
			 let capitalizedDescription = weatherDescription.prefix(1).uppercased() + weatherDescription.dropFirst()
			 self?.locationWeatherView?.descriptionLabel.text = capitalizedDescription
		  } else {
			 self?.locationWeatherView?.descriptionLabel.text = "Береженного бог бережет"
		  }
	   }
    }
}
