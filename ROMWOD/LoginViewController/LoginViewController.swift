//
//  LoginViewController.swift
//  ROMWOD
//
//  Created by Tim Ludikar on 2018-07-13.
//  Copyright © 2018 Tim Ludikar. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var rememberMeSwitch: UISwitch!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var signInButton: UIButton!

    var user = User()
    var httpClient = HTTPClient()
    
    private var inProgressIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signInButton.setTitle("", for: UIControlState.disabled)
        configureProgressIndicator()
    }
    
    @IBAction func SignSelected(_ sender: UIButton) {
        var errorMessaging = ""
        let login = (username: userNameTextField.text, password: passwordTextField.text, rememberMe: rememberMeSwitch.isOn)
        
        switch login {
        case ("", _, _):
            errorMessaging = "Empty Username"
            fallthrough
        case (_, "", _):
            errorMessaging = "\(errorMessaging) Empty Password"
            failedSignIn(failedError: errorMessaging)
        default:
            resetErrorMessage()
            addProgressIndicator(signInButton)
            
            
            if (Bundle.main.infoDictionary!["BYPASS_LOGIN"] as? Bool)! {
                let userLoginData = LoginRequest(email: login.username!, password: login.password!, rememberMe: login.rememberMe)
                
                httpClient.signIn(from: userLoginData.url, with: userLoginData){ [unowned self] (result) -> Void in
                    switch result {
                    case let .success(returnedValue):
                        self.removeProgressIndicator(self.signInButton)
                        print(returnedValue)
                        DispatchQueue.main.async {
                            self.performSegue(withIdentifier: "Show Index Screen", sender: nil)
                        }
                    case let .failure(errorValue):
                        self.removeProgressIndicator(self.signInButton)
                        print(errorValue)
                    }
                }
            } else {
                performSegue(withIdentifier: "Show Index Screen", sender: nil)
            }
            
            
        }
    }
    
    func configureProgressIndicator(){
        inProgressIndicator.color = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        inProgressIndicator.backgroundColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
        inProgressIndicator.startAnimating()
    }
    
    func addProgressIndicator(_ parent: UIButton){
        parent.addSubview(inProgressIndicator)
        inProgressIndicator.center = parent.convert(parent.center, from: parent.superview)
        inProgressIndicator.isHidden = false
        parent.isEnabled = false
    }
    
    func removeProgressIndicator(_ parent: UIButton) {
        self.inProgressIndicator.removeFromSuperview()
        parent.isEnabled = true
    }
    
    func failedSignIn(failedError message: String){
        self.errorLabel.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        self.errorLabel.text = message
    }
    
    func resetErrorMessage() {
        self.errorLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        self.errorLabel.text = ""
    }
}

