//
//  WeatherDetail.swift
//  Weather
//
//  Created by Enzhe Gaysina on 28.10.2023.
//

import Foundation

// MARK: - WeatherDetail
struct WeatherDetail: Codable, Identifiable  {
    let coord: Coord?
    let weather: [Weather]?
    let base: String?
    let main: Main?
    let visibility: Int?
    let wind: Wind?
    let rain: Rain?
    let clouds: Clouds?
    let dt: Int?
    let sys: Sys?
    let timezone, id: Int?
    let name: String?
    let cod: Int?
    
    static var placeholder: Self {
	   return WeatherDetail(coord: nil, weather: nil, base: nil, main: nil,
					    visibility: nil, wind: nil, rain: nil, clouds: nil,
					    dt: nil, sys: nil, timezone: nil, id: nil, name: nil,
					    cod: nil)
    }
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int?
}

// MARK: - Coord
struct Coord: Codable {
    let lon: Double?
    let lat: Double?
}

// MARK: - Main
struct Main: Codable {
    let temp: Double?
    let pressure: Int?
    let humidity: Int?
    let tempMin: Double?
    let tempMax: Double?
    
    enum CodingKeys: String, CodingKey {
	   case temp, pressure, humidity
	   case tempMin = "temp_min"
	   case tempMax = "temp_max"
    }
}

// MARK: - Rain
struct Rain: Codable {
    let the1H: Double
    
    enum CodingKeys: String, CodingKey {
	   case the1H = "1h"
    }
}

// MARK: - Sys
struct Sys: Codable {
    let type: Int?
    let id: Int?
    let message: Double?
    let country: String?
    let sunrise: TimeInterval?
    let sunset: TimeInterval?
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int?
    let main: String?
    let description: String?
    let icon: String?
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double?
    let deg: Int?
}
