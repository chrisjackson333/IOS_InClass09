//
//  ContactsViewController.swift
//  InClass09
//
//  Created by Jackson, William on 6/24/19.
//  Copyright © 2019 Jackson, William. All rights reserved.
//

import UIKit
import Firebase

class ContactsViewController: UIViewController {
    
    var contacts = [Contact]()
    var tappedContact: Contact?
    let tableView: UITableView = {
        var tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(ContactTVCell.self, forCellReuseIdentifier: "CellID")
        return tv
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        getContacts()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getContacts()
        view.addSubview(tableView)
        [
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ].forEach({ $0.isActive = true })
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    let ref = Database.database().reference()
    let dg = DispatchGroup()
    func getContacts() {
        var tempContacts = [Contact]()
        dg.enter()
        ref.child("contacts").observeSingleEvent(of: .value) { (snapshot) in
            let data = snapshot.value as? [String: AnyObject]
            for (id,value) in data! {
                let contact = Contact(dict: value as! [String : AnyObject], id: id)
                tempContacts.append(contact)
            }
            self.contacts = tempContacts
            self.dg.leave()
        }
        dg.notify(queue: .main) {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
    
    func deleteContact(index: Int) {
        ref.child("contacts").child("\(contacts[index].id!)").removeValue()
    }
    
    @objc func deleteTapped(sender: UIButton) {
        let cell = sender.superview as! ContactTVCell
        let index = cell.tag
        deleteContact(index: index)
        getContacts()
    }
    
    @IBAction func addBtnTapped(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "ContactsToNewContact", sender: nil)
    }
    
    @IBAction func logoutTapped(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: "SegueToLogin", sender: nil)
        } catch let err {
            print("Error \(err)")
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ContactsToDetails" {
            let vc = segue.destination as! DetailsViewController
            vc.contact = tappedContact!
        } 
    }
    
}

extension ContactsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellID", for: indexPath) as! ContactTVCell
        cell.contact = contacts[indexPath.row]
        cell.name.text = contacts[indexPath.row].name!
        cell.email.text = contacts[indexPath.row].email!
        var phoneType: String = "cell"
        switch contacts[indexPath.row].phoneType {
        case .cell?:
            phoneType = "cell"
        case .home?:
            phoneType = "home"
        case .office?:
            phoneType = "office"
        default:
            break
        }
        cell.phone.text = "\(contacts[indexPath.row].phone!) (\(phoneType))"
        cell.delete.addTarget(self, action: #selector(deleteTapped), for: .touchUpInside)
        cell.tag = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ContactTVCell
        tappedContact = cell.contact!
        performSegue(withIdentifier: "ContactsToDetails", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    
}

class ContactTVCell: UITableViewCell {
    
    var contact: Contact?
    
    let name: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Name"
        return label
    }()
    let email: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Email"
        return label
    }()
    let phone: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "PhoneNumber (Phone Type)"
        return label
    }()
    let delete: UIButton = {
        var btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Delete", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        return btn
    }()
    
    func setupViews() {
        addSubview(name)
        [
            name.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            name.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            name.widthAnchor.constraint(equalToConstant: 240),
            name.heightAnchor.constraint(equalToConstant: 30)
        ].forEach({ $0.isActive = true })
        addSubview(email)
        [
            email.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            email.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 4),
            email.widthAnchor.constraint(equalToConstant: 240),
            email.heightAnchor.constraint(equalToConstant: 30)
            ].forEach({ $0.isActive = true })
        addSubview(phone)
        [
            phone.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            phone.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 4),
            phone.widthAnchor.constraint(equalToConstant: 240),
            phone.heightAnchor.constraint(equalToConstant: 30)
            ].forEach({ $0.isActive = true })
        addSubview(delete)
        [
            delete.leftAnchor.constraint(equalTo: phone.rightAnchor, constant: 10),
            delete.bottomAnchor.constraint(equalTo: phone.bottomAnchor),
            delete.widthAnchor.constraint(equalToConstant: 100),
            delete.heightAnchor.constraint(equalToConstant: 30)
            ].forEach({ $0.isActive = true })
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

