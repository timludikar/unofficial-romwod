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
    
    private lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.waitsForConnectivity = true
        return URLSession(configuration: configuration,
                          delegate: self, delegateQueue: nil)
    }()
    
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
        }
    }
    
    
    func loginRequest(userLoginData uploadData: Login){
        let url = URL(string: "https://app.romwod.com/api/v1/auth/sign_in")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let requestData = try? JSONEncoder().encode(uploadData)
        let task = session.uploadTask(with: request, from: requestData!)
        task.resume()
        
    }
    
    func failedSignIn(failedError message: String){
        DispatchQueue.main.async {
            self.errorLabel.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            self.errorLabel.text = message
        }
    }
    
    func resetErrorMessage() {
        DispatchQueue.main.async {
            self.errorLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            self.errorLabel.text = ""
        }
    }
}

extension LoginViewController: URLSessionDataDelegate {
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        guard let response = response as? HTTPURLResponse else {
            self.failedSignIn(failedError: "Server Error")
            completionHandler(URLSession.ResponseDisposition.cancel)
            return
        }
        
        switch (response.statusCode, response.mimeType) {
        case (200...299, "application/json"):
            completionHandler(URLSession.ResponseDisposition.allow)
        default:
            self.failedSignIn(failedError: "Failed Authenication")
            completionHandler(URLSession.ResponseDisposition.cancel)
        }
    }
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        guard let result = try? JSONDecoder().decode(Profile.self, from: data) else { return }
        self.user.profile = result
        print(result)
    }
}
