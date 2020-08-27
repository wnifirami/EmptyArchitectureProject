//
//  DefaultUtils.swift
//  EmptyArchitectureProject
//
//  Created by Rami Ounifi on 6/19/20.
//  Copyright © 2020 Yellow. All rights reserved.
//

import Foundation
import Alamofire
class DefaultUtils: NSObject {

    //Singleton Pattern
    static let sharedInstance = DefaultUtils()
    fileprivate override init() {}
    
    let userDefaults = UserDefaults.standard
    
    var userLanguage: String? {
        get {
            return userDefaults.string(forKey: UserDefaultKeys.userLanguage)
        }
        
        set(newValue) {
            userDefaults.set(newValue, forKey: UserDefaultKeys.userLanguage)
        }
    }
    
    var userToken: String? {
         get {
             return userDefaults.string(forKey: UserDefaultKeys.userToken)
         }
         
         set(newValue) {
             userDefaults.set(newValue, forKey: UserDefaultKeys.userToken)
         }
     }
    
    var onBoardingSeen: Bool? {
          get {
              return userDefaults.bool(forKey: UserDefaultKeys.onBoarding)
          }
          
          set(newValue) {
              userDefaults.set(newValue, forKey: UserDefaultKeys.onBoarding)
          }
      }
    
    var userCookie: String? {
          get {
              return userDefaults.string(forKey: UserDefaultKeys.userCookie)
          }
          
          set(newValue) {
              userDefaults.set(newValue, forKey: UserDefaultKeys.userCookie)
          }
      }
    
    var userHeader: HTTPHeaders? {
             get {
                guard let headers = userDefaults.dictionary(forKey: UserDefaultKeys.UserHeaders) as? HTTPHeaders else {
                    debugPrint("we can't get the headers")
                    return HTTPHeaders()
                }
                return  headers
             }
             
             set(newValue) {
                 userDefaults.set(newValue, forKey: UserDefaultKeys.UserHeaders)
             }
         }
    
    
    var currentUserFullName: String? {
               get {
                  guard let fullName = userDefaults.string(forKey: UserDefaultKeys.current) as? String else {
                      debugPrint("we can't get the headers")
                      return ""
                  }
                  return  fullName
               }
               
               set(newValue) {
                   userDefaults.set(newValue, forKey: UserDefaultKeys.current)
               }
           }
    
    var currentUserId: Int? {
                get {
                   guard let id = userDefaults.integer(forKey: UserDefaultKeys.currentId) as? Int else {
                       debugPrint("we can't get the headers")
                       return 0
                   }
                   return  id
                }
                set(newValue) {
                    userDefaults.set(newValue, forKey: UserDefaultKeys.currentId)
                }
            }
    }

