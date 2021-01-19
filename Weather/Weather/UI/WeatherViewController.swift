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
            self.topView.layer.cornerRadius = CGFloat(8.0)
            self.topView.clipsToBounds = true
        }
    }
    
    @IBOutlet private weak var bottomView: UIView! {
        didSet {
            self.bottomView.layer.cornerRadius = CGFloat(8.0)
            self.bottomView.clipsToBounds = true
        }
    }
    
    @IBOutlet private weak var locationTextField: UITextField! {
        didSet {
            self.locationTextField.textColor = UIColor.orange
            self.locationTextField.placeholder = "Choose Location"
            self.locationTextField.borderStyle = .roundedRect
            self.locationTextField.layer.borderWidth = CGFloat(1.0)
            self.locationTextField.layer.cornerRadius = CGFloat(8.0)
            self.locationTextField.layer.borderColor = UIColor.gray.withAlphaComponent(0.8).cgColor
            self.locationTextField.rightViewMode = .always
            self.locationTextField.setupRightImage(imageName: "downArrow")
            self.locationTextField.tintColor = .clear
            self.locationTextField.addDoneButton()
//            self.locationTextField.delegate = self
        }
    }
    
    private lazy var locationPickerView = UIPickerView()
    private let viewModel = WeatherViewModel(with: WeatherAPIClient(baseURL: NetworkConstant.baseURL))
    private let loadingManager = LoadingViewManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Weather Report"
        self.locationTextField.inputView = self.locationPickerView
//        self.locationPickerView.delegate = self
//        self.locationPickerView.selectRow(self.viewModel.usdIndex, inComponent: 0, animated: true)
        self.bindViewModel()
    }

    private func bindViewModel() {
        
        self.viewModel.startLoading = { [weak self] in
            guard let _self = self else { return }
            _self.loadingManager.showLoading(superView: _self.view)
        }
//
        self.viewModel.endLoading = { [weak self] in
            guard let _self = self else { return }
            _self.loadingManager.removeLoading()
        }
//
        self.viewModel.showError = { [weak self] message in
            guard let _self = self else { return }
            _self.loadingManager.showError(superView: _self.bottomView, message: message)
        }
//
//        self.viewModel.selectedSourceCurrency = { [weak self] currency in
//            guard let _self = self else { return }
//            _self.sourceCurrencyTextField.text = currency
//        }
//
//        self.viewModel.exchangedRateData = { [weak self] data in
//            guard let _self = self else { return }
//            _self.dataSource = ExchangeRateDataSource(with: data)
//            _self.collectionView.dataSource = _self.dataSource
//            _self.collectionView.reloadData()
//        }
//
//        self.viewModel.selectedCurrency(index: self.currencyPickerView.selectedRow(inComponent: 0))
        self.viewModel.bindViewModel()
    }
    
}

// MARK: TextField delegate

extension WeatherViewController: UITextFieldDelegate {
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField == self.locationTextField {
//            self.viewModel.selectedCurrency(index: self.locationPickerView.selectedRow(inComponent: 0))
        }
        textField.resignFirstResponder()
        return true
    }
}

// MARK: PickerView delegate and datasource

//extension WeatherViewController: UIPickerViewDataSource, UIPickerViewDelegate {
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return self.viewModel.sourceCurrencies.count
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        if row < self.viewModel.sourceCurrencies.count {
//            return self.viewModel.sourceCurrencies[row]
//        }
//        return nil
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
//        
//        if row < self.viewModel.sourceCurrencies.count {
//            let titleData = self.viewModel.sourceCurrencies[row]
//            let color = (row == pickerView.selectedRow(inComponent: component)) ? UIColor.orange : UIColor.black
//            
//            let title = NSAttributedString(
//                string: titleData,
//                attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16.0),
//                             NSAttributedString.Key.foregroundColor: color])
//            
//            return title
//        }
//        return nil
//    }
//}
