//
//  AlertPopUp.swift
//  EmptyArchitectureProject
//
//  Created by Rami Ounifi on 6/19/20.
//  Copyright © 2020 Yellow. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
class AlertPopUp {
    
    static let alert = AlertPopUp()

    init() {
    }
    
    func getAlertWithOkMessage(title: String, message: String, viewController: UIViewController) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
        viewController.present(alert, animated: true)
        
    }
    

    
    
    func showValidationAlertWithOkComplition(title: String, msg: String , viewController: UIViewController, completion: @escaping (() -> Void)) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
            DispatchQueue.main.async {
                completion()
            }
            
        })
        
        alert.addAction(alertAction)
        viewController.present(alert, animated: true, completion: nil)
    }
    
    func showValidationAlertWithReTryComplition(title: String, msg: String , viewController: UIViewController, completion: @escaping (() -> Void)) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Réessayer", style: .default, handler: { _ in
            DispatchQueue.main.async {
                completion()
            }
            
        })
        
        alert.addAction(alertAction)
        viewController.present(alert, animated: true, completion: nil)
    }
    
    func showValidationAlertYesNoComplition(title: String, msg: String , viewController: UIViewController, completion: @escaping (() -> Void)) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let alertActionYes = UIAlertAction(title: "Oui", style: .default, handler: { _ in
            DispatchQueue.main.async {
                completion()
            }
            
        })
        let alertActionNo = UIAlertAction(title: "Non", style: .default, handler: nil)
        alert.addAction(alertActionYes)
        alert.addAction(alertActionNo)
        viewController.present(alert, animated: true, completion: nil)
    }
    
    func showDisconnectAlertYesNoComplition(title: String, msg: String , viewController: UIViewController, completion: @escaping (() -> Void)) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let alertActionYes = UIAlertAction(title: "Se déconnecter", style: .default, handler: { _ in
            DispatchQueue.main.async {
                completion()
            }
            
        })
        let alertActionNo = UIAlertAction(title: "Annuler", style: .default, handler: nil)
        alert.addAction(alertActionYes)
        alert.addAction(alertActionNo)
        viewController.present(alert, animated: true, completion: nil)
    }
    
    
    func showFaceIdPopUp(title: String, msg: String , viewController: UIViewController, completion: @escaping (() -> Void)) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let alertActionYes = UIAlertAction(title: "Activer", style: .default, handler: { _ in
            DispatchQueue.main.async {
                completion()
            }
            
        })
        let alertActionNo = UIAlertAction(title: "Non, merci", style: .default, handler: nil)
         alert.addAction(alertActionNo)
        alert.addAction(alertActionYes)
       
        viewController.present(alert, animated: true, completion: nil)
    }
    
}

extension UIAlertAction {
    var titleTextColor: UIColor? {
        get {
            return self.value(forKey: "titleTextColor") as? UIColor
        } set {
            self.setValue(newValue, forKey: "titleTextColor")
        }
    }
    
    //Set title font and title color
       func setTitlet(font: UIFont?, color: UIColor?) {
           guard let title = self.title else { return }
           let attributeString = NSMutableAttributedString(string: title)//1
           if let titleFont = font {
               attributeString.addAttributes([NSAttributedString.Key.font : titleFont],//2
                                             range: NSMakeRange(0, title.utf8.count))
           }
           
           if let titleColor = color {
               attributeString.addAttributes([NSAttributedString.Key.foregroundColor : titleColor],range: NSMakeRange(0, title.utf8.count))
           }
           self.setValue(attributeString, forKey: "attributedTitle")//4
       }
}

