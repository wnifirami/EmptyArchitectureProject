//
//  TestProtocol.swift
//  EmptyArchitectureProject
//
//  Created by Rami Ounifi on 6/22/20.
//  Copyright © 2020 Yellow. All rights reserved.
//

import Foundation
import RxSwift
protocol TestProtocol {
    func getUser() -> Observable<[UserResponseElement]>
}
