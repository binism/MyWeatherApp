//
//  File.swift
//  MyWeatherApp
//
//  Created by Wu Binbin on 6/4/16.
//  Copyright © 2016 Wu Binbin. All rights reserved.
//

import Foundation
extension NSDate {
    
    
    func dayOfWeek() -> Int {
        
        
        let interval = self.timeIntervalSince1970;
        
        
        let days = Int(interval / 86400);
        
        
        return (days - 3) % 7;
        
        
    }
    
    
}