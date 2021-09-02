//
//  ext_Color.swift
//  ext_Color
//
//  Created by Frank Cipolla on 8/24/21.
//  Copied and modified from: https://betterprogramming.pub/want-more-from-colorpicker-in-ios-14-create-1500-swiftui-pickers-of-your-own-7533514bf824

import SwiftUI

protocol ColorExtendable {
    
    // the color indigo is needed for the hue gradient
    static var indigo: Color {get}
        
    // the color violet is needed for the hue gradient
    static var violet: Color {get}
    
    // the color cyan is needed for the hue gradient
    static var cyan: Color {get}

    // the color magenta is needed for the hue gradient
    static var magenta: Color {get}

    // get a blend of two RGB colors by adding compnents
    static func blend(color1: VM_Color.RGBAValues, color2: VM_Color.RGBAValues, alpha: Double) -> VM_Color.RGBAValues
    
    // get a blend of two HSB colors by adding compnents
    static func blend(color1: VM_Color.HSBAValues, color2: VM_Color.HSBAValues, alpha: Double) -> VM_Color.HSBAValues
    
    // get a blend of two CMYK colors by adding compnents
    static func blend(color1: VM_Color.CMYKAValues, color2: VM_Color.CMYKAValues, alpha: Double) -> VM_Color.CMYKAValues
    
    // Ways to create Color instances from HSBA tuples:
    
    // values in greyscale: Returns a tuple containing white and alpha as Doubles
    static func fromValues(_ valuesInGreyscale: VM_Color.GreyscaleValues) -> Color
    
    // valuesInHSBA: A tuple containing hue, saturation and brightness as Doubles
    // alpha: The optional alpha component (set to 1 if not passed)
    // Returns: A colour made from the tuple's parameters
    static func fromValues(_ valuesInHSBA: VM_Color.HSBAValues) -> Color
    
    // Ways to create Color instances from HSBA tuples
    
    // values in CMYKA: A tuple containing cyan, magenta, yellow, black and alpha as Doubles
    // Returns a A colour made from the tuple's parameters
    static func fromValues(_ valuesInCMYKA: VM_Color.CMYKAValues) -> Color
    
    // A way to create Color instances from RGBA tuples
    // - Parameters:
    //   - valuesInRGBA: A tuple containing red, green and blue as Doubles
    //   - alpha: The optional alpha component (set to 1 if not passed)
    // - Returns: A color made from the tuple's parameters
    static func fromValues(_ valuesInRGBA: VM_Color.RGBAValues) -> Color
    
    // Convert CMYKA values to RGBA values
    // - Parameters:
    // - valuesInCMYKA: A tuple containing cyan, magenta, yellow and black as Doubles
    // - Returns: A tuple containing red, green and blue as Doubles
    static func convertToRGBA(_ valuesInCMYKA: VM_Color.CMYKAValues) -> VM_Color.RGBAValues
    
    // Convert RGBA values to CMYKA values
    // - Parameters:
    //   - valuesInRGBA: A tuple containing red, green and blue as Doubles
    // - Returns: A tuple containing cyan, magenta, yellow and black as Doubles
    static func convertToCMYKA(_ valuesInRGBA: VM_Color.RGBAValues) -> VM_Color.CMYKAValues
}

extension Color: ColorExtendable {
    
    static let indigo = Color(red: 0.29, green: 0, blue: 0.5)
    static let violet = Color(red: 0.93, green: 0.5, blue: 0.93)
    #if canImport(UIKit)
    static let cyan = Color(UIColor.cyan)
    static let magenta = Color(UIColor.magenta)
    #else
    static let cyan = Color(NSColor.cyan)
    static let magenta = Color(NSColor.magenta)
    #endif
    
    static func blend(color1: VM_Color.RGBAValues, color2: VM_Color.RGBAValues, alpha: Double) -> VM_Color.RGBAValues {
        let red = (color1.red + color2.red).clampFromZero(to: 1)
        let green = (color1.green + color2.green).clampFromZero(to: 1)
        let blue = (color1.blue + color2.blue).clampFromZero(to: 1)
        return (red: red, green: green, blue: blue, alpha: alpha)
    }
    
    static func blend(color1: VM_Color.HSBAValues, color2: VM_Color.HSBAValues, alpha: Double) -> VM_Color.HSBAValues {
        let hue = (color1.hue + color2.hue).clampFromZero(to: 1)
        let saturation = (color1.saturation + color2.saturation).clampFromZero(to: 1)
        let brightness = (color1.brightness + color2.brightness).clampFromZero(to: 1)
        return (hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
    }
    
    static func blend(color1: VM_Color.CMYKAValues, color2: VM_Color.CMYKAValues, alpha: Double) -> VM_Color.CMYKAValues {
        let cyan = (color1.cyan + color2.cyan).clampFromZero(to: 1)
        let magenta = (color1.magenta + color2.magenta).clampFromZero(to: 1)
        let yellow = (color1.yellow + color2.yellow).clampFromZero(to: 1)
        let black = (color1.black + color2.black).clampFromZero(to: 1)
        return (cyan: cyan, magenta: magenta, yellow: yellow, black: black, alpha: alpha)
    }
    
    static func fromValues(_ valuesInGreyscale: VM_Color.GreyscaleValues) -> Color {
        return Color(white: valuesInGreyscale.white, opacity: valuesInGreyscale.alpha)
    }
    
    static func fromValues(_ valuesInHSBA: VM_Color.HSBAValues) -> Color {
        return Color(hue: valuesInHSBA.hue, saturation: valuesInHSBA.saturation, brightness: valuesInHSBA.brightness, opacity: valuesInHSBA.alpha)
    }
    
    static func fromValues(_ valuesInCMYKA: VM_Color.CMYKAValues) -> Color {
        return fromValues(convertToRGBA(valuesInCMYKA))
    }
    
    static func fromValues(_ valuesInRGBA: VM_Color.RGBAValues) -> Color {
        return Color(red: valuesInRGBA.red, green: valuesInRGBA.green, blue: valuesInRGBA.blue)
    }
    
    static func convertToRGBA(_ valuesInCMYKA: VM_Color.CMYKAValues) -> VM_Color.RGBAValues {
        let red = (1 - valuesInCMYKA.cyan) * (1 - valuesInCMYKA.black)
        let green = 1 - valuesInCMYKA.magenta * (1 - valuesInCMYKA.black)
        let blue = (1 - valuesInCMYKA.yellow) * (1 - valuesInCMYKA.black)
        return (red: red, green: green, blue: blue, alpha: valuesInCMYKA.alpha)
    }
    
    static func convertToCMYKA(_ valuesInRGBA: VM_Color.RGBAValues) -> VM_Color.CMYKAValues {
        guard let max = [valuesInRGBA.red, valuesInRGBA.green, valuesInRGBA.blue].max() else {
           fatalError("Could not fine maximum value")
        }
        
        let black = 1 - max
        let cyan = (1 - valuesInRGBA.red - black) / (1- black)
        let magenta = (1 - valuesInRGBA.green - black) / (1 - black)
        let yellow = (1 - valuesInRGBA.blue - black) / (1 - black)
        
        return (cyan: cyan, magenta: magenta, yellow: yellow, black: black, alpha: valuesInRGBA.alpha)
    }  
}


