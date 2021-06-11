//
//  AuthService.swift
//  Plot
//
//  Created by Gavin Andrews on 2/19/21.
//

import Foundation
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class AuthService {
    
    static func signIn(email: String, password: String, onSuccess: @escaping () -> Void, onError:  @escaping (_ errorMessage: String?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            onSuccess()
        })
        
    }
    static func signUp(username: String, email: String, password: String, dataImage: Data, onSuccess: @escaping ()->Void, onError: @escaping (_ errorMessage: String?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            let uid = Auth.auth().currentUser!.uid
            let storageRef = Storage.storage().reference(forURL: Configure.STORAGE_ROOF_REF).child("profile_Image").child(uid)
            
            storageRef.putData(dataImage, metadata: nil, completion: { (metadata, error) in
                if error != nil {
                    return
                } else {
                    storageRef.downloadURL(completion: { (url, error) in
                        if error != nil {
                            print(error!)
                            return
                        }
                        if url != nil {
                            setUserInformation(profileImageUrl: url!.absoluteString, username: username, email: email, uid: uid, onSuccess: onSuccess)
                        }
                        
                    })
                }
                // ...
            })
        })
        
    }
//    static func signUp(username: String, email: String, password: String, dataImage: Data, onSuccess: @escaping () -> Void, onError:  @escaping (_ errorMessage: String?) -> Void) {
//        Auth.auth().createUser(withEmail: email, password: password, completion: { (authData, error) in
//            if error != nil {
//                onError(error!.localizedDescription)
//                return
//            }
//            let uid = authData!.user.uid
//            let storageRef = Storage.storage().reference(forURL: Configure.STORAGE_ROOF_REF).child("profile_image").child(uid)
//
//            storageRef.put(dataImage, metadata: nil, completion: { (metadata, error) in
//                if error != nil {
//                    return
//                }
//                let profileImageUrl = metadata?.downloadURL()?.absoluteString
//
//                self.setUserInfomation(profileImageUrl: profileImageUrl!, username: username, email: email, uid: uid!, onSuccess: onSuccess)
//            })
//        })
//
//    }
    
    static func setUserInformation(profileImageUrl: String, username: String, email: String, uid: String, onSuccess: @escaping () -> Void) {
        let ref = Database.database().reference()
        let usersReference = ref.child("users")
        let newUserReference = usersReference.child(uid)
        newUserReference.setValue(["username": username, "email": email, "profileImageUrl": profileImageUrl])
        onSuccess()
    }
}
