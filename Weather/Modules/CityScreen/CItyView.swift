//
//  CItyView.swift
//  Weather
//
//  Created by Enzhe Gaysina on 29.10.2023.
//

import UIKit
import SnapKit

class CityView: UIView {
    //MARK: - Variables
    
    private let cityTextField: UITextField = {
	   let textField = UITextField()
	   textField.isEnabled = true
	   textField.placeholder = "Введите город"
	   textField.textColor = UIColor.lightGray
	   textField.becomeFirstResponder()
	   textField.translatesAutoresizingMaskIntoConstraints = false
	   return textField
    }()
    
    private let temperatureLabel: UILabel = {
	   let label = UILabel()
	   label.translatesAutoresizingMaskIntoConstraints = false
	   return label
    }()
    
    private let backgroundImageView: UIImageView = {
	   let imageView = UIImageView(image: UIImage(named: "back_weather"))
	   imageView.translatesAutoresizingMaskIntoConstraints = false
	   return imageView
    }()
    
    //MARK: - initialization
    init() {
	   super.init(frame: .zero)
	   setupUI()
    }
    
    required init?(coder: NSCoder) {
	   super.init(coder: coder)
	   setupUI()
    }
    //MARK: - functions
    
    func setupUI() {
	   addSubview(backgroundImageView)
	   addSubview(cityTextField)
	   addSubview(temperatureLabel)
	   
	   backgroundImageView.snp.makeConstraints { make in
		  make.edges.equalToSuperview()
	   }
	   cityTextField.snp.makeConstraints { make in
		  make.left.equalToSuperview().inset(Constants.cityTextLeftSnp)
		  make.top.equalToSuperview().inset(Constants.cityTextTopSnp)
	   }
	   temperatureLabel.snp.makeConstraints { make in
		  make.left.equalToSuperview().inset(Constants.temperatureLabelLeftSnp)
		  make.top.equalTo(cityTextField).inset(Constants.temperatureLabelTopSnp)
	   }
    }
}

// MARK: - Constants

fileprivate extension CityView {
    
    enum Constants {
	   static let cityTextLeftSnp = 50
	   static let cityTextTopSnp = 100
	   static let temperatureLabelLeftSnp = 50
	   static let temperatureLabelTopSnp = 40
    }
}
