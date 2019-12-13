//
//  ViewController.swift
//  SLS20
//
//  Created by Justin on 12/6/19.
//  Copyright © 2019 Justin Kalan. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    var ref: DatabaseReference!
    var refHandle: DatabaseHandle?
    var newUserDict: [String: Any] = ["Email": "", "name": "", "age": 0]
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var warningLabel: UILabel!
    
    var recognizer: UITapGestureRecognizer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        signInAnonymously()
        emailTextField.delegate = self
        nameTextField.delegate = self
        recognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.handleTap))
        view.addGestureRecognizer(recognizer!)
    }
    
    @objc func handleTap(){
        emailTextField.resignFirstResponder()
        nameTextField.resignFirstResponder()
    }
    
    @IBAction func startAChapterButton(_ sender: Any) {
        if(notFilledOut()){
            warningLabel.isHidden = false
        }
        else{
            goToNextScreen()
        }
    }
    
    func goToNextScreen(){
        User.sharedUser = User(nm: nameTextField.text, em: emailTextField.text)
        performSegue(withIdentifier: "toStartAChapter", sender: self)
    }
    
    /*
     * checks whether or not the text fields are filled out
     * called once the submit button is tapped. True means fields
     * need to be filled out
     */
    func notFilledOut() -> Bool{
        if(nameTextField.text == "" || emailTextField.text == ""){
            return true
        }
        return false
    }
    
    
    @IBAction func joinAChapterButton(_ sender: Any) {
    }
    
    @IBAction func becomeAMemberButton(_ sender: Any) {
    }
    
    @IBAction func justLearnMoreButton(_ sender: Any) {
    }
    func signInAnonymously(){
        Auth.auth().signInAnonymously { (user, error) in
            if (error == nil){
                print("signed in successfully")
                guard let newUser = user else {return}
                print(newUser.uid)
            }
            else{
                print(error)
            }
        }
    }


}

extension ViewController: UITextFieldDelegate{
    /* validate email field */
    private func textFieldShouldEndEditing(_ textField: UITextField) {
        if(!(emailTextField.text?.contains("@"))!){
            warningLabel.text = "Enter a valid Email"
            warningLabel.isHidden = false
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(emailTextField.isFirstResponder){
            print("going to next screen")
            goToNextScreen()
            return true
        }
        else{
            print("changing text fields")
            nameTextField.resignFirstResponder()
            emailTextField.becomeFirstResponder()
            return true
        }
    }
}

