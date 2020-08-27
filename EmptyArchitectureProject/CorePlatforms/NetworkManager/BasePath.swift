//
//  BasePath.swift
//  EmptyArchitectureProject
//
//  Created by Rami Ounifi on 6/19/20.
//  Copyright © 2020 Yellow. All rights reserved.
//

import Foundation

 enum BasePath: String {
    case baseUrl
     
      /// variable path qui retourne l'url a utiliser
      var basePath: String {
          switch self {
          case .baseUrl:  return "here we set the base path"
              
          }
      }

}

/// concatination a l'url de base
extension BasePath: CustomStringConvertible {
    var description: String { return basePath  }
}
