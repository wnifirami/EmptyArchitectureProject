//
//  FontUtils.swift
//  EmptyArchitectureProject
//
//  Created by Rami Ounifi on 6/19/20.
//  Copyright © 2020 Yellow. All rights reserved.
//

import Foundation
import  UIKit
enum FontUtils {
    
    case headline
    case title
    case body
    case bodySmall
    case subTitle
    case caption
    case note
    case internNavBarTitle
    case labelError
    case tabBarTitle
    case lightNote
    case selectable
    case titleSection
    case calendarDate
    case regular16
    case zoom
    case timer
    // Text style
    var style: (fontName: String, fontSize: CGFloat) {
        switch self {
            
        case .headline:
            let size: CGFloat = 14.0
            return (fontName: FontConstants.palanquinBold, fontSize: size)
            
        case .calendarDate:
            let size: CGFloat = 30.0
            return (fontName: FontConstants.palanquinBold, fontSize: size)
          case .timer:
                   let size: CGFloat = 60.0
                   return (fontName: FontConstants.palanquinBold, fontSize: size)
            
            
            case .zoom:
            let size: CGFloat = 18
            return (fontName: FontConstants.palanquinBold, fontSize: size)
        case .title:
            let size: CGFloat = 16
            return (fontName: FontConstants.palanquinBold, fontSize: size)
            
        case .subTitle:
            let size: CGFloat = 15
            return (fontName: FontConstants.palanquinLight, fontSize: size)
            
        case .body:
            let size: CGFloat = 14.0
            return (fontName: FontConstants.palanquinRegular, fontSize: size)
        case .bodySmall:
            let size: CGFloat = 12.0
            return (fontName: FontConstants.palanquinRegular, fontSize: size)
        case .caption:
            let size: CGFloat = 12.0
            return (fontName: FontConstants.palanquinBold, fontSize: size)
            
        case .note:
            let size: CGFloat = 10.0
            return (fontName: FontConstants.palanquinRegular, fontSize: size)
            
        case .internNavBarTitle:
            let size: CGFloat = 17.0
            return (fontName: FontConstants.palanquinRegular, fontSize: size)
            
        case .labelError:
            let size: CGFloat = 13.0
            return (fontName: FontConstants.palanquinRegular, fontSize: size)
            
        case .tabBarTitle:
            let size: CGFloat = 11.0
            return (fontName: FontConstants.palanquinMedium, fontSize: size)
            
        case .lightNote:
            let size: CGFloat = 12.0
            return (fontName: FontConstants.palanquinLight, fontSize: size)
            
        case .selectable:
            let size: CGFloat = 15
            return (fontName: FontConstants.palanquinRegular, fontSize: size)
            
        case .titleSection:
            let size: CGFloat = 15.0
            return (fontName: FontConstants.palanquinMedium, fontSize: size)
        case .regular16:
            let size: CGFloat = 16.0
            return (fontName: FontConstants.palanquinRegular, fontSize: size)
        }
        
        
    }
    
    var font: UIFont {
        let defaultFont = UIFont.systemFont(ofSize: 14)
        return UIFont(name: self.style.fontName, size: self.style.fontSize) ?? defaultFont
    }
}
