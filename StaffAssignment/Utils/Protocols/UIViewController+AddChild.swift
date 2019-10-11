//
//  UIViewController+AddChild.swift
//  StaffAssignment
//
//  Created by Jingmeng.Gan on 10/10/19.
//  Copyright © 2019 Jingmeng.Gan. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func add(child: UIViewController, container: UIView) {
        addChild(child)
        container.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func remove() {
        guard parent != nil else {
            return
        }
        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }
}
