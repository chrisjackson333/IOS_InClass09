//
//  Contact.swift
//  InClass09
//
//  Created by Jackson, William on 6/24/19.
//  Copyright © 2019 Jackson, William. All rights reserved.
//

class Contact {
    
    var name: String?
    var email: String?
    var phone: String?
    var phoneType: type?
    var id: String?
    
    enum type: String {
        case cell 
        case home
        case office
    }
    
    init(dict: [String: AnyObject], id: String) {
        self.name = dict["name"] as? String
        self.email = dict["email"] as? String
        self.phone = dict["phone"] as? String
        self.phoneType = Contact.type(rawValue: (dict["phoneType"] as! String))
        self.id = id
        
    }
    init() {
        self.name = ""
        self.email = ""
        self.phone = ""
        self.phoneType = type.cell
        self.id = ""
    }
    
}
