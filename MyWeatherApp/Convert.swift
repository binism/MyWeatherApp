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

func summaryEN2CN(summaryEN : String ) -> String {
    var summaryCN : String
    switch summaryEN {
    case "clear-day", "clear-night" :
        summaryCN = "晴"
    case "rain" :
        summaryCN = "雨"
    case "snow" :
        summaryCN = "雪"
    case "sleet" :
        summaryCN = "冻雨"
    case "wind" :
        summaryCN = "风"
    case "fog" :
        summaryCN = "雾"
    case "cloudy" :
        summaryCN = "阴"
    case "partly-cloudy-day", "partly-cloudy-night" :
        summaryCN = "多云"
    default:
        summaryCN = summaryEN
    }
    return summaryCN
}
