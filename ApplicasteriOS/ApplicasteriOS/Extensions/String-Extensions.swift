//
//  String-Extensions.swift
//  ApplicasteriOS
//
//  Created by Gio Lomsa on 10/18/19.
//  Copyright © 2019 Giorgi Lomsadze. All rights reserved.
//

import Foundation

extension String{
    // Convert date string to localized date string
    var dateStringToLocaleDateString:String{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        
        let publishedAt = dateFormatter.date(from: self)
        
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = .current
        dateFormatter.setLocalizedDateFormatFromTemplate("yyyy/MM/dd")
        
        return dateFormatter.string(from: publishedAt ?? Date())
    }
}
