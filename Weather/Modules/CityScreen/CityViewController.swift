//
//  CityViewController.swift
//  Weather
//
//  Created by Enzhe Gaysina on 28.10.2023.
//

import UIKit

class CityViewController: UIViewController {
    //MARK: - Variables
    var cityView = CityView()
    //MARK: - viewDidLoad
    override func viewDidLoad() {
	   super.viewDidLoad()
	   setupCityView()
	   tapGesture()
    }
    //MARK: - functions
    private func setupCityView() {
	   cityView = CityView()
	   cityView.translatesAutoresizingMaskIntoConstraints = false
	   view.addSubview(cityView)
	   
	   cityView.snp.makeConstraints { make in
		  make.edges.equalToSuperview()
	   }
    }
    
    func tapGesture() {
	   let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
	   tapGesture.numberOfTapsRequired = 1
	   view.addGestureRecognizer(tapGesture)
    }
    
    @objc
    func hideKeyboard() {
	   view.endEditing(true)
    }
}
