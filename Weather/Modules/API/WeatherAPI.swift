//
//  WeatherAPI.swift
//  Weather
//
//  Created by Enzhe Gaysina on 29.10.2023.
//

import Foundation
import Combine

final class WeatherAPI {
    
    static let shared = WeatherAPI()
    //MARK: - fetchWeather(Location 
    static func fetchWeather(latitude: Double, longitude: Double) -> AnyPublisher<WeatherDetail, Error> {
	   let lat = latitude.description
	   let lon = longitude.description
	   
	   if let url = URL(string: "\(Con.baseURL)?lat=\(lat)&lon=\(lon)&units=metric&lang=ru&APPID=\(Con.apiKey)") {
		  return URLSession.shared.dataTaskPublisher(for: url)
			 .map(\.data)
			 .decode(type: WeatherDetail.self, decoder: JSONDecoder())
			 .eraseToAnyPublisher()
	   } else {
		  return Fail(error: WeatherAPIError.invalidURL).eraseToAnyPublisher()
	   }
    }
    //MARK: - fetchWeatherCity(City Screen)
    func fetchWeatherCity(for city: String) -> AnyPublisher<WeatherDetail, Never> {
	   
	   if let url = URL(string: "\(Con.baseURL)?q=\(city)&units=metric&APPID=\(Con.apiKey)") {
		  return URLSession.shared.dataTaskPublisher(for:url)
			 .map { $0.data }
			 .decode(type: WeatherDetail.self, decoder: JSONDecoder())
			 .catch { error in Just(WeatherDetail.placeholder)}
			 .receive(on: RunLoop.main)
			 .eraseToAnyPublisher()
	   } else {
		  return Just(WeatherDetail.placeholder)
			 .eraseToAnyPublisher()
	   }
    }
}

enum WeatherAPIError: Error {
    case invalidURL
}
// MARK: - Constants
extension WeatherAPI {
    enum Con {
	   static let baseURL = "https://api.openweathermap.org/data/2.5/weather"
	   static let apiKey = "53ea9de349fd1cdfdb97aa10726c6a33"
    }
}
