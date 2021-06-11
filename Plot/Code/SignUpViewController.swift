//
//  SignUpViewController.swift
//  Plot
//
//  Created by Gavin Andrews on 2/2/21.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import JGProgressHUD

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var meImage: UIImageView!
    
    var pickedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        meImage.layer.cornerRadius = 60.5
        meImage.clipsToBounds = true
        
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleSelectMeImageView))
//        meImage.addGestureRecognizer(tapGesture)
//        meImage.isUserInteractionEnabled = true
//        signUpButton.isEnabled = false
        
        usernameTextField.backgroundColor = UIColor.clear
        usernameTextField.attributedPlaceholder = NSAttributedString(string: usernameTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: (255/255), green: (255/255), blue: (255/255), alpha: 1)])
        let bottomLayerUsername = CALayer()
        bottomLayerUsername.frame = CGRect(x: 0, y: 29, width: 388, height: 0.6)
        bottomLayerUsername.backgroundColor = UIColor(red: (255/255), green: (255/255), blue: (255/255), alpha: 1).cgColor
        usernameTextField.layer.addSublayer(bottomLayerUsername)
        
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
        
        signUpButton.layer.cornerRadius = 10
        signUpButton.clipsToBounds = true
        
        meImage.layer.cornerRadius = 80
        meImage.clipsToBounds = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleSelectMeImageView))
        meImage.addGestureRecognizer(tapGesture)
        meImage.isUserInteractionEnabled = true
        signUpButton.isEnabled = false
        
        handleTextField()

        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touhes: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func handleTextField() {
        usernameTextField.addTarget(self, action: #selector(SignUpViewController.textFieldDidChange), for: UIControl.Event.editingChanged)
        emailTextField.addTarget(self, action: #selector(SignUpViewController.textFieldDidChange), for: UIControl.Event.editingChanged)
        passwordTextField.addTarget(self, action: #selector(SignUpViewController.textFieldDidChange), for: UIControl.Event.editingChanged)
    }
    
    @objc func handleSelectMeImageView() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        present(pickerController, animated: true, completion: nil)
    }
    
    @objc func textFieldDidChange() {
        guard let username = usernameTextField.text, !username.isEmpty, let email = emailTextField.text, !email.isEmpty,
            let password = passwordTextField.text, !password.isEmpty else {
                signUpButton.setTitleColor(UIColor.lightText, for: UIControl.State.normal)
                
                return
        }
        signUpButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        signUpButton.isEnabled = true
        
    }
    
    @IBAction func dismiss_onClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signupButton_TouchUpInside(_ sender: Any) {
        view.endEditing(true)
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Waiting..."
        hud.show(in: self.view)
        hud.dismiss(afterDelay: 3.0)
        if let profileImage = self.pickedImage, let dataImage = profileImage.jpegData(compressionQuality: 0.1) {
            AuthService.signUp(username: usernameTextField.text!, email: emailTextField.text!, password: passwordTextField.text!, dataImage: dataImage, onSuccess: {
                hud.textLabel.text = "Success"
                hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                hud.show(in: self.view)
                hud.dismiss(afterDelay: 3.0)
                self.performSegue(withIdentifier: "signUpToTabbarVC", sender: nil)
            }, onError: { (errorString) in
                hud.textLabel.text = errorString
                hud.indicatorView = JGProgressHUDErrorIndicatorView()
                hud.show (in: self.view)
                hud.dismiss(afterDelay: 3.0)
            })
        } else {
            hud.textLabel.text = "Profile image can't be empty"
            hud.indicatorView = JGProgressHUDErrorIndicatorView()
            hud.show(in: self.view)
            hud.dismiss(afterDelay: 3.0)
            
        
//            let ref = Database.database().reference()
//            let userRef = ref.child("users")
////            print(userRef.description())
//            let uid = user?.uid
//            let newUserRef = userRef.child(uid)
        }
    }
    
}

extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("Finished")
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerOriginalImage")] as? UIImage {
            pickedImage = image
            meImage.image = image
        }
        dismiss(animated: true, completion: nil)
    }
}
