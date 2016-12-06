//
//  LoginViewController.swift
//  
//
//  Created by Jill de Ron on 06-12-16.
//
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
//    // MARK: Constants
//    let loginToList = "LoginToList"
    
    // MARK: Outlets
    @IBOutlet weak var textFieldLoginEmail: UITextField!
    @IBOutlet weak var textFieldLoginPassword: UITextField!

    // MARK: Actions
    @IBAction func loginDidTouch(_ sender: Any) {
        
    }
    
    @IBAction func signUpDidTouch(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

