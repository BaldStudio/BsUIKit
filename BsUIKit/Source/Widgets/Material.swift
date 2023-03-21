//
//  Material.swift
//  BsUIKit
//
//  Created by crzorz on 2022/6/13.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import UIKit
import BsFoundation

public struct Material {
    
     public struct Red {
        
        public static let P50  = #colorLiteral(red: 1, green: 0.9215686275, blue: 0.9333333333, alpha: 1) // UIColor(0xFFEBEE)
        public static let P100 = #colorLiteral(red: 1, green: 0.8039215803, blue: 0.8235294819, alpha: 1) // UIColor(0xFFCDD2)
        public static let P200 = #colorLiteral(red: 0.937254902, green: 0.6039215686, blue: 0.6039215686, alpha: 1) // UIColor(0xEF9A9A)
        public static let P300 = #colorLiteral(red: 0.8980392157, green: 0.4509803922, blue: 0.4509803922, alpha: 1) // UIColor(0xE57373)
        public static let P400 = #colorLiteral(red: 0.937254902, green: 0.3254901961, blue: 0.3137254902, alpha: 1) // UIColor(0xEF5350)
        public static let P500 = #colorLiteral(red: 0.9568627451, green: 0.262745098, blue: 0.2117647059, alpha: 1) // UIColor(0xF44336)
        public static let P600 = #colorLiteral(red: 0.8980392157, green: 0.2235294118, blue: 0.2078431373, alpha: 1) // UIColor(0xE53935)
        public static let P700 = #colorLiteral(red: 0.8274509804, green: 0.1843137255, blue: 0.1843137255, alpha: 1) // UIColor(0xD32F2F)
        public static let P800 = #colorLiteral(red: 0.7764705882, green: 0.1568627451, blue: 0.1568627451, alpha: 1) // UIColor(0xC62828)
        public static let P900 = #colorLiteral(red: 0.7176470588, green: 0.1098039216, blue: 0.1098039216, alpha: 1) // UIColor(0xB71C1C)
        public static let A100 = #colorLiteral(red: 1, green: 0.5411764706, blue: 0.5019607843, alpha: 1) // UIColor(0xFF8A80)
        public static let A200 = #colorLiteral(red: 1, green: 0.3215686275, blue: 0.3215686275, alpha: 1) // UIColor(0xFF5252)
        public static let A400 = #colorLiteral(red: 1, green: 0.09019607843, blue: 0.2666666667, alpha: 1) // UIColor(0xFF1744)
        public static let A700 = #colorLiteral(red: 0.8352941176, green: 0, blue: 0, alpha: 1) // UIColor(0xD50000)
        
    }
     
     public struct Pink {
         public static let P50  = #colorLiteral(red: 0.9882352941, green: 0.8941176471, blue: 0.9254901961, alpha: 1) // UIColor(0xFCE4EC)
         public static let P100 = #colorLiteral(red: 0.9725490196, green: 0.7333333333, blue: 0.8156862745, alpha: 1) // UIColor(0xF8BBD0)
         public static let P200 = #colorLiteral(red: 0.9568627451, green: 0.5607843137, blue: 0.6941176471, alpha: 1) // UIColor(0xF48FB1)
         public static let P300 = #colorLiteral(red: 0.9411764706, green: 0.3843137255, blue: 0.5725490196, alpha: 1) // UIColor(0xF06292)
         public static let P400 = #colorLiteral(red: 0.9254901961, green: 0.2509803922, blue: 0.4784313725, alpha: 1) // UIColor(0xEC407A)
         public static let P500 = #colorLiteral(red: 0.9137254902, green: 0.1176470588, blue: 0.3882352941, alpha: 1) // UIColor(0xE91E63)
         public static let P600 = #colorLiteral(red: 0.8470588235, green: 0.1058823529, blue: 0.3764705882, alpha: 1) // UIColor(0xD81B60)
         public static let P700 = #colorLiteral(red: 0.7607843137, green: 0.09411764706, blue: 0.3568627451, alpha: 1) // UIColor(0xC2185B)
         public static let P800 = #colorLiteral(red: 0.6784313725, green: 0.07843137255, blue: 0.3411764706, alpha: 1) // UIColor(0xAD1457)
         public static let P900 = #colorLiteral(red: 0.5333333333, green: 0.05490196078, blue: 0.3098039216, alpha: 1) // UIColor(0x880E4F)
         public static let A100 = #colorLiteral(red: 1, green: 0.5019607843, blue: 0.6705882353, alpha: 1) // UIColor(0xFF80AB)
         public static let A200 = #colorLiteral(red: 1, green: 0.2509803922, blue: 0.5058823529, alpha: 1) // UIColor(0xFF4081)
         public static let A400 = #colorLiteral(red: 0.9607843137, green: 0, blue: 0.3411764706, alpha: 1) // UIColor(0xF50057)
         public static let A700 = #colorLiteral(red: 0.7725490196, green: 0.06666666667, blue: 0.3843137255, alpha: 1) // UIColor(0xC51162)
     }

