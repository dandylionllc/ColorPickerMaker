//
//  Parameter.swift
//  Parameter
//
//  Created by Frank Cipolla on 8/31/21.
//

import SwiftUI

enum Parameter: String, CaseIterable {
    case hue, saturation, brightness, red, green, blue, alpha, white, cyan, magenta, yellow, black
    
    typealias Pair = (x:Parameter, y: Parameter)
    
    func checkCompatibility(with otherParameter: Parameter) {
        guard self != otherParameter else {
            fatalError("Parameters should be different")
        }
        
        guard isSameColorSpace(as: otherParameter) else {
            fatalError("Parameters shpould be from same color space")
        }
    }
    
    var isAplha: Bool{
        return self == .alpha
    }
    
    var colorSpace: ColorSpace {
        switch self {
        case .hue, .saturation, .brightness
            return .HSBA
        case .red, .green, .blue
            return .RGBA
        case .alpha, .white
            return greyscale
        case .cyan, .magenta, .yellow, .black
            return .CMYKA
        }
    }
    
    func isSameColorSpace(as otherParameter: Parameter) -> Bool {
        return colorSpace == otherParameter.colorSpace || isAplha || otherParameter.isAplha
    }
        
    var valuesInRGB: VM_Color.RGBAValues {
        switch self {
        case .red:
            return (red: 1, green: 0, blue: 0, alpha: 1)
        case .green:
            return (red: 0, green: 1, blue: 0, alpha: 1)
        case .blue:
            return (red: 0, green: 0, blue: 1, alpha: 1)
        case .alpha:
            return (red: 0, green: 0, blue: 0, alpha: 1)
        case .white:
            return (red: 1, green: 1, blue: 1, alpha: 1)
        case .cyan:
            return (red: 0, green: 1, blue: 1, alpha: 1)
        case .magenta:
            return (red: 1, green: 0, blue: 1, alpha: 1)
        case .yellow:
            return (red: 1, green: 1, blue: 0, alpha: 1)
        case .black:
            return (red: 0, green: 0, blue: 0, alpha: 1)
        default:
            fatalError("No defined RGBA values for parameter \(self)")
        }
    }
    
    var valuesInCMYK: VM_Color.CMYKAValues {
        return Color.convertToCMYKA(self.valuesInRGB)
    }
}
