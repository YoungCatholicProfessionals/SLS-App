//
//  ConferenceInterestViewController.swift
//  SLS20
//
//  Created by Justin on 12/19/19.
//  Copyright © 2019 Justin Kalan. All rights reserved.
//

import Firebase
import UIKit

class ConferenceInterestViewController: UIViewController{
    
    let user: User = User(nm:"", em:"")
    
    @IBAction func finishButton(_ sender: Any) {
        writeToDatabase()
        performSegue(withIdentifier: "ConfToHome", sender: self)
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        user.email = User.sharedUser.email
        user.name = User.sharedUser.name
        user.potentialCity = ""
        user.age = ""
        user.type = ""
        user.phoneNumber = ""
    }
    
    func writeToDatabase(){
        let ref = Database.database().reference()
        let newDict: [String:String] = ["email": (user.email)!, "name": (user.name)!, "city": (user.potentialCity)!,
                                        "age": (user.age)!, "type": (user.type)!, "phone":(user.phoneNumber)!, "interest": "conference"]
        print(user.name, user.type)
        ref.child("people").child((user.name)!).setValue(newDict)
    }
}
