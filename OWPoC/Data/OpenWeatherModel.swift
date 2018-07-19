//
//  DataModel.swift
//  OWPoC
//
//  Created by Paulo Silva on 05/07/2018.
//  Copyright © 2018 Paulo Silva. All rights reserved.
//

import Foundation


class OpenWeatherModel: NSObject {

    //
    private var openWeatherData: OpenWeatherData?
    
    //
    var itemNow: OpenWeatherItem?
    var listOfDays: [Int: OpenWeatherItem]?
    var listOfHours: [Int: [OpenWeatherItem]]?
    
    //
    init(_ weatherData: OpenWeatherData) {
        super.init()
        
        //
        self.openWeatherData = weatherData
        
        // Init Array's
        listOfDays = [Int: OpenWeatherItem]()
        listOfHours = [Int: [OpenWeatherItem]]()
        
        //
        self.itemNow = self.forecastNow ()

        //
        var _index = 0
        
        if let _counter =  openWeatherData!.list?.count {
            for index in stride(from: 0, to: _counter, by: 8) {

                //
                self.listOfDays![_index] = self.openWeatherData?.list![index]

                //
                let filter = self.openWeatherData?.list![index].dt_txt!.toDate(format: "yyyy-MM-dd HH:mm:ss")?.toString(format: "yyyy-MM-dd")
                self.listOfHours![_index] = self.forecastByDateFilter(filter!)

                _index+=1
                
            }

        }
        
    }
    
    //
    private func forecastNow () -> OpenWeatherItem {
        return self.openWeatherData!.list![0]
    }
    
    //
    private func forecastByStrideFilter (_ strideFilter: Int? = Optional.none) -> [OpenWeatherItem] {
        
        var _filter = 8 // 24/3 = 8
        if strideFilter != nil {
            _filter = strideFilter!
        }
        
        var timeList = [OpenWeatherItem]()
        if let _counter =  openWeatherData!.list?.count {
            for index in stride(from: 0, to: _counter, by: _filter) {
                timeList.append( self.openWeatherData!.list![index] )
            }
        }
        return timeList
        
    }
    
    //
    private func forecastByDateFilter(_ dateFilter: String) -> [OpenWeatherItem] {
        
        var timeList = [OpenWeatherItem]()
        for _item in self.openWeatherData!.list! {
            if _item.dt_txt?.lowercased().range(of: dateFilter) != nil {
                timeList.append( _item )
            }
        }
        return timeList
        
    }
    
}

