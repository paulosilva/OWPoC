//
//  OpenWeatherModel.swift
//  OWPoC
//
//  Created by Paulo Silva on 02/07/2018.
//  Copyright © 2018 Paulo Silva. All rights reserved.
//

import Foundation

//
struct OpenWeatherData: Codable {
    
    var cod: String?
    var message: Double?
    var cnt: Int?
    var list: [OpenWeatherItem]?
    var city: OpenWeatherCity?
    
    enum CodingKeys: String, CodingKey {
        //case code = "cod"
        case cod
        case message
        //case counter = "cnt"
        case cnt
        case list
        case city
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        cod = try values.decode(String.self, forKey: .cod)
        message = try values.decode(Double.self, forKey: .message)
        cnt = try values.decode(Int.self, forKey: .cnt)
        list = try values.decode([OpenWeatherItem].self, forKey: .list)
        city = try values.decode(OpenWeatherCity.self, forKey: .city)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(cod, forKey: .cod)
        try container.encode(message, forKey: .message)
        try container.encode(cnt, forKey: .cnt)
        try container.encode(list, forKey: .list)
        try container.encode(city, forKey: .city)
    }
        
}

//
struct OpenWeatherItem: Codable {
    
    var dt: CLong?
    var main: OpenWeatherItemMain?
    var weather: [OpenWeatherItemWeather]?
    var clouds: OpenWeatherItemClouds?
    var wind: OpenWeatherItemWind?
    var sys: OpenWeatherItemSys?
    var dt_txt: String?
    
    enum CodingKeys: String, CodingKey {
        case dt
        case main
        case weather
        case clouds
        case wind
        case sys
        case dt_txt
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        dt = try values.decode(CLong.self, forKey: .dt)
        main = try values.decode(OpenWeatherItemMain.self, forKey: .main)
        weather = try values.decode([OpenWeatherItemWeather].self, forKey: .weather)
        clouds = try values.decode(OpenWeatherItemClouds.self, forKey: .clouds)
        wind = try values.decode(OpenWeatherItemWind.self, forKey: .wind)
        sys = try values.decode(OpenWeatherItemSys.self, forKey: .sys)
        dt_txt = try values.decode(String.self, forKey: .dt_txt)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(dt, forKey: .dt)
        try container.encode(main, forKey: .main)
        try container.encode(weather, forKey: .weather)
        try container.encode(clouds, forKey: .clouds)
        try container.encode(wind, forKey: .wind)
        try container.encode(sys, forKey: .sys)
        try container.encode(dt_txt, forKey: .dt_txt)
    }
    
}

//
struct OpenWeatherItemClouds: Codable {
    
    var all: Int? // {"all":12}
    
    enum CodingKeys: String, CodingKey {
        case all
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        all = try values.decode(Int.self, forKey: .all)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(all, forKey: .all)
    }
    
}

//
struct OpenWeatherItemSys: Codable {
    
    var pod: String?
    
    enum CodingKeys: String, CodingKey {
        case pod
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        pod = try values.decode(String.self, forKey: .pod)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(pod, forKey: .pod)
    }
    
}

//
struct OpenWeatherItemWind: Codable {
    
    var speed: Double?
    var deg: Double?
    
    enum CodingKeys: String, CodingKey {
        case speed
        case deg
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        speed = try values.decode(Double.self, forKey: .speed)
        deg = try values.decode(Double.self, forKey: .deg)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(speed, forKey: .speed)
        try container.encode(deg, forKey: .deg)
    }
    
}

//
struct OpenWeatherItemWeather: Codable {
    var id: CLong?
    var main: String?
    var description: String?
    var icon: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case main
        case description
        case icon
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decode(CLong.self, forKey: .id)
        main = try values.decode(String.self, forKey: .main)
        description = try values.decode(String.self, forKey: .description)
        icon = try values.decode(String.self, forKey: .icon)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(main, forKey: .main)
        try container.encode(description, forKey: .description)
        try container.encode(icon, forKey: .icon)
    }
    
}

//
struct OpenWeatherItemMain: Codable {
    
    var temp: Double?
    var temp_min: Double?
    var temp_max: Double?
    var pressure: Double?
    var sea_level: Double?
    var grnd_level: Double?
    var humidity: Double?
    var temp_kf: Double?
    
    enum CodingKeys: String, CodingKey {
        case temp
        case temp_min
        case temp_max
        case pressure
        case sea_level
        case grnd_level
        case humidity
        case temp_kf
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        temp = try values.decode(Double.self, forKey: .temp)
        temp_min = try values.decode(Double.self, forKey: .temp_min)
        temp_max = try values.decode(Double.self, forKey: .temp_max)
        pressure = try values.decode(Double.self, forKey: .pressure)
        sea_level = try values.decode(Double.self, forKey: .sea_level)
        grnd_level = try values.decode(Double.self, forKey: .grnd_level)
        humidity = try values.decode(Double.self, forKey: .humidity)
        temp_kf = try values.decode(Double.self, forKey: .temp_kf)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(temp, forKey: .temp)
        try container.encode(temp_min, forKey: .temp_min)
        try container.encode(temp_max, forKey: .temp_max)
        try container.encode(pressure, forKey: .pressure)
        try container.encode(sea_level, forKey: .sea_level)
        try container.encode(grnd_level, forKey: .grnd_level)
        try container.encode(humidity, forKey: .humidity)
        try container.encode(temp_kf, forKey: .temp_kf)
    }
    
}

//
struct OpenWeatherCity: Codable {
    
    var id: CLong?
    var name: String?
    var country: String?
    var population: CLong?
    var coord: OpenWeatherCityCoord?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case country
        case population
        case coord
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decode(CLong.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        country = try values.decode(String.self, forKey: .country)
        population = try values.decode(CLong.self, forKey: .population)
        coord = try values.decode(OpenWeatherCityCoord.self, forKey: .coord)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(country, forKey: .country)
        try container.encode(population, forKey: .population)
        try container.encode(coord, forKey: .coord)
    }
    
}

//
struct OpenWeatherCityCoord: Codable {
    
    var lat: Double?
    var lon: Double?
    
    enum CodingKeys: String, CodingKey {
        case lat
        case lon
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        lat = try values.decode(Double.self, forKey: .lat)
        lon = try values.decode(Double.self, forKey: .lon)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(lat, forKey: .lat)
        try container.encode(lon, forKey: .lon)
    }
    
}

