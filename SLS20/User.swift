//
//  User.swift
//  SLS20
//
//  Created by Justin on 12/6/19.
//  Copyright © 2019 Justin Kalan. All rights reserved.
//

import Foundation

class User{
    var email: String?
    var name: String?
    var age: String?
    var potentialCity: String?
    var phoneNumber: String?
    var type:String?
    
    static var sharedUser = User(nm: "test", em: "testemail")
    
    init(nm: String?, em: String?){
        age = "0"
        potentialCity = ""
        phoneNumber = ""
        self.name = nm
        self.email = em
    }
}
