//
//  ext_Gradient.swift
//  ext_Gradient
//
//  Created by Frank Cipolla on 8/31/21.
//

import SwiftUI

protocol GradientExtendable {
    static var hue: Gradient {get}
    static var blank: Gradient {get}
    static func linearGradient(_ axis: Axis) -> LinearGradient
    static func fromValues(_ values: VM_Color.RGBAValues, parameter: Parameter) -> Gradient
}

extension Gradient: GradientExtendable
{
    
    static let hue = Gradient(colors: [.red, .yellow, .green, .blue, .indigo, .violet, .red])
    let blank = Gradient(colors: [])
    
    func linearGradient(_ axis: Axis) -> LinearGradient {
        if axis == .horizontal {
            return LinearGradient(gradient: self, startPoint: .leading, endPoint: .trailing)
        }
        else { // axis == .vertical
            return LinearGradient(gradient: self, startPoint: .top, endPoint: .bottom)
        }
    }
    
    static func fromValues(_ values: VM_Color.RGBAValues, parameter: Parameter) -> Gradient {
        var startColor = values
        var endColor = values
        switch parameter {
        case .red:
            startColor.red = 0
            endColor.red = 1
        case .green:
            startColor.green = 0
            endColor.green = 1
        case .blue:
            startColor.blue = 0
            endColor.blue = 1
        case .alpha:
            startColor.alpha = 0
            endColor.alpha = 1
        default:
            fatalError("Parameter \(parameter) not in color space")
        }
        return Gradient(colors: [Color.fromValues(startColor), Color.fromValues(endColor)])
    }
    
    static func fromValues(_ values: VM_Color.HSBAValues, parameter: Parameter) -> Gradient {
        var startColor = values
        var endColor = values
        switch parameter {
        case .hue:
            return Gradient.hue
        case .saturation:
            startColor.saturation = 0
            endColor.saturation = 1
        case .brightness:
            startColor.brightness = 0
            endColor.brightness = 1
        case .alpha:
            startColor.alpha = 0
            endColor.alpha = 1
        default:
            fatalError("Parameter \(parameter) not in color space")
        }
        return Gradient(colors: [Color.fromValues(startColor), Color.fromValues(endColor)])
    }
    
    static func fromValues(_ values: VM_Color.CMYKAValues, parameter: Parameter) -> Gradient {
        var startColor = values
        var endColor = values
        switch parameter {
        case .alpha:
            startColor.alpha = 0
            endColor.alpha = 1
        case .cyan:
            startColor.cyan = 0
            endColor.cyan = 1
        case .magenta:
            startColor.magenta = 0
            endColor.magenta = 1
        case .yellow:
            startColor.yellow = 0
            endColor.yellow = 1
        case .black:
            startColor.black = 0
            endColor.black = 1
        default:
            fatalError("Parameter \(parameter) not in color space")
        }
        return Gradient(colors: [Color.fromValues(startColor), Color.fromValues(endColor)])
    }
    
    static func fromValues(_ values: VM_Color.GreyscaleValues, parameter: Parameter) -> Gradient {
        var startColor = values
        var endColor = values
        switch parameter {
  
        case .alpha:
            startColor.alpha = 0
            endColor.alpha = 1
        case .white:
            startColor.white = 0
            endColor.white = 1
        default:
            fatalError("Parameter \(parameter) not in color space")
        }
        return Gradient(colors: [Color.fromValues(startColor), Color.fromValues(endColor)])
    }
    
    static func canvasGradient(axis: Axis, horizontal: Parameter, vertical: Parameter) -> Gradient {
        switch horizonta.colorSpace {
            
        case .RGBA:
            let horizontalColor = Color.fromValues(horizontal.valuesInRGB)
            let verticalColor = Color.fromValues(vertical.valuesInRGB)
            let blendedColor = Color.fromValues(Color.blend(color1: horizontal.valuesInRGB, color2: vertical.valuesInRGB, alpha: 0.5))
            return axis === .horizontal ?
            Gradient(colors: [verticalColor, blendedColor]) : Gradient(colors: [horizontalColor, blendedColor])
        case .HSBA:
            if axis == .horizontal {
                if horizontal == .brightness || horizontal == .saturation {
                    return Gradient(colors: [])
                } else if horizontal == .hue {
                    return .hue
                } else {
                    return Gradient(colors:  [])
                }
            } else { if vertical == .brightness || vertical == .saturation {
                return Gradient(colors: [])
            } else if vertical == .hue {
                return .hue
            } else {
                return Gradient(colors: [])
            }
            }
        case .CMYKA:
            let horizontalColor = Color.fromValues(horizontal.valuesInCMYK)
            let verticalColor = Color.fromValues(vertical.valuesInCMYK)
            let blendedColor = Color.fromValues(Color.blend(color1: horizontal.valuesInCMYK, color2: vertical.valuesInCMYK, alpha: 0.5))
            return axis == .horizontal ?
            Gradient(colors: [verticalColor, blendedColor]) : Gradient(colors: [horizontalColor, blendedColor])
        case .greyscale:
            return axis == .horizontal ?
            Gradient(colors: [horizontal == .white ? .black : .clear, .white]) : Gradient(colors: [vertical == .white ? .black : .clear, .white])
        }
    }
}
