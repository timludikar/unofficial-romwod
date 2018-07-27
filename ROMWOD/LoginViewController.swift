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
    private var inProgressIndicator = UIActivityIndicatorView()

    private lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.waitsForConnectivity = true
        configuration.sharedContainerIdentifier = "romwod"
        return URLSession(configuration: configuration,
                          delegate: self, delegateQueue: nil)
    }()
    
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
            let url = URL(string: "https://app.romwod.com/api/v1/auth/sign_in")!
            let request = URLRequest(url: url)
            let userLoginData = Login(email: login.username!, password: login.password!, rememberMe: login.rememberMe)
            userLoginData.login(with: request) { results in
                switch results {
                case let .success(returnedValue):
                    print(returnedValue)
                case let .failure(errorValue):
                    print(errorValue)
                }
            }
            addProgressIndicator(signInButton)
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
        DispatchQueue.main.async {
            self.inProgressIndicator.removeFromSuperview()
            parent.isEnabled = true
        }
    }
    
    func loginRequest(userLoginData uploadData: Login){
        let url = URL(string: "https://app.romwod.com/api/v1/auth/sign_in")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("app.romwod.com", forHTTPHeaderField: "authority")
        request.setValue("https://app.romwod.com/users/sign_in", forHTTPHeaderField: "referer")
        request.setValue("https://app.romwod.com", forHTTPHeaderField: "origin")
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
        removeProgressIndicator(signInButton)
        guard let response = response as? HTTPURLResponse else {
            self.failedSignIn(failedError: "Server Error")
            completionHandler(URLSession.ResponseDisposition.cancel)
            return
        }
        
        switch (response.statusCode, response.mimeType) {
        case (401,"application/json"):
            
            completionHandler(URLSession.ResponseDisposition.cancel)
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
