//
//  LoginViewController.swift
//  
//
//  Created by Jill de Ron on 06-12-16.
//
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: Outlets
    @IBOutlet weak var textFieldLoginEmail: UITextField!
    @IBOutlet weak var textFieldLoginPassword: UITextField!
    
    
    @IBAction func loginDidTouch(_ sender: Any) {

    }

    @IBAction func signUpDidTouch(_ sender: Any) {
    }

}

