//
//  GreetingViewController.swift
//  AboutMeApp
//
//  Created by Анастасия Восколович on 14.08.2024.
//

import UIKit

final class WelcomeViewController: UIViewController {
    

    @IBOutlet var greeting: UILabel!
    
    var greetingValue: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        greeting.text = greetingValue
    }

    @IBAction func logOutButtonPressed() {
        dismiss(animated: true)
    }
}
