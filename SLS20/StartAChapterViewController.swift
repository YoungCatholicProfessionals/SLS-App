//
//  StartAChapterViewController.swift
//  SLS20
//
//  Created by Justin on 12/11/19.
//  Copyright © 2019 Justin Kalan. All rights reserved.
//

import UIKit
import Firebase

class StartAChapterViewController: UIViewController{
    let user: User! = nil
    
    @IBOutlet weak var cityTextField: UITextField!
    
    @IBOutlet weak var genderTextField: UITextField!
    
    @IBOutlet weak var ageTextField: UITextField!
    
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    @IBOutlet weak var personTypePicker: UIPickerView!
    var pickerOptions:[String] = ["Young Catholic Professional (20-39)", "Seasonsed Catholic", "Diocesan/Church Employee"]
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func submitTapped(_ sender: Any) {
        if(cityTextField.hasText){
            user?.age =  ageTextField.text!
            user?.potentialCity = cityTextField.text
            user?.type = "Young Catholic Professional"
            user?.name = User.sharedUser.name
            user?.email = User.sharedUser.email
            user?.phoneNumber = phoneNumberTextField.text
            
            writeToDatabase()
        }
        performSegue(withIdentifier: "toHome", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func writeToDatabase(){
        let ref = Database.database().reference()
        var newDict: [String:Any] = ["email": user?.email, "name": user?.name, "city": user?.potentialCity,
                                     "age": user?.age, "type": user?.type, "phone":user?.phoneNumber, "interest": "start a chapter"]
        ref.child("people").setValue(newDict)
    }
}

extension StartAChapterViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerOptions[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerOptions.count
    }
}
