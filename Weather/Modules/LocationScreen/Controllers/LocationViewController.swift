//
//  ViewController.swift
//  Weather
//
//  Created by Enzhe Gaysina on 28.10.2023.
//

import UIKit
import CoreLocation
import Combine
import SnapKit

class LocationViewController: UIViewController {
    
    private let locationManager = CLLocationManager()
    var weatherDetail = WeatherDetail.placeholder
    var locationWeatherView = LocationWeatherView()
    
    private var cancellables: Set<AnyCancellable> = []
    private var weatherDetailPublisher = CurrentValueSubject<WeatherDetail, Never>(.placeholder)

	override func viewDidLoad() {
		super.viewDidLoad()
	    
	    startLocationManager()
	    locationViewConstraint()
	    subscribeToChanges()
	}
    
    private func subscribeToChanges() {
	   weatherDetailPublisher
		  .sink(receiveValue: { [weak self] weatherDetail in
			 self?.updateView(with: weatherDetail)
		  })
		  .store(in: &cancellables)
    }
    
    private func locationViewConstraint() {
	   locationWeatherView = LocationWeatherView()
	   locationWeatherView.translatesAutoresizingMaskIntoConstraints = false
	   view.addSubview(locationWeatherView)
	   
	   locationWeatherView.snp.makeConstraints { make in
		  make.edges.equalToSuperview()
	   }
    }

    func startLocationManager() {
	   locationManager.requestWhenInUseAuthorization()
	   DispatchQueue.global().async {
		  if CLLocationManager.locationServicesEnabled() {
			 self.locationManager.delegate = self
			 self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
			 self.locationManager.pausesLocationUpdatesAutomatically = false
			 self.locationManager.startUpdatingLocation()
		  }
	   }
    }
    
    func updateWeatherInfo(latitude: Double, longitude: Double) {
	   let baseURL = "https://api.openweathermap.org/data/2.5/weather?"
	   let apiKey = "53ea9de349fd1cdfdb97aa10726c6a33"
	   let lat = latitude.description
	   let lon = longitude.description
	   if let url = URL(string: "\(baseURL)lat=\(lat)&lon=\(lon)&units=metric&lang=ru&APPID=\(apiKey)") {
		  URLSession.shared.dataTaskPublisher(for: url)
			 .map(\.data)
			 .decode(type: WeatherDetail.self, decoder: JSONDecoder())
			 .replaceError(with: WeatherDetail.placeholder)
			 .receive(on: DispatchQueue.main)
			 .sink(receiveValue: { [weak self] weatherDetail in
				self?.weatherDetailPublisher.value = weatherDetail
			 })
			 .store(in: &cancellables)
	   }
    }

    
    func updateView(with weatherDetail: WeatherDetail) {
	   locationWeatherView.cityLabel.text = weatherDetail.name
	   if let temperature = weatherDetail.main?.temp {
		  locationWeatherView.temperatureLabel.text = "Температура \(temperature)ºC"
	   } else {
		  locationWeatherView.temperatureLabel.text = "Одевайтесь по погоде"
	   }
	   if let weatherIcon = weatherDetail.weather?.first?.icon {
		  locationWeatherView.weatherImageView.image = UIImage(named: weatherIcon)
	   } else {
		  locationWeatherView.weatherImageView.image = UIImage(named: "default_icon")
	   }
	   if let weatherDescription = weatherDetail.weather?.first?.description {
		  let capitalizedDescription = weatherDescription.prefix(1).uppercased() + weatherDescription.dropFirst()
		  locationWeatherView.descriptionLabel.text = capitalizedDescription
	   } else {
		  locationWeatherView.descriptionLabel.text = "Береженного бог бережет"
	   }
    }
}

extension LocationViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
	   if let lastLocation = locations.last {
		  updateWeatherInfo(
			 latitude: lastLocation.coordinate.latitude,
			 longitude: lastLocation.coordinate.longitude)
	   }
    }
}

