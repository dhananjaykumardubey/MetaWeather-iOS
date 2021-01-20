//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Dhananjay Kumar Dubey on 19/1/21.
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
    
    /// Callback returning weatherReport which will be displayed in VC
    var weatherReport: ((ConsolidatedWeather?) -> Void)?
    
    //MARK: Private properties
    private let apiClient: APIClient?
    private lazy var locationLists: Locations = []
    private var location: Location?
    
    /// Source location
    var sourceLocations: Locations {
        return self.locationLists
    }
    
    required init(with apiClient: WeatherAPIClient) {
        self.apiClient = apiClient
        self.locationLists = self.readAvailableLocations()
    }

    //MARK: Exposed functions
    
    /// BindViewModel call to let viewmodel know that bindViewModel of viewcontroller is called and completed and properties can be observed
    func bindViewModel() {
        self.selectedLocation?(self.location?.title ?? "")
    }
    
    /**
     Get consolidated weather for given location
     - parameters:
        - location: Location for which weather needs to be fetched
        - date: Date for which weather is to be fetched, should be in format of `2021/1/21`
     */
    func getWeatherReport(for location: String, for date: String) {
        self.startLoading?()
        self.apiClient?.fetchWeatherReport(for: location, and: date, then: { [weak self] response in
            guard let _self = self else { return }
            DispatchQueue.main.async {
                _self.endLoading?()
                switch response {
                case let .success(lists):
                    _self.endLoading?()
                    _self.weatherReport?(lists.first)
                case let .failed(error):
                    _self.showError?(error.localizedDescription)
                }
            }
        })
    }
    
    /**
     Selected location. Let viewModel know which location was selected for fetching the weather report
     - parameters:
        - index: Selected currency index
     */
    func selectedLocation(index: Int) {
        if index < self.locationLists.count {
            self.location = self.locationLists[index]
            
            guard let locationTitle = self.location?.title,
                  let woied = self.location?.woeid,
                let date = Format.formatTomorrowDate(for: locationTitle) else { return }
            
            self.selectedLocation?(locationTitle)
            self.getWeatherReport(for: "\(woied)", for: date)
        }
    }
       
    //MARK: Private functions

    private func readAvailableLocations() -> Locations {
        
        guard let url = Bundle.main.url(forResource: "Locations", withExtension: "json")
            else { return [] }
        do {
            let jsonData = try Data(contentsOf: url)
            let responseData = try JSONDecoder().decode(Locations.self, from: jsonData)
            return responseData
        }
        catch {
            print(error)
        }
        return []
    }
}