     public struct Purple {
         public static let P50  = #colorLiteral(red: 0.9529411765, green: 0.8980392157, blue: 0.9607843137, alpha: 1) // UIColor(0xF3E5F5)
         public static let P100 = UIColor(0xE1BEE7)
         public static let P200 = UIColor(0xCE93D8)
         public static let P300 = UIColor(0xBA68C8)
         public static let P400 = UIColor(0xAB47BC)
         public static let P500 = UIColor(0x9C27B0)
         public static let P600 = UIColor(0x8E24AA)
         public static let P700 = UIColor(0x7B1FA2)
         public static let P800 = UIColor(0x6A1B9A)
         public static let P900 = UIColor(0x4A148C)
         public static let A100 = UIColor(0xEA80FC)
         public static let A200 = UIColor(0xE040FB)
         public static let A400 = UIColor(0xD500F9)
         public static let A700 = UIColor(0xAA00FF)
     }

     public struct DeepPurple {
         public static let P50  = #colorLiteral(red: 0.9294117647, green: 0.9058823529, blue: 0.9647058824, alpha: 1) // UIColor(0xEDE7F6)
         public static let P100 = UIColor(0xD1C4E9)
         public static let P200 = UIColor(0xB39DDB)
         public static let P300 = UIColor(0x9575CD)
         public static let P400 = UIColor(0x7E57C2)
         public static let P500 = UIColor(0x673AB7)
         public static let P600 = UIColor(0x5E35B1)
         public static let P700 = UIColor(0x512DA8)
         public static let P800 = UIColor(0x4527A0)
         public static let P900 = UIColor(0x311B92)
         public static let A100 = UIColor(0xB388FF)
         public static let A200 = UIColor(0x7C4DFF)
         public static let A400 = UIColor(0x651FFF)
         public static let A700 = UIColor(0x6200EA)
     }

     public struct Indigo {
         public static let P50  = #colorLiteral(red: 0.9098039216, green: 0.9176470588, blue: 0.9647058824, alpha: 1) // UIColor(0xE8EAF6)
         public static let P100 = UIColor(0xC5CAE9)
         public static let P200 = UIColor(0x9FA8DA)
         public static let P300 = UIColor(0x7986CB)
         public static let P400 = UIColor(0x5C6BC0)
         public static let P500 = UIColor(0x3F51B5)
         public static let P600 = UIColor(0x3949AB)
         public static let P700 = UIColor(0x303F9F)
         public static let P800 = UIColor(0x283593)
         public static let P900 = UIColor(0x1A237E)
         public static let A100 = UIColor(0x8C9EFF)
         public static let A200 = UIColor(0x536DFE)
         public static let A400 = UIColor(0x3D5AFE)
         public static let A700 = UIColor(0x304FFE)
     }

     public struct Blue {
         public static let P50  = #colorLiteral(red: 0.8901960784, green: 0.9490196078, blue: 0.9921568627, alpha: 1) // UIColor(0xE3F2FD)
         public static let P100 = UIColor(0xBBDEFB)
         public static let P200 = UIColor(0x90CAF9)
         public static let P300 = UIColor(0x64B5F6)
         public static let P400 = UIColor(0x42A5F5)
         public static let P500 = UIColor(0x2196F3)
         public static let P600 = UIColor(0x1E88E5)
         public static let P700 = UIColor(0x1976D2)
         public static let P800 = UIColor(0x1565C0)
         public static let P900 = UIColor(0x0D47A1)
         public static let A100 = UIColor(0x82B1FF)
         public static let A200 = UIColor(0x448AFF)
         public static let A400 = UIColor(0x2979FF)
         public static let A700 = UIColor(0x2962FF)
     }

