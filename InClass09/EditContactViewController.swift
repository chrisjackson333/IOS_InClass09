//
//  EditContactViewController.swift
//  InClass09
//
//  Created by Jackson, William on 6/24/19.
//  Copyright © 2019 Jackson, William. All rights reserved.
//

import UIKit
import Firebase

class EditContactViewController: UIViewController {
    
    var contact = Contact()
    
    let nameLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Name"
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        return label
    }()
    let nameTF: UITextField = {
        var tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    let emailLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Email"
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        return label
    }()
    let emailTF: UITextField = {
        var tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    let phoneLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Phone"
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        return label
    }()
    let phoneTF: UITextField = {
        var tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    let phoneTypeLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Phone Type"
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        return label
    }()
    let seg: UISegmentedControl = {
        var seg = UISegmentedControl()
        seg.translatesAutoresizingMaskIntoConstraints = false
        seg.insertSegment(withTitle: "Cell", at: 0, animated: true)
        seg.insertSegment(withTitle: "Home", at: 1, animated: true)
        seg.insertSegment(withTitle: "Office", at: 2, animated: true)
        return seg
    }()
    let submit: UIButton = {
        var btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Update", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        return btn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    let ref = Database.database().reference()
    @objc func submitTapped() {
        if nameTF.text != "" || emailTF.text != "" || phoneTF.text != "" {
            let tempContact = Contact()
            tempContact.name = nameTF.text!
            tempContact.email = emailTF.text!
            tempContact.phone = phoneTF.text!
            
            switch seg.selectedSegmentIndex {
            case 0:
                tempContact.phoneType = Contact.type.cell
            case 1:
                tempContact.phoneType = Contact.type.home
            case 2:
                tempContact.phoneType = Contact.type.office
            default:
                break
            }
            var contactType: String = ""
            switch tempContact.phoneType! {
            case Contact.type.cell:
                contactType = "cell"
            case Contact.type.home:
                contactType = "home"
            case Contact.type.office:
                contactType = "office"
            }
            let contactInfo = ["name": tempContact.name!,
                               "email": tempContact.email!,
                               "phone": tempContact.phone!,
                               "phoneType": contactType
                ] as [String: AnyObject]
            
            ref.child("contacts").child(contact.id!).setValue(contactInfo)
            NotificationCenter.default.post(name: NSNotification.Name("ContactUpdated"), object: tempContact)
            navigationController?.popViewController(animated: true)
            
        } else {
            let alert = UIAlertController(title: "Missing Info", message: "Must fill in all fields", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func setupViews() {
        let width = view.frame.width - 20
        view.addSubview(nameLabel)
        [
            nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 14),
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 14),
            nameLabel.widthAnchor.constraint(equalToConstant: width),
            nameLabel.heightAnchor.constraint(equalToConstant: 30)
        ].forEach({ $0.isActive = true })
        nameTF.placeholder = contact.name!
        view.addSubview(nameTF)
        [
            nameTF.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 14),
            nameTF.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            nameTF.widthAnchor.constraint(equalToConstant: width),
            nameTF.heightAnchor.constraint(equalToConstant: 30)
        ].forEach({ $0.isActive = true })
        view.addSubview(emailLabel)
        [
            emailLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 14),
            emailLabel.topAnchor.constraint(equalTo: nameTF.bottomAnchor, constant: 14),
            emailLabel.widthAnchor.constraint(equalToConstant: width),
            emailLabel.heightAnchor.constraint(equalToConstant: 30)
            ].forEach({ $0.isActive = true })
        emailTF.placeholder = contact.email!
        view.addSubview(emailTF)
        [
            emailTF.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 14),
            emailTF.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 4),
            emailTF.widthAnchor.constraint(equalToConstant: width),
            emailTF.heightAnchor.constraint(equalToConstant: 30)
            ].forEach({ $0.isActive = true })
        view.addSubview(phoneLabel)
        [
            phoneLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 14),
            phoneLabel.topAnchor.constraint(equalTo: emailTF.bottomAnchor, constant: 14),
            phoneLabel.widthAnchor.constraint(equalToConstant: width),
            phoneLabel.heightAnchor.constraint(equalToConstant: 30)
            ].forEach({ $0.isActive = true })
        phoneTF.placeholder = contact.phone!
        view.addSubview(phoneTF)
        [
            phoneTF.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 14),
            phoneTF.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 4),
            phoneTF.widthAnchor.constraint(equalToConstant: width),
            phoneTF.heightAnchor.constraint(equalToConstant: 30)
            ].forEach({ $0.isActive = true })
        view.addSubview(phoneTypeLabel)
        [
            phoneTypeLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 14),
            phoneTypeLabel.topAnchor.constraint(equalTo: phoneTF.bottomAnchor, constant: 14),
            phoneTypeLabel.widthAnchor.constraint(equalToConstant: width),
            phoneTypeLabel.heightAnchor.constraint(equalToConstant: 30)
            ].forEach({ $0.isActive = true })
        var segIndex: Int = 0
        switch contact.phoneType! {
        case Contact.type.cell:
            segIndex = 0
        case Contact.type.home:
             segIndex = 1
        case Contact.type.office:
             segIndex = 2
        }
        seg.selectedSegmentIndex = segIndex
        view.addSubview(seg)
        [
            seg.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 14),
            seg.topAnchor.constraint(equalTo: phoneTypeLabel.bottomAnchor, constant: 14),
            seg.widthAnchor.constraint(equalToConstant: width),
            seg.heightAnchor.constraint(equalToConstant: 30)
            ].forEach({ $0.isActive = true })
        view.addSubview(submit)
        [
            submit.centerXAnchor.constraint(equalTo: seg.centerXAnchor),
            submit.topAnchor.constraint(equalTo: seg.bottomAnchor, constant: 14),
            submit.widthAnchor.constraint(equalToConstant: 200),
            submit.heightAnchor.constraint(equalToConstant: 30)
            ].forEach({ $0.isActive = true })
    }
    
}
