//
//  UIDynamicTableView.swift
//  EmptyArchitectureProject
//
//  Created by Rami Ounifi on 6/19/20.
//  Copyright © 2020 Yellow. All rights reserved.
//

import Foundation
import UIKit
class UIDynamicTableView: UITableView
{
    override var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: self.contentSize.height)
    }

    override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
    }
}
