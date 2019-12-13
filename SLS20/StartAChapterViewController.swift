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
    let user: User = User(nm:"", em:"")
    
    @IBOutlet weak var cityTextField: UITextField!
    
    @IBOutlet weak var genderTextField: UITextField!
    
    @IBOutlet weak var ageTextField: UITextField!
    
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    @IBOutlet weak var warningField: UILabel!
    
    @IBOutlet weak var personTypePicker: UIPickerView!
    
    var recognizer: UITapGestureRecognizer?
    
    var pickerOptions:[String] = ["Young Catholic Professional (20-39)", "Seasonsed Catholic", "Diocesan/Church Employee"]
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func submitTapped(_ sender: Any) {
        if(notFilledOut()){
            warningField.isHidden = false
        }
        else{
            user.age =  ageTextField.text ?? "no age"
            user.potentialCity = cityTextField.text ?? " no city"
            user.name = User.sharedUser.name ?? " no name"
            user.email = User.sharedUser.email ?? " no email"
            user.phoneNumber = phoneNumberTextField.text ?? " no phone"
            print(user.age, user.email, user.name, user.phoneNumber)
            writeToDatabase()
            performSegue(withIdentifier: "toHome", sender: self)
        }
    }
    /*
     * checks whether or not the text fields are filled out
     * called once the submit button is tapped. True means fields
     * need to be filled out
     */
    func notFilledOut() -> Bool{
        if(ageTextField.text == "" || cityTextField.text == "" || phoneNumberTextField.text == "" || genderTextField.text == ""){
            return true
        }
        return false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        personTypePicker.delegate = self
        personTypePicker.dataSource = self
        recognizer = UITapGestureRecognizer(target: self, action: #selector(StartAChapterViewController.handleTap))
        view.addGestureRecognizer(recognizer!)
    }
    
    @objc func handleTap(){
        cityTextField.resignFirstResponder()
        ageTextField.resignFirstResponder()
        phoneNumberTextField.resignFirstResponder()
        genderTextField.resignFirstResponder()
    }
    
    func writeToDatabase(){
        let ref = Database.database().reference()
        let newDict: [String:String] = ["email": (user.email)!, "name": (user.name)!, "city": (user.potentialCity)!,
                                        "age": (user.age)!, "type": (user.type)!, "phone":(user.phoneNumber)!, "interest": "start a chapter"]
        print(user.name, user.type)
        ref.child("people").child((user.name)!).setValue(newDict)
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

extension StartAChapterViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        user.type = pickerOptions[row]
        print(pickerOptions[row])
        print(user.name, user.type)
    }
}

extension StartAChapterViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(phoneNumberTextField.isFirstResponder){
            phoneNumberTextField.resignFirstResponder()
        }
        if(genderTextField.isFirstResponder){
            genderTextField.resignFirstResponder()
        }
        if(ageTextField.isFirstResponder){
            ageTextField.resignFirstResponder()
        }
        if(cityTextField.isFirstResponder){
            cityTextField.resignFirstResponder()
        }
        return true
    }
}
