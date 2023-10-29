//
//  ViewController.swift
//  Weather
//
//  Created by Enzhe Gaysina on 28.10.2023.
//

import UIKit
import CoreLocation
import Combine

class LocationViewController: UIViewController {
    //MARK: - Variables
    private var viewModel = LocationViewModel()
    
    private var cancellables: Set<AnyCancellable> = []
    var locationWeatherView = LocationWeatherView()
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
	   super.viewDidLoad()
	   
	   setupViewModel()
	   locationViewConstraint()
	   viewModel.locationWeatherView = locationWeatherView
	   viewModel.setupLocationManager()
    }
    
    //MARK: - functions
    private func setupViewModel() {
	   viewModel.weatherDetailPublisher
		  .sink(receiveValue: { [weak self] weatherDetail in
			 self?.viewModel.updateView(with: weatherDetail)
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
}

