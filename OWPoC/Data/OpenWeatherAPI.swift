//
//  OpenWeatherAPI.swift
//  OWPoC
//
//  Created by Paulo Silva on 02/07/2018.
//  Copyright © 2018 Paulo Silva. All rights reserved.
//

import UIKit
import Foundation

class OpenWeatherAPI: NSObject {
    
    // MARK: Put your api key here, so the API work as expected
    
    var apiKey: String = ""
    private var apiUrl: String = "https://api.openweathermap.org/data/2.5/forecast?"
    
    // Options: xml Or json - For json just leave this as an empty string
    private var apiMode: String = ""
    private var apiUnits: String = "metric"
    
    // Search Criteria
    private var searchCountry: String = ""
    private var searchCity: String = ""
    private var searchUrl: String = ""
    
    //
    override init() {
        
    }
    
    //
    private func buildApiUrl() {
        
        self.searchUrl = String(format: "%@q=%@,%@&units=%@&appid=%@", self.apiUrl, self.searchCity, self.searchCountry, self.apiUnits, self.apiKey)
        if !self.apiMode.isEmpty {
            self.searchUrl = String(format: "%@q=%@,%@&units=%@&mode=%@&appid=%@", self.apiUrl, self.searchCity, self.searchCountry, self.apiUnits, self.apiMode, self.apiKey)
        }
        
    }
    
    //
    func fiveDayForecastForCity(_ searchCriteria: String, completion: @escaping (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
        
        //
        let _searchData = searchCriteria.split(separator: ",")
        
        if _searchData.isEmpty {
            
            //
            completion(nil, nil, SearchError.emptyCriteria("Empty Search Criteria ..."))
            
        } else {
            
            // Build the criteria
            let _searchCity = String(_searchData[0]).trimmingCharacters(in: .whitespacesAndNewlines).addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
            let _searchCountry = String(_searchData[1]).trimmingCharacters(in: .whitespacesAndNewlines).addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
            
            // Build the Url
            if _searchCity != self.searchCity || String(_searchData[1]) != self.searchCountry {
                
                self.searchCity = _searchCity!
                self.searchCountry = _searchCountry!
                self.buildApiUrl()
                
            }
            
            //
            let headers = ["content-type": "application/json"]
            let request = NSMutableURLRequest(url: URL(string: self.searchUrl)!)
            request.httpMethod = "GET"
            request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
            request.allHTTPHeaderFields = headers
            
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                
                // CompletionHandler
                completion(data, response, error)
                
            })
            
            //
            dataTask.resume()
            
        }
        
    }
    
}
