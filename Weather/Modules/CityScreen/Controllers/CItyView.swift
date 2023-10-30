//
//  CItyView.swift
//  Weather
//
//  Created by Enzhe Gaysina on 29.10.2023.
//

import UIKit
import SnapKit
import Combine

class CityView: UIView {
    //MARK: - Variables
    
    let cityTextField: UITextField = {
	   let textField = UITextField()
	   textField.isEnabled = true
	   textField.placeholder = "Введите город на английском языке"
	   textField.textColor = UIColor.white
	   textField.becomeFirstResponder()
	   textField.translatesAutoresizingMaskIntoConstraints = false
	   return textField
    }()
    
    let temperatureLabel: UILabel = {
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
// MARK: - extension
extension UITextField {
    var textPublisher: AnyPublisher<String, Never> {
	   NotificationCenter.default
		  .publisher(for: UITextField.textDidChangeNotification, object: self)
		  .compactMap { $0.object as? UITextField } 
		  .map { $0.text ?? "" }
		  .eraseToAnyPublisher()
    }
}
// MARK: - Constants

fileprivate extension CityView {
    
    enum Constants {
	   static let cityTextLeftSnp = 40
	   static let cityTextTopSnp = 100
	   static let temperatureLabelLeftSnp = 40
	   static let temperatureLabelTopSnp = 40
    }
}




