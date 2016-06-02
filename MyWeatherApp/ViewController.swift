//
//  ViewController.swift
//  MyWeatherApp
//
//  Created by Wu Binbin on 5/24/16.
//  Copyright © 2016 Wu Binbin. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation
import SwiftyJSON
import ForecastIO
class ViewController: UIViewController, CLLocationManagerDelegate {
    //MARK:@IBOut Today
    //UserLocation
    @IBOutlet weak var UserLocationLabel: UILabel!
    
    //SummaryStackView
    @IBOutlet weak var SummaryIcon: UIImageView!
    @IBOutlet weak var SummaryLabel: UILabel!
    
    //CurrentTemrature
    @IBOutlet weak var CurrentTempratureLabel: UILabel!
    
    //TodayHighTempStackView
    @IBOutlet weak var TodayHighTemperature: UILabel!
    @IBOutlet weak var TodayHighTemperatureLabel: UILabel!
    
    //TodayLowTempStackView
    @IBOutlet weak var TodayLowTemperature: UILabel!
    @IBOutlet weak var TodayLowTemperatureLabel: UILabel!
    
    //HeatIndexImg
    @IBOutlet weak var HeatIndexImg: UIImageView!
    
    //windbag&WindStackView
    @IBOutlet weak var windbagImg: UIImageView!
    @IBOutlet weak var WindIndex: UILabel!
    @IBOutlet weak var WindLabel: UILabel!
    
    //umbrella&RainStackView
    @IBOutlet weak var umbrellaImg: UIImageView!
    @IBOutlet weak var RainIndex: UILabel!
    @IBOutlet weak var RainLabel: UILabel!
    
    //humidity&HumidityStackView
    @IBOutlet weak var humidityImg: UIImageView!
    @IBOutlet weak var HumidityIndex: UILabel!
    @IBOutlet weak var HumidityLabel: UILabel!
    
    
    //MARK:@IBOutlet weekday
    
    //1stDayStackView
    @IBOutlet weak var DayOneWeekDay: UILabel!
    @IBOutlet weak var DayOneImg: UIImageView!
    @IBOutlet weak var DayOneHighLowTemp: UILabel!
    
    //2ndDayStackView
    @IBOutlet weak var DayTwoWeekDay: UILabel!
    @IBOutlet weak var DayTwoImg: UIImageView!
    @IBOutlet weak var DayTwoHighLowTemp: UILabel!
    
    //3rdDayStackView
    @IBOutlet weak var DayThreeWeekDaty: UILabel!
    @IBOutlet weak var DayThreeImg: UIImageView!
    @IBOutlet weak var DayThreeHighLowTemp: UILabel!
    
    //4thDayStackView
    @IBOutlet weak var DayFourWeekDay: UILabel!
    @IBOutlet weak var DayFourImg: UIImageView!
    @IBOutlet weak var DayFourHighLowTemp: UILabel!
    
    
    //5thDayStackView
    @IBOutlet weak var DayFiveWeekDay: UILabel!
    @IBOutlet weak var DayFiveImg: UIImageView!
    @IBOutlet weak var DayFiveHighLowTemp: UILabel!
    
    //6thDayStackView
    @IBOutlet weak var DaySixWeekDay: UILabel!
    @IBOutlet weak var DaySixImg: UIImageView!
    @IBOutlet weak var DaySixHighLowTemp: UILabel!
    
