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
    case "ClearDay":
        imageName = "sun"
    case "ClearNight":
        imageName = "fullmoon"
    case "Rain":
        imageName = "rain"
    case "Snow":
        imageName = "snow"
    case "Sleet":
        imageName = "rain_and_snow"
    case "Wind":
        imageName = "wind"
    case "Fog":
        imageName = "fog"
    case "Cloudy":
        imageName = "overcast"
    case "PartlyCloudyDay":
        imageName = "sun_max_clouds"
    case "PartlyCloudyNight":
        imageName = "moon_cloud_medium"
    default:
        imageName = "sun"
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


func weekdayINT2STRING(i : Int) -> String{
    let wdInt = i % 7
    var wdStr = "NULL"
    switch wdInt {
    case 0:
        wdStr = "Sun"
    case 1:
        wdStr = "Mon"
    case 2:
        wdStr = "Tues"
    case 3:
        wdStr = "Wed"
    case 4:
        wdStr = "Thur"
    case 5:
        wdStr = "Fri"
    case 6:
        wdStr = "Sat"
    default:
        wdStr = "NULL"
    }
    return wdStr
}