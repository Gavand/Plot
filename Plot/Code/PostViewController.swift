//
//  PostViewController.swift
//  Plot
//
//  Created by Gavin Andrews on 2/11/21.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage

class PostViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var meImage: UIImageView!
    @IBOutlet weak var statusTextView: UITextView!
    @IBOutlet weak var emojiTextView: UILabel!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var postButton: UIBarButtonItem!
    var placeholderLabel : UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        statusTextView.becomeFirstResponder()

        statusTextView.delegate = self
        placeholderLabel = UILabel()
        placeholderLabel.text = "What's on your mind?"
        placeholderLabel.font = UIFont.italicSystemFont(ofSize: (statusTextView.font?.pointSize)!)
        placeholderLabel.sizeToFit()
        statusTextView.addSubview(placeholderLabel)
        placeholderLabel.frame.origin = CGPoint(x: 5, y: (statusTextView.font?.pointSize)! / 2)
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.isHidden = !statusTextView.text.isEmpty
 
        
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
    }
    
    func textViewDidChange(_ statusTextView: UITextView) {
           placeholderLabel.isHidden = !statusTextView.text.isEmpty
       }
    
    
//    func textViewDidBeginEditing(_ textView: UITextView) {
//        if statusTextView.textColor == UIColor.lightGray {
//            statusTextView.text = nil
//            statusTextView.textColor = UIColor.black
//        }
//    }
    
//    func textViewDidEndEditing(_ textView: UITextView) {
//        if statusTextView.text.isEmpty {
//            statusTextView.text = "What's on your mind?"
//            statusTextView.textColor = UIColor.lightGray
//        }
//    }
    
    
    @IBAction func dismiss_onClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func postButton_TouchUpInside(_ sender: Any) {
    }
    
}