    var seenError : Bool = false
    var locationFixAchieved : Bool = false
    var locationStatus : NSString = "Not Started"
    var locationManager: CLLocationManager!
    var userLocation : String!
    var userLatitude : Double!
    var userLongitude : Double!
    var userTemperatureCelsius : Bool!
    private let apiKey = "3ca0a959a8dec53b4f84092dc623c246" //https://developer.forecast.io
    //private let baseURL = "https://api.forecast.io/forecast/"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initLocationManager()
        
    }
    
    //MARK: Location
    func initLocationManager() {
        seenError = false
        locationFixAchieved = false
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.requestWhenInUseAuthorization()
    }
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: {(placemarks, error)->Void in
            
            let pm = placemarks![0]
            self.displayLocationInfo(pm)
        })
        
        if (locationFixAchieved == false) {
            locationFixAchieved = true
            var locationArray = locations as NSArray
            var locationObj = locationArray.lastObject as! CLLocation
            var coord = locationObj.coordinate
            self.userLatitude = coord.latitude
            self.userLongitude = coord.longitude
            //
            //getCurrentWeatherData()
             getCurrentWeatherInfo()

            
        }
    }
    func displayLocationInfo(placemark: CLPlacemark?) {
        if let containsPlacemark = placemark {
            //stop updating location to save battery life
            locationManager.stopUpdatingLocation()
            let locality = (containsPlacemark.locality != nil) ? containsPlacemark.locality : ""
            let postalCode = (containsPlacemark.postalCode != nil) ? containsPlacemark.postalCode : ""
            let administrativeArea = (containsPlacemark.administrativeArea != nil) ? containsPlacemark.administrativeArea : ""
            let country = (containsPlacemark.country != nil) ? containsPlacemark.country : ""
            print(locality)
            print(postalCode)
            print(administrativeArea)
            print(country)
            
            self.UserLocationLabel.text = locality
            
        }
    }
    
    func locationManager(manager: CLLocationManager,
                         didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        var shouldIAllow = false
        
        switch status {
        case CLAuthorizationStatus.Restricted:
            locationStatus = "Restricted Access to location"
        case CLAuthorizationStatus.Denied:
            locationStatus = "User denied access to location"
        case CLAuthorizationStatus.NotDetermined:
            locationStatus = "Status not determined"
        default:
            locationStatus = "Allowed to location Access"
            shouldIAllow = true
        }
        NSNotificationCenter.defaultCenter().postNotificationName("LabelHasbeenUpdated", object: nil)
        if (shouldIAllow == true) {
            NSLog("Location to Allowed")
            // Start location services
            locationManager.startUpdatingLocation()
        } else {
            NSLog("Denied access: \(locationStatus)")
        }
    }
    //MARK: WeatherInfo
    func getCurrentWeatherInfo() -> Void {
        let forecastIOClient = APIClient(apiKey: "\(apiKey)")
        forecastIOClient.getForecast(latitude: userLatitude, longitude: userLongitude) { (currentForecast, error) -> Void in
            if let currentForecast = currentForecast {
                //  We got the current forecast!
                
                
                //CurrentTemprature
                if let CurrentTemprature = currentForecast.currently?.apparentTemperature {
                    print("current temprature: \(CurrentTemprature)")
                    self.CurrentTempratureLabel.text = "\(Fahrenheit2Celsius(CurrentTemprature))°"
                }
                else {
                    print("Cannot get CurrentTemprature")
                }
                
                
                //Today Summary
                if let Summary: String = currentForecast.currently?.summary {
                    print("Summary: \(Summary)")
                    self.SummaryLabel.text = summaryEN2CN(Summary)
                }
                else {
                    print("Cannot get Summary")
                }
                
                
                //Today High Temperatur
                if let HighTemp = currentForecast.daily?.data![1].apparentTemperatureMax {
                    print("Today High temp: \(HighTemp)")
                    self.TodayHighTemperature.text = "\(Fahrenheit2Celsius(HighTemp))"
                }
                else {
                    print("Cannot get High temprature")
                }
                
                
                
                //Today Low Temperature
                if let LowTemp = currentForecast.daily?.data![1].apparentTemperatureMin{
                    print("Today Low temp: \(LowTemp)")
                    self.TodayLowTemperature.text = "\(Fahrenheit2Celsius(LowTemp))"
                    
                }
                else {
                    print("Cannot get Low temprature")
                }
                
                
                //Wind Speed
                if let WindSpeed = currentForecast.currently?.windSpeed {
                    print("Wind Speed: \(WindSpeed)")
                    self.WindIndex.text = "\(WindSpeed)"
                }
                else {
                    print("Cannot get Wind Speed")
                }
                
                
                //Rain precipProbability
                if let RainPreci = currentForecast.currently?.precipProbability {
                    print("Rain Preci: \(RainPreci)")
                    self.RainIndex.text = "\(RainPreci)"
                }
                else {
                    print("Cannot get Rain Preci")
                }
                
                
                //Humidity
                if let Humi = currentForecast.currently?.humidity {
                    print("Humidity: \(Humi)")
                    self.HumidityIndex.text = "\(Humi)"
                }
                else {
                    print("Canot get Humidity")
                }
                
                
                
                //MARK: Day1~6 Icon
                //Day1 Icon
                if let dayOneIcon = currentForecast.daily?.data![2].icon {
                    print("dayOne icon: \(dayOneIcon)")
                }
                //Day2 Icon
                if let dayTwoIcon = currentForecast.daily?.data![3].icon {
                    print("dayTwo icon: \(dayTwoIcon)")
                }
                //Day3 Icon
                if let dayThreeIcon = currentForecast.daily?.data![4].icon {
                    print("dayTHree icon: \(dayThreeIcon)")
                }
                //Day4 Icon
                if let dayFourIcon = currentForecast.daily?.data![5].icon {
                    print("dayFour icon: \(dayFourIcon)")
                }
                //Day5 Icon
                if let dayFiveIcon = currentForecast.daily?.data![6].icon {
                    print("dayFive icon: \(dayFiveIcon)")
                }
                //Day6 Icon
                if let daySixIcon = currentForecast.daily?.data![7].icon {
                    print("daySix icon: \(daySixIcon)")
                }
                
                
                
                //MARK: Day1~6 High/Low temprature
                //Day1
                if let dayOneHighTemp = currentForecast.daily?.data![2].apparentTemperatureMax ,
                    dayOneLowTemp = currentForecast.daily?.data![2].apparentTemperatureMin  {
                    print("Day one High : \(dayOneHighTemp)")
                    print("Day one Low : \(dayOneLowTemp)")
                    let HignLow = "\(Fahrenheit2Celsius(dayOneLowTemp))°/\(Fahrenheit2Celsius(dayOneHighTemp))°"
                    self.DayOneHighLowTemp.text = HignLow
                }
                else {
                    print("Cannot get Day one High and Low")
                }
                //Day2
                if let dayTwoHighTemp = currentForecast.daily?.data![3].apparentTemperatureMax ,
                    dayTwoLowTemp = currentForecast.daily?.data![3].apparentTemperatureMin  {
                    print("Day two High : \(dayTwoHighTemp)")
                    print("Day two Low : \(dayTwoLowTemp)")
                    let HignLow = "\(Fahrenheit2Celsius(dayTwoLowTemp))°/\(Fahrenheit2Celsius(dayTwoHighTemp))°"
                    self.DayTwoHighLowTemp.text = HignLow
                }
                else {
                    print("Cannot get Day two High and Low")
                }
                //Day3
                if let dayThreeHighTemp = currentForecast.daily?.data![4].apparentTemperatureMax ,
                    dayThreeLowTemp = currentForecast.daily?.data![4].apparentTemperatureMin  {
                    print("Day three High : \(dayThreeHighTemp)")
                    print("Day three Low : \(dayThreeLowTemp)")
                    let HignLow = "\(Fahrenheit2Celsius(dayThreeLowTemp))°/\(Fahrenheit2Celsius(dayThreeHighTemp))°"
                    self.DayThreeHighLowTemp.text = HignLow
                }
                else {
                    print("Cannot get Day Three High and Low")
                }
                //Day4
                if let dayFourHighTemp = currentForecast.daily?.data![5].apparentTemperatureMax ,
                    dayFourLowTemp = currentForecast.daily?.data![5].apparentTemperatureMin  {
                    print("Day four High : \(dayFourHighTemp)")
                    print("Day four Low : \(dayFourLowTemp)")
                    let HignLow = "\(Fahrenheit2Celsius(dayFourLowTemp))°/\(Fahrenheit2Celsius(dayFourHighTemp))°"
                    self.DayFourHighLowTemp.text = HignLow
                }
                else {
                    print("Cannot get Day Four High and Low")
                }
                //Day5
                if let dayFiveHighTemp = currentForecast.daily?.data![6].apparentTemperatureMax ,
                    dayFiveLowTemp = currentForecast.daily?.data![6].apparentTemperatureMin  {
                    print("Day five High : \(dayFiveHighTemp)")
                    print("Day five Low : \(dayFiveLowTemp)")
                    let HignLow = "\(Fahrenheit2Celsius(dayFiveLowTemp))°/\(Fahrenheit2Celsius(dayFiveHighTemp))°"
                    self.DayFiveHighLowTemp.text = HignLow
                }
                else {
                    print("Cannot get Day Five High and Low")
                }
                //Day6
                if let daySixHighTemp = currentForecast.daily?.data![7].apparentTemperatureMax ,
                    daySixLowTemp = currentForecast.daily?.data![7].apparentTemperatureMin  {
                    print("Day six High : \(daySixHighTemp)")
                    print("Day six Low : \(daySixLowTemp)")
                    let HignLow = "\(Fahrenheit2Celsius(daySixLowTemp))°/\(Fahrenheit2Celsius(daySixHighTemp))°"
                    self.DaySixHighLowTemp.text = HignLow
                }
                else {
                    print("Cannot get Day Six High and Low")
                }
            } else if let error = error {
                //  Uh-oh we have an error!
                print(error)
            }
            
        }
        let Today = NSDate()
        let DayOne = Today.dateByAddingTimeInterval(86400)
        forecastIOClient.getForecast(latitude: userLatitude, longitude: userLongitude, time: DayOne) { (DayOneForecast, DayOneError) in
            if let dayOneForecast = DayOneForecast {
                if let dayOneSummary = dayOneForecast.currently?.summary {
                    print("Day one Summary: \(dayOneSummary)")
                }
                else {
                    print("Cannot get Day one Summary")
                }
                if let dayOneHighTemp = dayOneForecast.currently?.apparentTemperatureMax , dayOneLowTemp = dayOneForecast.currently?.apparentTemperatureMin  {
                    print("Day one High : \(dayOneHighTemp)")
                    print("Day one Low : \(dayOneLowTemp)")
                }
                else {
                    print("Cannot get Day one High and Low")
                }
                
            }
            else if let error = DayOneError {
            //  Uh-oh we have an error!
            print(error)
            }

        }
        
        

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

