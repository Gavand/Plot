//
//  LoginViewController.swift
//  Plot
//
//  Created by Gavin Andrews on 2/1/21.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import JGProgressHUD

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        emailTextField.backgroundColor = UIColor.clear
        emailTextField.attributedPlaceholder = NSAttributedString(string: emailTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: (255/255), green: (255/255), blue: (255/255), alpha: 1)])
        let bottomLayerEmail = CALayer()
        bottomLayerEmail.frame = CGRect(x: 0, y: 29, width: 388, height: 0.6)
        bottomLayerEmail.backgroundColor = UIColor(red: (255/255), green: (255/255), blue: (255/255), alpha: 1).cgColor
        emailTextField.layer.addSublayer(bottomLayerEmail)
        
        passwordTextField.backgroundColor = UIColor.clear
        passwordTextField.attributedPlaceholder = NSAttributedString(string: passwordTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: (255/255), green: (255/255), blue: (255/255), alpha: 1)])
        let bottomLayerPassword = CALayer()
        bottomLayerPassword.frame = CGRect(x: 0, y: 29, width: 388, height: 0.6)
        bottomLayerPassword.backgroundColor = UIColor(red: (255/255), green: (255/255), blue: (255/255), alpha: 1).cgColor
        passwordTextField.layer.addSublayer(bottomLayerPassword)
        
        loginButton.layer.cornerRadius = 10
        loginButton.clipsToBounds = true
        
        handleTextField()
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       view.endEditing(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil {
            self.performSegue(withIdentifier: "loginToTabbarVC", sender: nil)   
            
        }
    }
    
    func handleTextField() {
        emailTextField.addTarget(self, action: #selector(LoginViewController.textFieldDidChange), for: UIControl.Event.editingChanged)
        passwordTextField.addTarget(self, action: #selector(LoginViewController.textFieldDidChange), for: UIControl.Event.editingChanged)
        }
    
    @objc func textFieldDidChange() {
            guard let email = emailTextField.text, !email.isEmpty,
                let password = passwordTextField.text, !password.isEmpty else {
                loginButton.setTitleColor(UIColor.lightText, for: UIControl.State.normal)
                loginButton.isEnabled = false
                return
        }
        loginButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        loginButton.isEnabled = true
    }
    
    
    @IBAction func loginButton_TouchUpInside(_ sender: Any) {
        view.endEditing(true)
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Waiting..."
        hud.show(in: self.view)
        hud.dismiss(afterDelay: 3.0)
        AuthService.signIn(email: emailTextField.text!, password: passwordTextField.text!, onSuccess: {
            hud.textLabel.text = "Success"
            hud.indicatorView = JGProgressHUDSuccessIndicatorView()
            hud.show(in: self.view)
            hud.dismiss(afterDelay: 3.0)
            self.performSegue(withIdentifier: "loginToTabbarVC", sender: nil)
            
        }, onError: { error in
            hud.textLabel.text = error
            hud.indicatorView = JGProgressHUDErrorIndicatorView()
            hud.show(in: self.view)
            hud.dismiss(afterDelay: 3.0)
        })
    }


}
