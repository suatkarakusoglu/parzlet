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
        debugPrint("\(debugPrintText)");
    }
}

struct Time
{
    static func getCurrentTime() -> String
    {
        let currentDate = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        let convertedDate = dateFormatter.string(from: currentDate as Date)
        return convertedDate
    }
}
