//
//  CityViewController.swift
//  Weather
//
//  Created by Enzhe Gaysina on 28.10.2023.
//

import UIKit
import Combine

class CityViewController: UIViewController {
    //MARK: - Variables
    var cityView = CityView()
    private let viewModel = CityViewModel()
    private var cancellable = Set<AnyCancellable>()
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
	   super.viewDidLoad()
	   setupCityView()
	   binding()
	   tapGesture()
    }
    
    // MARK: - Combine
    func binding() {
	   cityView.cityTextField.textPublisher
		  .assign(to: \.city, on: viewModel)
		  .store(in: &cancellable)
	   
	   viewModel.$temp
		  .sink(receiveValue: {[weak self] temp in
			 self?.cityView.temperatureLabel.text = temp})
		  .store(in: &cancellable)
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
