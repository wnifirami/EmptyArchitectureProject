//
//  WelcomeViewModel.swift
//  EmptyArchitectureProject
//
//  Created by Rami Ounifi on 6/22/20.
//  Copyright © 2020 Yellow. All rights reserved.
//

import Foundation
import RxSwift
class WelcomeViewModel {
    enum State {
         case initial
         case loading
         case loaded([UserResponseElement])
         case error(Error)
     }
     let state = Variable(State.initial)
    let disposeBag = DisposeBag()
    var testSeervices: TestProtocol
    init(testService: TestServices) {
        self.testSeervices = testService
    }
    func loadUsers(){
         
         self.testSeervices.getUser()
             .`do`(onSubscribe: { })
             .subscribe(onNext: { [weak self] response in
                 
                self?.state.value = .loaded(response)
               
                 //self?.folders.onCompleted()
                 }, onError: {error in
                     self.state.value = .error(error)
                
             })
             .disposed(by: disposeBag)
     }
}
