//
//  LanguageManager.swift
//  EmptyArchitectureProject
//
//  Created by Rami Ounifi on 6/19/20.
//  Copyright © 2020 Yellow. All rights reserved.
//

import Foundation
class LanguageManager {
    
    static let sharedInstance = LanguageManager()
    fileprivate init() {}
    
    let defaultAppLanguage = DefaultUtils.sharedInstance.userLanguage ?? "fr"
    
    var baseBundle: Bundle?
    
    var language: String? {
        didSet {
            //when the language is changed from inside the application
            if let settedLang = language {
                debugPrint("the new setted language is \(settedLang)")
            }
        }
    }
    
    func getLocalizedString(key: String) -> String {
        
        var localizedWord: String = key
        
            
            var basePth = Bundle.main.path(forResource: defaultAppLanguage, ofType: "lproj")
            
            if let lang = language {
                basePth = Bundle.main.path(forResource: lang, ofType: "lproj")
            }
            
            if let basePth = basePth {
                baseBundle = Bundle(path: basePth)
            }
        
        if let baseBndle = baseBundle {
            localizedWord = NSLocalizedString(key, tableName: nil, bundle: baseBndle, value: "", comment: "")
        }
        
        return localizedWord
    }
    
}
