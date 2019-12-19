//
//  BecomeAMemberViewController.swift
//  SLS20
//
//  Created by Justin on 12/19/19.
//  Copyright © 2019 Justin Kalan. All rights reserved.
//

import UIKit
import Firebase

class BecomeAMemberViewController: UIViewController{
    let user: User = User(nm: "", em: "")
    var pickerOptions:[String] = ["Select one", "Austin", "Chicago", "Cleveland", "Columbus", "Dallas", "Denver", "Detroit", "Fort Worth", "Houston", "Jacksonville", "Los Angeles", "New Orleans", "Omaha", "Orange County", "Orlando", "Phoenix", "Portland", "San Antonio", "San Diego", "Silicon Valley"]
    @IBOutlet weak var chapterPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        user.name = User.sharedUser.name
        user.email = User.sharedUser.email
        chapterPicker.delegate = self
        chapterPicker.dataSource = self
    }
    
    func writeToDatabase(){
        let ref = Database.database().reference()
        print(user)
        let newDict: [String:String] = ["email": (user.email)!, "name": (user.name)!, "city": (user.potentialCity)!,
                                        "age": (user.age)!, "type": (user.type)!, "phone":(user.phoneNumber)!, "interest": "become a member"]
        print(user.name, user.type)
        ref.child("people").child((user.name)!).setValue(newDict)
    }
    
    @IBAction func submitButton(_ sender: Any) {
        user.age = ""
        user.type = ""
        user.phoneNumber = ""
        writeToDatabase()
        performSegue(withIdentifier: "backHome", sender: self)
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension BecomeAMemberViewController: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        user.potentialCity = pickerOptions[row]
        print(pickerOptions[row])
        print(user.name, user.potentialCity)
    }
}

extension BecomeAMemberViewController: UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerOptions[row]
    }
    
}
