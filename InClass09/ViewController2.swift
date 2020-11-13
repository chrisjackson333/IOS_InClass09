//
//  ViewController2.swift
//  InClass09
//
//  Created by Jackson, William on 6/24/19.
//  Copyright © 2019 Jackson, William. All rights reserved.
//

import UIKit
import Firebase

class ViewController2: UIViewController {
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var confirmTF: UITextField!
    
    var passMatch: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func submitBtnTapped(_ sender: UIButton) {
        
        if passwordTF.text! == confirmTF.text! {
            passMatch = true
        }
        
        if emailTF.text != "" && passwordTF.text != "" && confirmTF.text != "" && passMatch {
            
            Auth.auth().createUser(withEmail: emailTF.text!, password: passwordTF.text!) { (authResult, error) in
                if error == nil {
                    print("User Created")
                    self.performSegue(withIdentifier: "SignUpToContacts", sender: nil)
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
            } else if passwordTF.text == "" {
                let alert = UIAlertController(title: "Alert", message: "Password is empty", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } else if confirmTF.text != "" {
                let alert = UIAlertController(title: "Alert", message: "Confirm Password is empty", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } else if !passMatch {
                let alert = UIAlertController(title: "Alert", message: "Passwords do not match", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
    }
    
    @IBAction func cancelBtnTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