     public struct LightBlue {
         public static let P50  = #colorLiteral(red: 0.9038364291, green: 0.9685724378, blue: 0.9970864654, alpha: 1) // UIColor(0xE1F5FE)
         public static let P100 = #colorLiteral(red: 0.7019607843, green: 0.8980392157, blue: 0.9882352941, alpha: 1) // UIColor(0xB3E5FC)
         public static let P200 = #colorLiteral(red: 0.5058823529, green: 0.831372549, blue: 0.9803921569, alpha: 1) // UIColor(0x81D4FA)
         public static let P300 = #colorLiteral(red: 0.3098039216, green: 0.7647058824, blue: 0.968627451, alpha: 1) // UIColor(0x4FC3F7)
         public static let P400 = #colorLiteral(red: 0.1607843137, green: 0.7137254902, blue: 0.9647058824, alpha: 1) // UIColor(0x29B6F6)
         public static let P500 = #colorLiteral(red: 0.01176470588, green: 0.662745098, blue: 0.9568627451, alpha: 1) // UIColor(0x03A9F4)
         public static let P600 = #colorLiteral(red: 0.01176470588, green: 0.6078431373, blue: 0.8980392157, alpha: 1) // UIColor(0x039BE5)
         public static let P700 = #colorLiteral(red: 0.007843137255, green: 0.5333333333, blue: 0.8196078431, alpha: 1) // UIColor(0x0288D1)
         public static let P800 = #colorLiteral(red: 0.007843137255, green: 0.4666666667, blue: 0.7411764706, alpha: 1) // UIColor(0x0277BD)
         public static let P900 = #colorLiteral(red: 0.003921568627, green: 0.3411764706, blue: 0.6078431373, alpha: 1) // UIColor(0x01579B)
         public static let A100 = #colorLiteral(red: 0.5019607843, green: 0.8470588235, blue: 1, alpha: 1) // UIColor(0x80D8FF)
         public static let A200 = #colorLiteral(red: 0.2509803922, green: 0.768627451, blue: 1, alpha: 1) // UIColor(0x40C4FF)
         public static let A400 = #colorLiteral(red: 0, green: 0.6901960784, blue: 1, alpha: 1) // UIColor(0x00B0FF)
         public static let A700 = #colorLiteral(red: 0, green: 0.568627451, blue: 0.9176470588, alpha: 1) // UIColor(0x0091EA)
     }

     public struct Cyan {
         public static let P50  = #colorLiteral(red: 0.8784313725, green: 0.968627451, blue: 0.9803921569, alpha: 1) // UIColor(0xE0F7FA)
         public static let P100 = UIColor(0xB2EBF2)
         public static let P200 = UIColor(0x80DEEA)
         public static let P300 = UIColor(0x4DD0E1)
         public static let P400 = UIColor(0x26C6DA)
         public static let P500 = UIColor(0x00BCD4)
         public static let P600 = UIColor(0x00ACC1)
         public static let P700 = UIColor(0x0097A7)
         public static let P800 = UIColor(0x00838F)
         public static let P900 = UIColor(0x006064)
         public static let A100 = UIColor(0x84FFFF)
         public static let A200 = UIColor(0x18FFFF)
         public static let A400 = UIColor(0x00E5FF)
         public static let A700 = UIColor(0x00B8D4)
     }

     public struct Teal {
         public static let P50  = #colorLiteral(red: 0.8784313725, green: 0.9490196078, blue: 0.9450980392, alpha: 1) // UIColor(0xE0F2F1)
         public static let P100 = UIColor(0xB2DFDB)
         public static let P200 = UIColor(0x80CBC4)
         public static let P300 = UIColor(0x4DB6AC)
         public static let P400 = UIColor(0x26A69A)
         public static let P500 = UIColor(0x009688)
         public static let P600 = UIColor(0x00897B)
         public static let P700 = UIColor(0x00796B)
         public static let P800 = UIColor(0x00695C)
         public static let P900 = UIColor(0x004D40)
         public static let A100 = UIColor(0xA7FFEB)
         public static let A200 = UIColor(0x64FFDA)
         public static let A400 = UIColor(0x1DE9B6)
         public static let A700 = UIColor(0x00BFA5)
     }

