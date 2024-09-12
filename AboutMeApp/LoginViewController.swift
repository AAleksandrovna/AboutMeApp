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
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    let user = "Alexey"
    let password = "Swift"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for textField in usersLoginPassword {
            textField.autocorrectionType = .no
            textField.spellCheckingType = .no
            textField.autocapitalizationType = .none
        }
        
        subscripeToKeyboardsNotification()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        guard usersLoginPassword[0].text == user, usersLoginPassword[1].text == password else {
            showAlert(withTitle: "Invalid login or password",
                andMessage: "Please, enter correct your login and password")
            
            return false
        }
        
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let welcomeVC = segue.destination as? WelcomeViewController
        
        welcomeVC?.greetingValue = "Hello, \(user)!" 
    }
    
    @IBAction func forgotLoginButtonTapped() {
        showAlert(withTitle: "Hmmm", andMessage: "Your Login is Alexey")
    }
    
    @IBAction func forgotPasswordButtonTapped() {
        showAlert(withTitle: "Opssss", andMessage: "Your Password is Swift")
    }
    
    @IBAction func unwind(for segue: UIStoryboardSegue) {
        for textField in usersLoginPassword {
            textField.text = ""
        }
    }
    
    private func showAlert(withTitle title: String, andMessage message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let thanks = UIAlertAction(title: "Thanks!", style: .default)
        { _ in self.usersLoginPassword[1].text = "" }
        
        alert.addAction(thanks)
        present(alert, animated: true)
    }
    
    @objc func subscripeToKeyboardsNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardDidHideNotification,
                                               object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        let animationDuration = (notification.userInfo? [UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0.3
        
        UIView.animate(withDuration: animationDuration) {
            self.bottomConstraint.constant = keyboardFrame.height * 1.5
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        
        let animationDuration = (notification.userInfo? [UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0.3
        
        UIView.animate(withDuration: animationDuration) {
            self.view.layoutIfNeeded()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidHideNotification, object: nil)
    }
}
