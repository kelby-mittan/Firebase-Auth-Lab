//
//  ViewController.swift
//  Firebase-Auth-Lab
//
//  Created by Kelby Mittan on 2/28/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import UIKit

enum AccountState {
    case existingUser
    case newUser
}

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    private var accountState: AccountState = .existingUser
    
    private var authSession = AuthenticationSession()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func signupButtonPressed(_ sender: UIButton) {
        
        guard let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty else {
            showAlert(title: "Oops", message: "Missing Info")
            return
        }
        
        authSession.createNewUser(email: email, password: password) { [weak self] (result) in
            
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Could not sign up", message: "\(error.localizedDescription)")
                }
            case .success:
                DispatchQueue.main.async {
                    
                    let mainSB = UIStoryboard(name: "Main", bundle: nil)
                    let profileVC = mainSB.instantiateViewController(identifier: "ProfileViewController") { (coder) in
                        return ProfileViewController(coder: coder)
                        
                    }
                    
                    self?.present(UINavigationController(rootViewController: profileVC), animated: true)
                }
            }
        }
        
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty else {
            showAlert(title: "Oops", message: "Missing Info")
            return
        }
        
        if accountState == .existingUser {
            authSession.signExistingUser(email: email, password: password) { [weak self] (result) in
                switch result {
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.showAlert(title: "Could not login", message: "\(error.localizedDescription)")
                    }
                case .success:
                    DispatchQueue.main.async {
                        let mainSB = UIStoryboard(name: "Main", bundle: nil)
                        let profileVC = mainSB.instantiateViewController(identifier: "ProfileViewController") { (coder) in
                            return ProfileViewController(coder: coder)
                            
                        }
                        
                        self?.present(UINavigationController(rootViewController: profileVC), animated: true)
                    }
                }
            }
        }
    }
}



extension UIViewController {
    func showAlert(title: String, message: String, completion: ((UIAlertAction) -> Void)? = nil) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: completion)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
