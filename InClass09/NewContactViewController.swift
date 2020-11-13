//
//  NewContactViewController.swift
//  InClass09
//
//  Created by Jackson, William on 6/24/19.
//  Copyright © 2019 Jackson, William. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class NewContactViewController: UIViewController {
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var segControl: UISegmentedControl!
    
    let ref = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    @IBAction func submitBtnTapped(_ sender: UIButton) {
        if nameTF.text != "" && emailTF.text != "" && phoneTF.text != "" {
            let contact = Contact()
            contact.name = nameTF.text!
            contact.email = emailTF.text!
            contact.phone = phoneTF.text!
            
            switch segControl.selectedSegmentIndex {
            case 0:
                contact.phoneType = Contact.type.cell
            case 1:
                contact.phoneType = Contact.type.home
            case 2:
                contact.phoneType = Contact.type.office
            default:
                    break
            }
            var contactType: String = ""
            switch contact.phoneType! {
            case Contact.type.cell:
                contactType = "cell"
            case Contact.type.home:
                contactType = "home"
            case Contact.type.office:
                contactType = "office"
            }
            let contactInfo = ["name": contact.name!,
                               "email": contact.email!,
                               "phone": contact.phone!,
                               "phoneType": contactType
            ] as [String: AnyObject]

            ref.child("contacts").childByAutoId().setValue(contactInfo)
            self.dismiss(animated: true, completion: nil)
            
            
        } else {
            if nameTF.text == "" {
                let alert = UIAlertController(title: "Alert", message: "Name is empty", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } else if emailTF.text == "" {
                let alert = UIAlertController(title: "Alert", message: "Email is empty", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } else if phoneTF.text != "" {
                let alert = UIAlertController(title: "Alert", message: "Phone is empty", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func cancelTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
