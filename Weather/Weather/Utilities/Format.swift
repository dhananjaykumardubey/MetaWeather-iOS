//
//  Format .swift
//  Weather
//
//  Created by Dhananjay Kumar Dubey on 20/1/21.
//

import Foundation

struct Format {

    /// Return tomorrow's date for given timezone identifier
    static func formatTomorrowDate(for identifier: String) -> String? {
       let today = Date()
       let dateFormatter = DateFormatter()
       dateFormatter.dateFormat = "yyyy/MM/dd"
       if let tomorrow = today.tomorrow {
           return dateFormatter.string(from: tomorrow)
       }
        return nil
    }
}

