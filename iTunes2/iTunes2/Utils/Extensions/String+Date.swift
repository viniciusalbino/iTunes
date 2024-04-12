//
//  String+Date.swift
//  iTunes2
//
//  Created by Vinicius Albino on 19/08/23.
//

import Foundation
import Foundation

extension String {
    func toDateWithFormat() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter.date(from: self)
    }
    
    func formattedDate() -> String? {
        guard let date = self.toDateWithFormat() else { return nil }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale.current
        
        return dateFormatter.string(from: date)
    }
}
