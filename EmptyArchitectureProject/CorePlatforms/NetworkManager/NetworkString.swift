//
//  NetworkString.swift
//  EmptyArchitectureProject
//
//  Created by Rami Ounifi on 6/19/20.
//  Copyright © 2020 Yellow. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift



struct NetworkString {
    
    static func execute<T: Decodable>(request: URLRequestConvertible) -> Observable<T> {
        return Observable.create { observer -> Disposable in
           
            let request = Alamofire.SessionManager.default.request(request)
                .validate()
                .responseString { alamofireResponse in
              
                    
                    debugPrint(NSString(data: alamofireResponse.data ?? Data(), encoding: String.Encoding.utf8.rawValue), "responseString")
                    
                    switch alamofireResponse.result {
                        
                    case .success(let data):
                        let jsonDecoder = JSONDecoder()
                        
                        do {
                         
                          //  let jsonArray = data.convertToDictionary()
                                             // print(jsonArray) // use the json here
                            let response = try jsonDecoder.decode(T.self, from: data.data(using: .utf8)!)
                                                        observer.onNext(response)
                                                        observer.onCompleted()
                                          
                        
                        } catch (let error) {
                            print("Error DebugPrint: \(error.localizedDescription)")
                            observer.onError(APIError.parsingFailed)
                        }
                    case .failure(let error):
                        switch error {
                        case let err as NSError where err.code == NSURLErrorNotConnectedToInternet:
                            observer.onError(APIError.notConnectedToInternet)
                            
                        case let err as NSError where err.code == NSURLErrorTimedOut:
                            observer.onError(APIError.timedOut)
                        default:
                            observer.onError(error)
                        }
                    }
            }.responseDebugPrint()
             //print(request.debugDescription)
            return Disposables.create(with: request.cancel)
        }
    }
}




