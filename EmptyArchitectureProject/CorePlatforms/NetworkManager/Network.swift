//
//  Network.swift
//  EmptyArchitectureProject
//
//  Created by Rami Ounifi on 6/19/20.
//  Copyright © 2020 Yellow. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

struct Network {
    
    static func execute<T: Decodable>(request: URLRequestConvertible) -> Observable<T> {
        return Observable.create { observer -> Disposable in
            
            let request = Alamofire.SessionManager.default.request(request)
                .validate()
                .responseData { alamofireResponse in
                    if let statusCode = alamofireResponse.response?.statusCode {
                        if statusCode == 401 {
                            if var topController = UIApplication.shared.keyWindow?.rootViewController {
                                while let presentedViewController = topController.presentedViewController {
                                    topController = presentedViewController
                                }
                                // here we show sessionExpired popUp
                                
                            }
                        }
                    }
                    
                    debugPrint(NSString(data: alamofireResponse.data ?? Data(), encoding: String.Encoding.utf8.rawValue), "responseJson")
                    
                    switch alamofireResponse.result {
                        
                    case .success(let data):
                        let jsonDecoder = JSONDecoder()
                        
                        do {
                            let response = try jsonDecoder.decode(T.self, from: data)
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
            return Disposables.create(with: request.cancel)
        }
    }
    
    
    static func customNetworkResponse(url: String, method: HTTPMethod,  params: [String: Any],header: HTTPHeaders) -> Observable<Data> {
        
        
        return Observable<Data>.create { observer in
            
            Alamofire.request(URL(string: url)!, method: method, parameters: params, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
                switch response.result {
                    
                case .success(let data):
                    observer.onNext(data as? Data ?? Data())
                default:
                    observer.onNext(Data())
                    
                }
            }
            return Disposables.create()
            
        }
    }
    
    
    static func decodeObject<T:Codable>(data: Data) -> T? {
        do {
            let response = try JSONDecoder().decode(T.self, from: data)
            return response
        } catch (let error) {
            print("Error DebugPrint: \(error.localizedDescription)")
            return nil }
        
    }
}

// MARK: - Debug request and result

extension Alamofire.DataRequest {
    
    func responseDebugPrint() -> Self {
        return responseJSON() {
            response in
            
            if let  JSON = response.result.value,
                
                let JSONData = try? JSONSerialization.data(withJSONObject: JSON, options: .prettyPrinted),
                
                let prettyString = NSString(data: JSONData, encoding: String.Encoding.utf8.rawValue) {
                
                print(prettyString)
                
            } else if let error = response.result.error {
                
                print("Error Debug Print: \(error.localizedDescription)")
                
            }
            
        }
        
    }
    
}


