//
//  CityViewModel.swift
//  Weather
//
//  Created by Enzhe Gaysina on 30.10.2023.
//

import Combine
import Foundation

final class CityViewModel: ObservableObject {

    @Published var city: String = ""
    @Published var temp = " "
    
    init() {
	   $city
		  .debounce(for: 0.3, scheduler: RunLoop.main)
		  .removeDuplicates()
		  .flatMap { (city:String) -> AnyPublisher <WeatherDetail, Never> in
			 WeatherAPI.shared.fetchWeatherCity(for: city)
		  }
		  .map { $0.main?.temp ?? 0.0 }
		  .map { "\($0)ºC" }
		  .assign(to: \.temp , on: self)
		  .store(in: &self.cancellableSet)
    }
    
    private var cancellableSet: Set<AnyCancellable> = []
}