     public struct Green {
         public static let P50  = #colorLiteral(red: 0.9098039216, green: 0.9607843137, blue: 0.9137254902, alpha: 1) // UIColor(0xE8F5E9)
         public static let P100 = UIColor(0xC8E6C9)
         public static let P200 = UIColor(0xA5D6A7)
         public static let P300 = UIColor(0x81C784)
         public static let P400 = UIColor(0x66BB6A)
         public static let P500 = UIColor(0x4CAF50)
         public static let P600 = UIColor(0x43A047)
         public static let P700 = UIColor(0x388E3C)
         public static let P800 = UIColor(0x2E7D32)
         public static let P900 = UIColor(0x1B5E20)
         public static let A100 = UIColor(0xB9F6CA)
         public static let A200 = UIColor(0x69F0AE)
         public static let A400 = UIColor(0x00E676)
         public static let A700 = UIColor(0x00C853)
     }

     public struct LightGreen {
         public static let P50  = #colorLiteral(red: 0.9450980392, green: 0.9725490196, blue: 0.9137254902, alpha: 1) // UIColor(0xF1F8E9)
         public static let P100 = UIColor(0xDCEDC8)
         public static let P200 = UIColor(0xC5E1A5)
         public static let P300 = UIColor(0xAED581)
         public static let P400 = UIColor(0x9CCC65)
         public static let P500 = UIColor(0x8BC34A)
         public static let P600 = UIColor(0x7CB342)
         public static let P700 = UIColor(0x689F38)
         public static let P800 = UIColor(0x558B2F)
         public static let P900 = UIColor(0x33691E)
         public static let A100 = UIColor(0xCCFF90)
         public static let A200 = UIColor(0xB2FF59)
         public static let A400 = UIColor(0x76FF03)
         public static let A700 = UIColor(0x64DD17)
     }

     public struct Lime {
         public static let P50  = #colorLiteral(red: 0.9764705882, green: 0.9843137255, blue: 0.9058823529, alpha: 1) // UIColor(0xF9FBE7)
         public static let P100 = UIColor(0xF0F4C3)
         public static let P200 = UIColor(0xE6EE9C)
         public static let P300 = UIColor(0xDCE775)
         public static let P400 = UIColor(0xD4E157)
         public static let P500 = UIColor(0xCDDC39)
         public static let P600 = UIColor(0xC0CA33)
         public static let P700 = UIColor(0xAFB42B)
         public static let P800 = UIColor(0x9E9D24)
         public static let P900 = UIColor(0x827717)
         public static let A100 = UIColor(0xF4FF81)
         public static let A200 = UIColor(0xEEFF41)
         public static let A400 = UIColor(0xC6FF00)
         public static let A700 = UIColor(0xAEEA00)
     }

     public struct Yellow {
         public static let P50  = #colorLiteral(red: 1, green: 0.9921568627, blue: 0.9058823529, alpha: 1) // UIColor(0xFFFDE7)
         public static let P100 = UIColor(0xFFF9C4)
         public static let P200 = UIColor(0xFFF59D)
         public static let P300 = UIColor(0xFFF176)
         public static let P400 = UIColor(0xFFEE58)
         public static let P500 = UIColor(0xFFEB3B)
         public static let P600 = UIColor(0xFDD835)
         public static let P700 = UIColor(0xFBC02D)
         public static let P800 = UIColor(0xF9A825)
         public static let P900 = UIColor(0xF57F17)
         public static let A100 = UIColor(0xFFFF8D)
         public static let A200 = UIColor(0xFFFF00)
         public static let A400 = UIColor(0xFFEA00)
         public static let A700 = UIColor(0xFFD600)
     }

