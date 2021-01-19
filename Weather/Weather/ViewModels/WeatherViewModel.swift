//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Sushil Nagarale on 19/1/21.
//

import Foundation

class WeatherViewModel {
    
    // MARK: Callbacks or observers
    
    /// Callback for showing loader
    var startLoading: (() -> Void)?
    
    /// Callback for removing the loader
    var endLoading: (() -> Void)?
    
    /// Callback for showing the error message
    var showError: ((String) -> Void)?
    
    /// Callback returning selected source currency
    var selectedLocation: ((String) -> Void)?
    
    /// Callback returning exchangeRateData as datasource
//    var exchangedRateData: (([[ExchangeRateData]]) -> Void)?
    
    //MARK: Private properties
    private let apiClient: APIClient?
    private lazy var locations: [String] = []
    private var location = ""
    
    required init(with apiClient: WeatherAPIClient) {
        self.apiClient = apiClient
//        self.locations = self.readAvailableCurrencies()
    }

    /// BindViewModel call to let viewmodel know that bindViewModel of viewcontroller is called and completed and properties can be observed
    func bindViewModel() {
        self.selectedLocation?(self.location)
        self.getWeatherReport(for: "")
    }
    
    /**
     Get consolidated weather for given location
     - parameters:
        - location: Location for which weather needs to be fetched
     */
    func getWeatherReport(for location: String) {
        self.startLoading?()
        self.apiClient?.fetchWeatherReport(for: "44418", then: { [weak self] data in
            guard let _self = self else { return }
            print("Data == \(data)")
        })
//        if self.shouldFetchExchangeRates() {
//            self.apiClient?.fetchListOfRecentRates(for: self.currencies, source: currency, then: { [weak self] response in
//                guard let _self = self else { return }
//                DispatchQueue.main.async {
//                    switch response {
//                    case let .success(lists):
//                        if lists.success, let quotes = lists.quotes, !quotes.isEmpty {
//                            _self.endLoading?()
//                            _self.exchangeRates = quotes
//                            do {
//                                try UserDefaults.standard.setObject(lists, forKey: currency)
//                                // had to save the current date, as lastTimestamp coming from API is always constant value
//                                try UserDefaults.standard.setObject(Date(), forKey: "lastServiceCallDate")
//                            } catch {
//                                print("Failed to save \(error)")
//                            }
//                            _self.mapExchangeRateData()
//                        } else {
//                            _self.showError?(lists.error?.info ?? "")
//                        }
//                    case let .failed(error):
//                        _self.showError?(error.localizedDescription)
//                    }
//                }
//            })
//        } else {
//            self.endLoading?()
//        }
    }
}
