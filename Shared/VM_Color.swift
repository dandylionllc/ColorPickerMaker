//
//  VM_Color.swift
//  Color ViewModel
//
//  Created by Frank Cipolla on 8/22/21.
//
// copied from https://betterprogramming.pub/want-more-from-colorpicker-in-ios-14-create-1500-swiftui-pickers-of-your-own-7533514bf824

import SwiftUI

// Stores one color and its accompanying parameters

class VM_Color: ObservableObject {
    
    // a tuple of RGB parameters and their values
    typealias RGBValues = (red: Double, green: Double, blue: Double, alpha: Double)
    
    // a tuple of HSB parameters and their values
    typealias HSBAValues = (hue: Double, saturation: Double, brightness: Double, alpha: Double)
    
    // a tuple of CMYK parameters and their values
    typealias CMYKAValues = (cyan: Double, magenta: Double, Yellow: Double, black: Double, alpha: Double)
    
    // a tuple of greyscale parameters and their values
    typealias GreyscaleValues = (white: Double, alpha: Double)
    
    // Which colorspace is being adjusted
    var colorSpace: ColorSpace
    
    // The clor being picked
    @Published var color = Color.white
    
    // The color parameters
    @Published var alpha = Double(1) {
        didSet {
            // ColorSpace independent
            setColor()
        }
    }
    
    @Published var valuesInRGBA: RGBValues = (1.0,0.0,0.0,1.0) {
        didSet {
            setColor(colorSpace: .RGBA)
        }
    }
    
    @Published var valuesInHSBA : HSBAValues = (1.0, 1.0, 1.0, 1.0) {
        didSet {
            setColor(colorSpace: .HSBA)
        }
    }
    
    @Published var valuesInCMYKA : CMYKAValues = (0.5, 0.5, 0.5, 0.0, 1.0) {
        didSet {
            setColor(colorSpace: .CMYKA)
        }
    }
    
    @Published var valuesInGreyscale: GreyscaleValues = (1.0,1.0) {
        didSet {
            setColor(colorSpace: .greyscale)
        }
    }
    
    
    init(colorSpace: ColorSpace) {
        self.colorSpace = colorSpace
        setColor()
    }
    
    // Sets the color according to which color space is adjusted
    func setColor() {
        switch colorSpace {
        case .HSBA:
            color = Color.fromValues(valuesInHSBA)
        case .RGBA:
            color = Color.fromValues(valuesInRGBA)
        case .CMYKA:
            color = Color.fromValues(valuesInCMYKA)
        case .greyscale:
            color = Color.fromValues(valuesInGreyscale)
        }
    }
    
    // allows colorSpcae to be set before settinng the color
    func setColor(colorSpace: ColorSpace) {
        self.colorSpace = colorSpace
        setColor()
    }
    
    // Colors are created with only one of these sets of parameters at a time
    enum ColorSpace: CaseIterable {
        case HSBA, RGBA, CMYKA, greyscale
        
        
    }
}


