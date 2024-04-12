//
//  Int+Extensions.swift
//  iTunes2
//
//  Created by Vinicius Albino on 19/08/23.
//

import Foundation

extension Int {
    func formatToMinutesAndSeconds() -> String {
        let totalSeconds = Int(self / 1000)
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        
        return String(format: "%d:%02d", minutes, seconds)
    }
}
