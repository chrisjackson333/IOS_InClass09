//
//  ViewController.swift
//  InClass09
//
//  Created by Jackson, William on 6/24/19.
//  Copyright © 2019 Jackson, William. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func submitBtnTapped(_ sender: UIButton) {
        
        if emailTF.text != "" && passwordTF.text != "" {
            Auth.auth().signIn(withEmail: emailTF.text!, password: passwordTF.text!) { (authResult, error) in
                if error == nil {
                    print("User Logged In")
                    self.performSegue(withIdentifier: "LoginToContacts", sender: nil)
                } else {
                    let alert = UIAlertController(title: "Error", message: "\(error!.localizedDescription)", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        } else {
            if emailTF.text == "" {
                let alert = UIAlertController(title: "Alert", message: "Email is empty", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "Alert", message: "Password is empty", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        
    }
    @IBAction func createNewAccountBtnTapped(_ sender: UIButton) {
        self.performSegue(withIdentifier: "LoginToSignUp", sender: nil)
    }
    
    
}

