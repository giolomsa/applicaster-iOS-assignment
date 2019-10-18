//
//  UIScrollViewDelegateExtension.swift
//  ApplicasteriOS
//
//  Created by Gio Lomsa on 10/18/19.
//  Copyright © 2019 Giorgi Lomsadze. All rights reserved.
//

import Foundation
import UIKit

extension RootViewController: UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pan = scrollView.panGestureRecognizer
        let velocity = pan.velocity(in: scrollView).y
        if velocity < -50 {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        } else if velocity > 50 {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        }
        
    }
}
