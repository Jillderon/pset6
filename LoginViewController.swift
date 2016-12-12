//
//  LoginViewController.swift
//  
//
//  Created by Jill de Ron on 06-12-16.
//
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {
    
    /// MARK: Outlets
    @IBOutlet weak var textFieldLoginEmail: UITextField!
    @IBOutlet weak var textFieldLoginPassword: UITextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    /// MARK: Actions
        
    // This code will authenticate the user when they attempt to log in by tapping the Login button.
    @IBAction func loginDidTouch(_ sender: Any) {
        FIRAuth.auth()?.signIn(withEmail: textFieldLoginEmail.text!,
                               password: textFieldLoginPassword.text!)
    }
    
    @IBAction func signUpDidTouch(_ sender: Any) {
        let alert = UIAlertController(title: "Register",
                                      message: "Register",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save",
          style: .default) { action in
            // get the email and password as supplied by the user from the alert controller
            let emailField = alert.textFields![0]
            let passwordField = alert.textFields![1]
            
            FIRAuth.auth()?.createUser(withEmail: emailField.text!,
                                   password: passwordField.text!) { (user, error) in
                if error == nil {
                    FIRAuth.auth()!.signIn(withEmail: self.textFieldLoginEmail.text!,
                                        password: self.textFieldLoginPassword.text!)
                }
                else {
                    print(error!)
                }
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default)
        
        alert.addTextField { textEmail in
            textEmail.placeholder = "Enter your email"
        }
        
        alert.addTextField { textPassword in
            textPassword.isSecureTextEntry = true
            textPassword.placeholder = "Enter your password"
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == textFieldLoginEmail {
            textFieldLoginPassword.becomeFirstResponder()
        }
        if textField == textFieldLoginPassword {
            textField.resignFirstResponder()
        }
        return true
    }
    
}


