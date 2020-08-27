//
//  TestServices.swift
//  EmptyArchitectureProject
//
//  Created by Rami Ounifi on 6/22/20.
//  Copyright © 2020 Yellow. All rights reserved.
//

import Foundation
import RxSwift
class TestServices : TestProtocol {
      let url = "https://jsonplaceholder.typicode.com/posts"
    func getUser() -> Observable<[UserResponseElement]> {

            let request =  NetworkRequests.shared.setUrlRequest(urlString: url, method: .get, params: [:], header:  [:])
               
               return Network.execute(request: request)
        }
    }
    
  
    
    

