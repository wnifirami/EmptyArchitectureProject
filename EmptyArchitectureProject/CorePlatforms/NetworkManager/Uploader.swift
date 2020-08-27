//
//  Uploader.swift
//  EmptyArchitectureProject
//
//  Created by Rami Ounifi on 6/19/20.
//  Copyright © 2020 Yellow. All rights reserved.
//


import UIKit
import Alamofire

class Uploader {
    // FIXME: - dont forget to set  the bundleIdentifier
    let decoder : JSONDecoder
    public var sessionManager: Alamofire.SessionManager // most of your web service clients will call through sessionManager
    public var backgroundSessionManager: Alamofire.SessionManager // your web services you intend to keep running when the system backgrounds your app will use this
    
    static let shared = Uploader()
    
    init() {
     
        decoder = JSONDecoder()
        self.sessionManager = Alamofire.SessionManager(configuration: URLSessionConfiguration.default)
           // TODO: - here we set the bundleIdentifier
        self.backgroundSessionManager = Alamofire.SessionManager(configuration: URLSessionConfiguration.background(withIdentifier: "bundleIdentifier"))
    }
    
    
    
    
    func uploadData(data: Data, fileName: String, mimeType: String,uploadUrl: String,headers: HTTPHeaders, onProgressUpdates: @escaping ((Double)->()), onComplition: @escaping ((UploadResult, String?)->())){
        
        Uploader.shared.backgroundSessionManager.upload(multipartFormData: { (multipartFormData: MultipartFormData) in
            
            multipartFormData.append(data, withName: "file", fileName: fileName, mimeType: mimeType)
            
        }, to: uploadUrl, method: .post, headers: headers ) { (encodingResult: SessionManager.MultipartFormDataEncodingResult) in
            
            switch encodingResult {
                
            case .success(let upload, _, _):
                upload.uploadProgress(closure: { (progress) in
                    onProgressUpdates(progress.fractionCompleted)
                })
                upload.responseJSON { dataResponse in
                    
                    guard let statusCode = dataResponse.response?.statusCode else {
                        onComplition(.unknownError, nil)
                        return
                    }
                    
                    // print(dataResponse.data?.statusCode as Any)
                    switch statusCode {
                    case 200:
                        
                        if var topController = UIApplication.shared.keyWindow?.rootViewController {
                            while let presentedViewController = topController.presentedViewController {
                                topController = presentedViewController
                            }
                            DispatchQueue.main.async {
                                let alert = UIAlertController(title: "votre fichier a été téléchargé avec succès.", message: nil , preferredStyle: .alert)
                                let alertAction = UIAlertAction(title: "OK", style: .default)
                                alert.addAction(alertAction)
                                topController.present(alert, animated: true)
                            }}
                        
                        
                        
                        onComplition(.succes(dataResponse.data), "File uploaded with success")
                    case 500:
                        if var topController = UIApplication.shared.keyWindow?.rootViewController {
                            while let presentedViewController = topController.presentedViewController {
                                topController = presentedViewController
                            }
                            DispatchQueue.main.async {
                                AlertPopUp.alert.showValidationAlertWithOkComplition(title: "", msg: "le format du fichier importé n'est pas conforme. Les formats supportés sont: Word, doc, docs,docm ,dots, dotm, PDF, dot, rtf", viewController: topController , completion: {
                                })
                            }}
                        onComplition(.serverError, nil)
                        debugPrint("error uploading")
                    case 413:
                        if var topController = UIApplication.shared.keyWindow?.rootViewController {
                            while let presentedViewController = topController.presentedViewController {
                                topController = presentedViewController
                            }
                            DispatchQueue.main.async {
                                let alert = UIAlertController(title: "Ops!", message: "Document trop large." , preferredStyle: .alert)
                                let alertAction = UIAlertAction(title: "Ok", style: .default)
                                alert.addAction(alertAction)
                                topController.present(alert, animated: true)
                            }}
                        
                        onComplition(.FileTooLarge, nil)
                        debugPrint("error upload")
                    default:
                        
                        print("Data upload Data failed")
                        debugPrint("fatal error")
                        onComplition(.unknownError, nil)
                    }
                    
                }
            case .failure(let error):
                print("$ uploadData failed")
                print(error.localizedDescription)
                
                if var topController = UIApplication.shared.keyWindow?.rootViewController {
                    while let presentedViewController = topController.presentedViewController {
                        topController = presentedViewController
                    }
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Ops!", message: "Erreur inattendue.." , preferredStyle: .alert)
                        let alertAction = UIAlertAction(title: "OK", style: .default)
                        alert.addAction(alertAction)
                        topController.present(alert, animated: true)
                    }}
                onComplition(.unknownError, nil)
            }
            
        }
    }
    
    enum UploadResult {
        case succes(Data?)
        case serverError
        case unknownError
        case FileTooLarge
    }
}
