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
    
    override func viewDidLoad() {
        ref = Database.database().reference()
        super.viewDidLoad()
        signInAnonymously()
    }
    
    @IBAction func startAChapterButton(_ sender: Any) {
        User.sharedUser = User(nm: nameTextField.text, em: emailTextField.text)
        performSegue(withIdentifier: "toStartAChapter", sender: self)
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

