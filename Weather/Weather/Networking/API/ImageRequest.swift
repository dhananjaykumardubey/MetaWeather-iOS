//
//  ImageRequest.swift
//  Weather
//
//  Created by Sushil Nagarale on 20/1/21.
//

import Foundation

struct ImageRequest {
    
    let url: URL?
    let stateAbbreviation: String
    
    /**
     Initializes `ImageRequest` with URL and stateAbbreviation
    
     - parameters:
        - url: Base URL
        - stateAbbreviation: location Id for which weather is to be fetched
     */
    init(url: URL, stateAbbreviation: String) {
        self.url = url
        self.stateAbbreviation = stateAbbreviation
    }
}

extension ImageRequest: DownloadableContent {
    
    /// Express the URL in form of url request, in case of images, no parameter is required
    func expressAsURLRequest() throws -> URLRequest {
        guard let url = self.url else {
            throw NSError(domain: "Invalid URL", code: 1, userInfo: nil)
        }
        return URLRequest(url: url)
    }
}
