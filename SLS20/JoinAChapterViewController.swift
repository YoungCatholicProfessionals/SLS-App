//
//  JoinAChapterViewController.swift
//  SLS20
//
//  Created by Justin on 12/19/19.
//  Copyright © 2019 Justin Kalan. All rights reserved.
//

import UIKit
import Firebase

class JoinAChapterViewController: UIViewController{
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    let user: User = User(nm: "", em:"")
    var pickerOptions:[String] = ["Select one", "Austin", "Chicago", "Cleveland", "Columbus", "Dallas", "Denver", "Detroit", "Fort Worth", "Houston", "Jacksonville", "Los Angeles", "New Orleans", "Omaha", "Orange County", "Orlando", "Phoenix", "Portland", "San Antonio", "San Diego", "Silicon Valley"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        user.name = User.sharedUser.name
        user.email = User.sharedUser.email
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    func writeToDatabase(){
        let ref = Database.database().reference()
        print(user)
        let newDict: [String:String] = ["email": (user.email)!, "name": (user.name)!, "city": (user.potentialCity)!,
                                        "age": (user.age)!, "type": (user.type)!, "phone":(user.phoneNumber)!, "interest": "join a chapter"]
        print(user.name, user.type)
        ref.child("people").child((user.name)!).setValue(newDict)
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func submitButton(_ sender: Any) {
        user.age = ""
        user.type = ""
        user.phoneNumber = ""
        writeToDatabase()
        performSegue(withIdentifier: "backToMain", sender: self)
    }
}

extension JoinAChapterViewController: UIPickerViewDataSource{
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

extension JoinAChapterViewController: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        user.potentialCity = pickerOptions[row]
        print(pickerOptions[row])
        print(user.name, user.potentialCity)
    }
}
