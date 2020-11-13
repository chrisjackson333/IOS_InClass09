//
//  DetailsViewController.swift
//  InClass09
//
//  Created by Jackson, William on 6/24/19.
//  Copyright © 2019 Jackson, William. All rights reserved.
//

import UIKit
import Firebase

class DetailsViewController: UIViewController {
    
    var contact = Contact()
    
    let nameLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Name"
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        return label
    }()
    let name: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Bob"
        return label
    }()
    let emailLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Email"
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        return label
    }()
    let email: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "email@email.com"
        return label
    }()
    let phoneLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Phone"
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        return label
    }()
    let phone: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "79242649"
        return label
    }()
    let phoneTypeLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Phone Type"
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        return label
    }()
    let phoneType: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Cell"
        return label
    }()
    let delete: UIButton = {
        var btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Delete", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.addTarget(self, action: #selector(deleteTapped), for: .touchUpInside)
        return btn
    }()
    let edit: UIButton = {
        var btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Edit", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.addTarget(self, action: #selector(editTapped), for: .touchUpInside)
        return btn
    }()
    let ref = Database.database().reference()
    @objc func deleteTapped() {
        ref.child("contacts").child("\(contact.id!)").removeValue()
        navigationController?.popViewController(animated: true)
    }
    
    @objc func editTapped() {
        performSegue(withIdentifier: "SegueToEdit", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueToEdit" {
            let vc = segue.destination as! EditContactViewController
            vc.contact = contact
        }
    }
    
    @objc func recivedNotification(notification: Notification) {
        let newContact = notification.object as! Contact
        name.text = newContact.name!
        email.text = newContact.email!
        phone.text = newContact.phone!
        var contactType: String = ""
        switch newContact.phoneType! {
        case Contact.type.cell:
            contactType = "cell"
        case Contact.type.home:
            contactType = "home"
        case Contact.type.office:
            contactType = "office"
        }
        phoneType.text = contactType
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(recivedNotification), name: NSNotification.Name(rawValue: "ContactUpdated"), object: nil)
        view.addSubview(nameLabel)
        [
            nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 14),
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 14),
            nameLabel.widthAnchor.constraint(equalToConstant: 200),
            nameLabel.heightAnchor.constraint(equalToConstant: 30)
        ].forEach({ $0.isActive = true })
        name.text = contact.name!
        view.addSubview(name)
        [
            name.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 14),
            name.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 6),
            name.widthAnchor.constraint(equalToConstant: 200),
            name.heightAnchor.constraint(equalToConstant: 30)
        ].forEach({ $0.isActive = true })
        view.addSubview(emailLabel)
        [
            emailLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 14),
            emailLabel.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 14),
            emailLabel.widthAnchor.constraint(equalToConstant: 200),
            emailLabel.heightAnchor.constraint(equalToConstant: 30)
        ].forEach({ $0.isActive = true })
        email.text = contact.email!
        view.addSubview(email)
        [
            email.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 14),
            email.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 6),
            email.widthAnchor.constraint(equalToConstant: 200),
            email.heightAnchor.constraint(equalToConstant: 30)
        ].forEach({ $0.isActive = true })
        view.addSubview(phoneLabel)
        [
            phoneLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 14),
            phoneLabel.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 14),
            phoneLabel.widthAnchor.constraint(equalToConstant: 200),
            phoneLabel.heightAnchor.constraint(equalToConstant: 30)
        ].forEach({ $0.isActive = true })
        phone.text = contact.phone!
        view.addSubview(phone)
        [
            phone.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 14),
            phone.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 6),
            phone.widthAnchor.constraint(equalToConstant: 200),
            phone.heightAnchor.constraint(equalToConstant: 30)
        ].forEach({ $0.isActive = true })
        view.addSubview(phoneTypeLabel)
        [
            phoneTypeLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 14),
            phoneTypeLabel.topAnchor.constraint(equalTo: phone.bottomAnchor, constant: 14),
            phoneTypeLabel.widthAnchor.constraint(equalToConstant: 200),
            phoneTypeLabel.heightAnchor.constraint(equalToConstant: 30)
        ].forEach({ $0.isActive = true })
        var contactType: String = ""
        switch contact.phoneType! {
        case Contact.type.cell:
            contactType = "cell"
        case Contact.type.home:
            contactType = "home"
        case Contact.type.office:
            contactType = "office"
        }
        phoneType.text = contactType
        view.addSubview(phoneType)
        [
            phoneType.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 14),
            phoneType.topAnchor.constraint(equalTo: phoneTypeLabel.bottomAnchor, constant: 6),
            phoneType.widthAnchor.constraint(equalToConstant: 200),
            phoneType.heightAnchor.constraint(equalToConstant: 30)
        ].forEach({ $0.isActive = true })
        view.addSubview(delete)
        [
            delete.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 14),
            delete.topAnchor.constraint(equalTo: phoneType.bottomAnchor, constant: 6),
            delete.widthAnchor.constraint(equalToConstant: 100),
            delete.heightAnchor.constraint(equalToConstant: 30)
        ].forEach({ $0.isActive = true })
        view.addSubview(edit)
        [
            edit.leftAnchor.constraint(equalTo: delete.rightAnchor, constant: 100),
            edit.topAnchor.constraint(equalTo: delete.topAnchor),
            edit.widthAnchor.constraint(equalToConstant: 100),
            edit.heightAnchor.constraint(equalToConstant: 30)
        ].forEach({ $0.isActive = true })
        
        
    }
    
}
