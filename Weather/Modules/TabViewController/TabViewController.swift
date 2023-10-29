//
//  TabViewController.swift
//  Weather
//
//  Created by Enzhe Gaysina on 28.10.2023.
//

import UIKit

final class TabViewController: UITabBarController {
    
    override func viewDidLoad() {
	   super.viewDidLoad()
	   setupTab()
    }
    
    private func setupTab() {
	   
	   tabBar.barStyle = .black
	   tabBar.barTintColor = .gray
	   
	   let tabLocation = LocationViewController()
	   tabLocation.title = "Ваша текущая позиция"
	   let tabCity = CityViewController()
	   tabCity.title = "Температура по городам"
	   
	   let navigationCity = UINavigationController(rootViewController: tabLocation)
	   let navigationCoordinate = UINavigationController(rootViewController: tabCity)
	   
	   navigationCity.tabBarItem = UITabBarItem(title: "Location", image: UIImage(
		  systemName: "location"), tag: 1)
	   navigationCoordinate.tabBarItem = UITabBarItem(title: "Cities", image: UIImage(
		  systemName: "cloud.moon.fill"), tag: 2)
	   
	   setViewControllers([
		  navigationCity,
		  navigationCoordinate,
	   ],animated: true)
    }
}
