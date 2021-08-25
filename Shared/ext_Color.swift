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

    // get a blend of two colors by adding compnents
    //static func blend(color1: VM_Color.)
}
