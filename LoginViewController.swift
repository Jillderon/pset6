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
    
    // MARK: Outlets
    @IBOutlet weak var textFieldLoginEmail: UITextField!
    @IBOutlet weak var textFieldLoginPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FIRAuth.auth()!.addStateDidChangeListener() { auth, user in
            if user != nil {
                self.performSegue(withIdentifier: "toChores", sender: nil)
            }
        }
    }
    
        
    // This code will authenticate the user when they attempt to log in by tapping the Login button.
    @IBAction func loginDidTouch(_ sender: Any) {
        FIRAuth.auth()!.signIn(withEmail: textFieldLoginEmail.text!,
                               password: textFieldLoginPassword.text!) {
            (user, error) in
            if error != nil {
                self.alertUser(title: "Login Error", message: "Enter valid password and/or email")
            }
        }
    
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
                    self.alertUser(title: "Not signed up", message: "Invalid password. Password should be at least 6 charachters long")
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
    
    func alertUser(title: String, message: String) {
        let alertLoginController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default)
        alertLoginController.addAction(cancelAction)
        present(alertLoginController, animated: true, completion: nil)
    }

    
    // State restoration. Only saving email and not password, because of security reasons.
    // Cited from: https://www.raywenderlich.com/117471/state-restoration-tutorial
    override func encodeRestorableState(with coder: NSCoder) {
        if let email = textFieldLoginEmail.text {
            coder.encode(email, forKey: "email")
        }
        
        super.encodeRestorableState(with: coder)
    }
    
    override func decodeRestorableState(with coder: NSCoder) {
        textFieldLoginEmail.text = coder.decodeObject(forKey: "email") as! String?
        super.decodeRestorableState(with: coder)
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


