//
//  String.swift
//  frog
//
//  Created by Lili on 01/05/2019.
//  Copyright © 2019 Lili. All rights reserved.
//

import Foundation

extension String {
    func toSecureHTTPS() -> String {
        return self.contains("https") ? self : self.replacingOccurrences(of: "http", with: "https")
    }
}
