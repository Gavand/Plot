//
//  HomeViewController.swift
//  Plot
//
//  Created by Gavin Andrews on 12/23/20.
//

import SwiftUI
import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import SideMenu

class HomeViewController:
    UIViewController, UITextViewDelegate, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var rectangle: UIImageView!
    
    @IBOutlet weak var meImage: UIImageView!
    @IBOutlet weak var statusTextView: UITextView!
    @IBOutlet weak var postButton: UIButton!
    
    var placeholderLabel : UILabel!
    var menu: SideMenuNavigationController?
    
    var databaseRef = Database.database().reference()
    var loggedInUser = User?
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        self.loggedInUser = Auth.auth()?.currentUser
        
        menu = SideMenuNavigationController(rootViewController: UIViewController())
        menu?.leftSide = true

        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        
        
        rectangle.clipsToBounds = false
        rectangle.layer.shadowColor = UIColor.black.cgColor
        rectangle.layer.shadowOffset = CGSize(width: 5,height: 5)
        rectangle.layer.shadowOpacity = 0.5     
        
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.isTranslucent = true
        
//        statusTextView.becomeFirstResponder()

        statusTextView.delegate = self
        placeholderLabel = UILabel()
        placeholderLabel.text = "What's on your mind?"
        placeholderLabel.font = UIFont.italicSystemFont(ofSize: (statusTextView.font?.pointSize)!)
        placeholderLabel.sizeToFit()
        statusTextView.addSubview(placeholderLabel)
        placeholderLabel.frame.origin = CGPoint(x: 5, y: (statusTextView.font?.pointSize)! / 2)
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.isHidden = !statusTextView.text.isEmpty
        
        postButton.layer.cornerRadius = 10
        postButton.clipsToBounds = true
    }
    
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: HomeViewTableViewCell = tableView.dequeueReusableCellWithIdentifier("HomeViewTableViewCell", forIndexPath: indexPath) as! HomeViewTableViewCell
        
        return cell
    }
    
    
    func textViewDidChange(_ statusTextView: UITextView) {
           placeholderLabel.isHidden = !statusTextView.text.isEmpty
       }
    
    override func touchesBegan(_ touhes: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func didTapMenu() {
        present(menu!, animated: true)
    }
    
    
//    @IBAction func logout_TouchUpInside(_ sender: Any) {
//        do {
//            try Auth.auth().signOut()
//        } catch let logoutError {
//            print(logoutError)
//        }
//        self.performSegue(withIdentifier: "homeToTabbarVC", sender: nil)
////        let storyboard = UIStoryboard(name: "Main", bundle: nil)
////        let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
////        self.present(loginVC, animated: true, completion: nil)
//    }
    
    class MenuListController: UITableViewController {
        
//        var items =
    }
}
