//
//  File.swift
//  
//
//  Created by renaud on 21/11/2023.
//

import Foundation
import UIKit

public class WeatherTools {

    public static func gradientLayerForTemperature(kelvin: Double, frame: CGRect) -> CAGradientLayer {
        let topColor = colorForTemperature(kelvin: kelvin)
        let bottomColor = UIColor.white

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = frame
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)

        return gradientLayer
    }

    public static func colorForTemperature(kelvin: Double) -> UIColor {
        let celsius = kelvin - 273.15

        switch celsius {
        case ..<0:
            return UIColor(red: 0, green: 0, blue: max(0.55 + 0.45 * (celsius + 50) / 50 - 0.2, 0), alpha: 1)
        case 0..<10:
            return UIColor(red: 0, green: 0, blue: max(1 - 0.2, 0), alpha: 1)
        case 10..<20:
            return UIColor(red: 0, green: max(1 - 0.2, 0), blue: max(1 - 0.2, 0), alpha: 1)
        case 20..<30:
            return UIColor(red: max(0.5 - 0.2, 0), green: max(1 - 0.2, 0), blue: max(0.5 - 0.2, 0), alpha: 1)
        case 30..<40:
            return UIColor(red: max(1 - 0.2, 0), green: max(1 - 0.2, 0), blue: 0, alpha: 1)
        case 40...:
            return UIColor(red: 1, green: max(0.45 - 0.45 * (celsius - 40) / 10 - 0.2, 0), blue: 0, alpha: 1)
        default:
            return UIColor.gray
        }
    }

    public static func convertKelvinToCelsius(kelvin: Double) -> Double {
        return kelvin - 273.15
    }

    public static func iconTemperature(icon: String) -> UIImage? {
        return UIImage(named: icon)
    }
}
