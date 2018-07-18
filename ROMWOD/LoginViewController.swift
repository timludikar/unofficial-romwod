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
    
    var user = User()
    
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
            let userLoginData = Login(email: login.username!, password: login.password!, rememberMe: login.rememberMe)
            loginRequest(userLoginData: userLoginData)
            
            self.user = User.createProfile(userNameFromSignin: login.username!, passwordFromSignin: login.password!)
        }
    }
    
    func loginRequest(userLoginData uploadData: Login){
        let url = URL(string: "https://app.romwod.com/api/v1/auth/sign_in")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let requestData = try? JSONEncoder().encode(uploadData)
        let task = URLSession.shared.uploadTask(with: request, from: requestData) { data, response, error in
            if let error = error {
                print ("error: \(error)")
                return
            }
            guard let response = response as? HTTPURLResponse,
                (200...299).contains(response.statusCode) else {
                    print ("server error")
                    return
            }

            if let mimeType = response.mimeType,
                mimeType == "application/json",
                let data = data
                {
                    guard let result = try? JSONDecoder().decode(Profile.self, from: data) else { return }
                    print(result)
                }
        }
        task.resume()
        
    }
    
    func failedSignIn(failedError message: String){
        errorLabel.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        errorLabel.text = message
    }
    
    func resetErrorMessage() {
        errorLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        errorLabel.text = ""
    }
    
}