     public struct Amber {
         public static let P50  = #colorLiteral(red: 1, green: 0.9725490196, blue: 0.8823529412, alpha: 1) // UIColor(0xFFF8E1)
         public static let P100 = UIColor(0xFFECB3)
         public static let P200 = UIColor(0xFFE082)
         public static let P300 = UIColor(0xFFD54F)
         public static let P400 = UIColor(0xFFCA28)
         public static let P500 = UIColor(0xFFC107)
         public static let P600 = UIColor(0xFFB300)
         public static let P700 = UIColor(0xFFA000)
         public static let P800 = UIColor(0xFF8F00)
         public static let P900 = UIColor(0xFF6F00)
         public static let A100 = UIColor(0xFFE57F)
         public static let A200 = UIColor(0xFFD740)
         public static let A400 = UIColor(0xFFC400)
         public static let A700 = UIColor(0xFFAB00)
     }

     public struct Orange {
         public static let P50  = #colorLiteral(red: 1, green: 0.9529411765, blue: 0.8784313725, alpha: 1) // UIColor(0xFFF3E0)
         public static let P100 = UIColor(0xFFE0B2)
         public static let P200 = UIColor(0xFFCC80)
         public static let P300 = UIColor(0xFFB74D)
         public static let P400 = UIColor(0xFFA726)
         public static let P500 = UIColor(0xFF9800)
         public static let P600 = UIColor(0xFB8C00)
         public static let P700 = UIColor(0xF57C00)
         public static let P800 = UIColor(0xEF6C00)
         public static let P900 = UIColor(0xE65100)
         public static let A100 = UIColor(0xFFD180)
         public static let A200 = UIColor(0xFFAB40)
         public static let A400 = UIColor(0xFF9100)
         public static let A700 = UIColor(0xFF6D00)
     }

     public struct DeepOrange {
         public static let P50  = #colorLiteral(red: 0.9843137255, green: 0.9137254902, blue: 0.9058823529, alpha: 1) // UIColor(0xFBE9E7)
         public static let P100 = UIColor(0xFFCCBC)
         public static let P200 = UIColor(0xFFAB91)
         public static let P300 = UIColor(0xFF8A65)
         public static let P400 = UIColor(0xFF7043)
         public static let P500 = UIColor(0xFF5722)
         public static let P600 = UIColor(0xF4511E)
         public static let P700 = UIColor(0xE64A19)
         public static let P800 = UIColor(0xD84315)
         public static let P900 = UIColor(0xBF360C)
         public static let A100 = UIColor(0xFF9E80)
         public static let A200 = UIColor(0xFF6E40)
         public static let A400 = UIColor(0xFF3D00)
         public static let A700 = UIColor(0xDD2C00)
     }

     public struct Brown {
         public static let P50  = #colorLiteral(red: 0.937254902, green: 0.9215686275, blue: 0.9137254902, alpha: 1) // UIColor(0xEFEBE9)
         public static let P100 = UIColor(0xD7CCC8)
         public static let P200 = UIColor(0xBCAAA4)
         public static let P300 = UIColor(0xA1887F)
         public static let P400 = UIColor(0x8D6E63)
         public static let P500 = UIColor(0x795548)
         public static let P600 = UIColor(0x6D4C41)
         public static let P700 = UIColor(0x5D4037)
         public static let P800 = UIColor(0x4E342E)
         public static let P900 = UIColor(0x3E2723)
     }

     public struct Grey {
         public static let P50  = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1) // UIColor(0xFAFAFA)
         public static let P100 = UIColor(0xF5F5F5)
         public static let P200 = UIColor(0xEEEEEE)
         public static let P300 = UIColor(0xE0E0E0)
         public static let P400 = UIColor(0xBDBDBD)
         public static let P500 = UIColor(0x9E9E9E)
         public static let P600 = UIColor(0x757575)
         public static let P700 = UIColor(0x616161)
         public static let P800 = UIColor(0x424242)
         public static let P900 = UIColor(0x212121)
     }

     public struct BlueGrey {
         public static let P50  = #colorLiteral(red: 0.9254901961, green: 0.937254902, blue: 0.9450980392, alpha: 1) // UIColor(0xECEFF1)
         public static let P100 = UIColor(0xCFD8DC)
         public static let P200 = UIColor(0xB0BEC5)
         public static let P300 = UIColor(0x90A4AE)
         public static let P400 = UIColor(0x78909C)
         public static let P500 = UIColor(0x607D8B)
         public static let P600 = UIColor(0x546E7A)
         public static let P700 = UIColor(0x455A64)
         public static let P800 = UIColor(0x37474F)
         public static let P900 = UIColor(0x263238)
     }

}
