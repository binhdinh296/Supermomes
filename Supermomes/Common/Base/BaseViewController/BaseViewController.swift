//
//  BaseViewController.swift
//
//  Created by Mintpot on 3/24/21.
//

import UIKit

class BaseViewController: UIViewController, UITextFieldDelegate, UIGestureRecognizerDelegate {
    
   
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
