//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Dhananjay Kumar DUbey on 19/1/21.
//


import Foundation
import UIKit.UIImage

/// Image fetcher class
class ImageFetcher: ContentFetcher {
    typealias ContentType = ImageRequest
            
    /// Error to be displayed when image downloading fails
    enum ImageFetcherError: Error {
        case unableToFetchImage
    }
    
    /// NSCache object used to cache image for key
    static let cache = NSCache<NSString, UIImage>()
    
    private let session: NetworkSession
    
    
    /**
     Image fetcher initilizer with Network session
     
     - parameter session: Network session using which image needs to be downloaded, by default URLSession.shared is used
     
     */
    required init(session: NetworkSession = URLSession.shared) {
        self.session = session
    }
    
    func fetchContent(_ content: ContentType, completionHandler: @escaping ((Result<UIImage>) -> Void)) {
        guard let url = content.url else {
            completionHandler(.failed(ImageFetcherError.unableToFetchImage))
            return
        }
        if let cachedImage = type(of: self).cache.object(forKey: url.absoluteString as NSString) {
            // we have image
            completionHandler(.success(cachedImage))
            return
        }
        
        self.session.call(content) { [key = url.absoluteString] result in
            
            guard let imageData = result.value, let image = UIImage(data: imageData) else {
                
                completionHandler(.failed(ImageFetcherError.unableToFetchImage))
                return
                
            }
            
            type(of: self).cache.setObject(image, forKey: key as NSString)
            completionHandler(.success(image))
        }
    }
}

