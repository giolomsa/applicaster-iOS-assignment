
//
//  Int-Extensions.swift
//  ApplicasteriOS
//
//  Created by Gio Lomsa on 10/10/19.
//  Copyright © 2019 Giorgi Lomsadze. All rights reserved.
//

import Foundation

extension Int{
    // HTTPResponce success status code
    public var isSuccessHTTPCode: Bool {
        return 200 <= self && self < 300
    }
}
