//
//  WeatherAPI.swift
//  Weather
//
//  Created by Enzhe Gaysina on 29.10.2023.
//

import Foundation
import Combine

class WeatherAPI {
    static func fetchWeather(latitude: Double, longitude: Double) -> AnyPublisher<WeatherDetail, Error> {
	   let baseURL = "https://api.openweathermap.org/data/2.5/weather?"
	   let apiKey = "53ea9de349fd1cdfdb97aa10726c6a33"
	   let lat = latitude.description
	   let lon = longitude.description
	   
	   if let url = URL(string: "\(baseURL)lat=\(lat)&lon=\(lon)&units=metric&lang=ru&APPID=\(apiKey)") {
		  return URLSession.shared.dataTaskPublisher(for: url)
			 .map(\.data)
			 .decode(type: WeatherDetail.self, decoder: JSONDecoder())
			 .eraseToAnyPublisher()
	   } else {
		  return Fail(error: WeatherAPIError.invalidURL).eraseToAnyPublisher()
	   }
    }
}

enum WeatherAPIError: Error {
    case invalidURL
}
