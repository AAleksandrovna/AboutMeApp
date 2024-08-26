//
//  LoginViewController.swift
//  AboutMeApp
//
//  Created by Анастасия Восколович on 26.08.2024.
//


import UIKit
import SwiftUI

final class LoginViewController: UIViewController {
    
    @IBOutlet var usersLoginPassword: [UITextField]!
    
    let user = "Alexey"
    let password = "Swift"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for textField in usersLoginPassword {
            textField.autocorrectionType = .no
            textField.spellCheckingType = .no
            textField.autocapitalizationType = .none
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        guard usersLoginPassword[0].text == user, usersLoginPassword[1].text == password else {
            
            showAlert(withTitle: "Invalid login or password", andMessage: "Please, enter correct your login and password")
            
            return false
        }
        
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let welcomeVC = segue.destination as? WelcomeViewController
        
        welcomeVC?.greetingValue = user
    }
    
    override func unwind(for unwindSegue: UIStoryboardSegue, towards subsequentVC: UIViewController) {
        for textField in usersLoginPassword {
            textField.text = ""
        }
    }
    
    @IBAction func forgotLoginButtonTapped() {
        showAlert(withTitle: "Hmmm", andMessage: "Your Login is Alexey")
    }
    
    @IBAction func forgotPasswordButtonTapped() {
        showAlert(withTitle: "Opssss", andMessage: "Your Password is Swift")
    }
    
    private func showAlert(withTitle title: String, andMessage message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let thanks = UIAlertAction(title: "Thanks!", style: .default)
        
        alert.addAction(thanks)
        present(alert, animated: true)
    }


}
