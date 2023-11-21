//
//  File.swift
//  
//
//  Created by renaud on 21/11/2023.
//

import Foundation
import UIKit

public class WeatherTools {

    public static func colorForTemperature(kelvin: Double) -> UIColor {
        let celsius = kelvin - 273.15

        switch celsius {
        case ..<0:
            return UIColor(red: 0, green: 0, blue: 0.55 + 0.45 * (celsius + 50) / 50, alpha: 1)
        case 0..<10:
            return UIColor(red: 0, green: 0, blue: 1, alpha: 1)
        case 10..<20:
            return UIColor(red: 0, green: 1, blue: 1, alpha: 1)
        case 20..<30:
            return UIColor(red: 0.5, green: 1, blue: 0.5, alpha: 1)
        case 30..<40:
            return UIColor(red: 1, green: 1, blue: 0, alpha: 1)
        case 40...:
            return UIColor(red: 1, green: 0.45 - 0.45 * (celsius - 40) / 10, blue: 0, alpha: 1)
        default:
            return UIColor.white
        }
    }

    public static func convertKelvinToCelsius(kelvin: Double) -> Double {
        return kelvin - 273.15
    }

    public static func iconTemperature(icon: String) -> UIImage? {
        return UIImage(named: icon)
    }
}
