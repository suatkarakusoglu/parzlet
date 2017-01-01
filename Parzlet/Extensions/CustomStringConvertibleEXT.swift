//
//  CustomStringConvertibleEXT.swift
//  Parzlet
//
//  Created by Suat Karakusoglu on 1/1/17.
//  Copyright © 2017 Parzlet. All rights reserved.
//

import Foundation

extension CustomStringConvertible
{
    func logMe(note: String? = nil)
    {
        let debugPrintText = "[\(Time.getCurrentTime())] >\(note ?? "") \(self.description)"
        debugPrint("\(self.description)");
    }
}

struct Time
{
    static func getCurrentTime() -> String
    {
        let currentDate = NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        let convertedDate = dateFormatter.stringFromDate(currentDate)
        return convertedDate
    }
}
