//
//  Convert.swift
//  MyWeatherApp
//
//  Created by Wu Binbin on 6/1/16.
//  Copyright © 2016 Wu Binbin. All rights reserved.
//

import Foundation
import UIKit
func weatherIconFromString(stringIcon: String) -> UIImage {
    
    var imageName: String
    
    switch stringIcon {
    case "clear-day":
        imageName = "clear-day"
    case "clear-night":
        imageName = "clear-night"
    case "rain":
        imageName = "rain"
    case "snow":
        imageName = "snow"
    case "sleet":
        imageName = "sleet"
    case "wind":
        imageName = "wind"
    case "fog":
        imageName = "fog"
    case "cloudy":
        imageName = "cloudy"
    case "partly-cloudy-day":
        imageName = "partly-cloudy"
    case "partly-cloudy-night":
        imageName = "cloudy-night"
    default:
        imageName = "default"
    }
    
    let iconImage = UIImage(named: imageName)
    return iconImage!
    
}

func Fahrenheit2Celsius(f: Float) -> Int {
    return Int((Double(f)-32.0) / 1.8)
}
