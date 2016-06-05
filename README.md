#MyWeatherApp#
==========
[![BuddyBuild](https://dashboard.buddybuild.com/api/statusImage?appID=562a9aac2492560100211378&branch=master&build=latest)](https://dashboard.buddybuild.com/apps/562a9aac2492560100211378/build/latest)
![Language](https://img.shields.io/badge/language-Swift%202-orange.svg)
![License](https://img.shields.io/github/license/JakeLin/SwiftWeather.svg?style=flat)

SwiftWeather is an iOS weather app developed in Swift 2. The app has been actively upgrading to adopt the latest features of iOS and Swift language.


##How to build##
 
1)Clone the repository

```bash
$ git clone https://github.com/binism/MyWeatherApp.git
```

2) Install pods

```bash
$ cd MyWeatherApp
$ pod install
```

3) Open the workspace in Xcode

```bash
$ open "MyWeatherApp.xcworkspace"
```

4) Sign Up on [forecast.io](https://developer.forecast.io/) to get your own apiKey, and add it to VeiwController.swift
```swift
......
private let apiKey = "your apiKey" //https://developer.forecast.io
```
5) Compile and run the app in your simulator or device

6) If you don't see any data, please check "Simulator" -> "Debug" -> "Location" to change the location.

##Requirements##

* Xcode 7
* iOS 9

##Pods##
1) ForecastIO

[ForecastIO](https://github.com/sxg/ForecastIO)A Swift library for the Forecast.io weather API.

2) SwiftyJSON

[SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON) SwiftyJSON makes it easy to deal with JSON data in Swift. *NOT USED AT PRESENT PROJECT*

##TUDO##

1) Cannot deal with Rotate. Need to update main.storyboard with Rotate View

2) Adding new features

##SreenShots##

![截图1](https://github.com/binism/MyWeatherApp/blob/master/SreenShot/Screen%20Shot%202016-06-05%20at%204.37.03%20PM.png)

![截图2](https://github.com/binism/MyWeatherApp/blob/master/SreenShot/Screen%20Shot%202016-06-05%20at%204.09.16%20PM.png)
