//
//  WeatherViewController.swift
//  Weather
//
//  Created by Dhananjay Kumar Dubey on 19/1/21.
//

import UIKit

final class WeatherViewController: UIViewController {
    
    // MARK: Private Outlets
    
    @IBOutlet private weak var contentView: UIView! {
        didSet {
            self.contentView.backgroundColor = UIColor.blue.withAlphaComponent(0.3)
        }
    }
    
    @IBOutlet private weak var topView: UIView! {
        didSet {
            self.topView.applyCardViewStyle()
        }
    }

    @IBOutlet private weak var locationTextField: UITextField! {
        didSet {
            self.locationTextField.applyStyle()
            self.locationTextField.placeholder = "Choose Location"
            self.locationTextField.delegate = self
            self.locationTextField.setupRightImage(imageName: "downArrow")
        }
    }
    
    @IBOutlet private weak var weatherImage: UIImageView!
    
    @IBOutlet private weak var weatherStateLabel: UILabel! {
        didSet {
            self.weatherStateLabel.textColor = .black
            self.weatherStateLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        }
    }
    
    @IBOutlet private weak var theTemperatureLabel: UILabel! {
        didSet {
            self.theTemperatureLabel.textColor = .black
            self.theTemperatureLabel.font = UIFont.boldSystemFont(ofSize: 28.0)
        }
    }
    
    @IBOutlet private weak var minTempTitleLabel: UILabel! {
        didSet {
            self.minTempTitleLabel.text = "Min Temp"
            self.minTempTitleLabel.applyTitleStyle()
        }
    }
    
    @IBOutlet private weak var maxTempTitleLabel: UILabel! {
        didSet {
            self.maxTempTitleLabel.applyTitleStyle()
            self.maxTempTitleLabel.text = "Max Temp"
        }
    }
    
    @IBOutlet private weak var humidityTitleLabel: UILabel! {
        didSet {
            self.humidityTitleLabel.applyTitleStyle()
            self.humidityTitleLabel.text = "Humidity"
        }
    }
    
    @IBOutlet private weak var maxTempValueLabel: UILabel! {
        didSet {
            self.maxTempValueLabel.applyValueStyle()
        }
    }
    
    @IBOutlet private weak var minTempValueLabel: UILabel! {
        didSet {
            self.minTempValueLabel.applyValueStyle()
        }
    }
    
    @IBOutlet private weak var humidityValueLabel: UILabel! {
        didSet {
            self.humidityValueLabel.applyValueStyle()
        }
    }
    
    
    private lazy var locationPickerView = UIPickerView()
    private let loadingManager = LoadingViewManager()
    private let viewModel = WeatherViewModel(with: WeatherAPIClient(baseURL: NetworkConstant.baseURL))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Weather Report"
        self.locationTextField.inputView = self.locationPickerView
        self.locationPickerView.delegate = self
        self.bindViewModel()
    }

    private func bindViewModel() {
        
        self.viewModel.startLoading = { [weak self] in
            guard let _self = self else { return }
            _self.loadingManager.showLoading(superView: _self.view)
        }

        self.viewModel.endLoading = { [weak self] in
            guard let _self = self else { return }
            _self.loadingManager.removeLoading()
        }

        self.viewModel.showError = { [weak self] message in
            guard let _self = self else { return }
            _self.loadingManager.showError(superView: _self.topView, message: message)
        }

        self.viewModel.selectedLocation = { [weak self] location in
            guard let _self = self else { return }
            _self.locationTextField.text = location
        }

        self.viewModel.weatherReport = { [weak self] weather in
            guard
                let _self = self,
                let weather = weather
            else { return }
            
            _self.weatherImage.image = UIImage(named: weather.state.stateImageName)
            _self.weatherStateLabel.text = weather.stateName
            _self.theTemperatureLabel.text = "\(weather.theTemp)º"
            _self.minTempValueLabel.text = "\(weather.minTemp)º"
            _self.maxTempValueLabel.text = "\(weather.maxTemp)º"
            _self.humidityValueLabel.text = "\(weather.humidity)%"
        }

        self.viewModel.selectedLocation(index: self.locationPickerView.selectedRow(inComponent: 0))
        self.viewModel.bindViewModel()
    }
    
}

// MARK: TextField delegate

extension WeatherViewController: UITextFieldDelegate {
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField == self.locationTextField {
            self.viewModel.selectedLocation(index: self.locationPickerView.selectedRow(inComponent: 0))
        }
        textField.resignFirstResponder()
        return true
    }
}

 //MARK: PickerView delegate and datasource

extension WeatherViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.viewModel.sourceLocations.count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        if row < self.viewModel.sourceLocations.count {
            let titleData = self.viewModel.sourceLocations[row].title
            let color = (row == pickerView.selectedRow(inComponent: component)) ? UIColor.orange : UIColor.black
            
            let title = NSAttributedString(
                string: titleData,
                attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16.0),
                             NSAttributedString.Key.foregroundColor: color])
            
            return title
        }
        return nil
    }
}
