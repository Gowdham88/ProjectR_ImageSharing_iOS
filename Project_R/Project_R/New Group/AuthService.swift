//
//  AuthService.swift
//  Blocstagram
//
//  Created by ddenis on 1/10/17.
//  Copyright © 2017 ddApps. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import Firebase


class AuthService {
    
//    static func signIn(email: String, password: String, onSuccess: @escaping () -> Void, onError: @escaping (_ errorMessage: String?) -> Void) {
//        // Use Firebase Authentication with email and password
//        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
//            if error != nil {
//                onError("Authentication Error: \(error!.localizedDescription)")
//                return
//            }
//            onSuccess()
//        })
//    }
    
    
//    static func signUp(username: String, email: String, password: String, imageData: Data, onSuccess: @escaping () -> Void, onError: @escaping (_ errorMessage: String?) -> Void) {
//        // create a Firebase user
//        Auth.auth().createUser(withEmail: email, password: password, completion :{ user,error in
//            if error != nil {
//                onError("Create User Error: \(error!.localizedDescription)")
//                return
//            }
//
//            let uid = user?.uid
//
//            // get a reference to our file store
//            let storeRef = Storage.storage().reference(forURL: Constants.fileStoreURL).child("profile_image").child(uid!)
//
//            storeRef.putData(imageData, metadata: nil, completion: { (metaData, error) in
//                if error != nil {
//                    print("Profile Image Error: \(String(describing: error?.localizedDescription))")
//                    return
//                }
//                // if there's no error
//                // get the URL of the profile image in the file store
//                let profileImageURL = metaData?.downloadURL()?.absoluteString
//
//                // set the user information with the profile image URL
//                self.setUserInformation(profileImageURL: profileImageURL!, username: username, email: email, uid: uid!, onSuccess: onSuccess)
//            })
//
//        })
//    }
//
    
    static func signOut(onSuccess: @escaping () -> Void, onError: @escaping (_ errorMessage: String?) -> Void) {
        // Log out user from Firebase
        do {
            try Auth.auth().signOut()
            onSuccess()
        } catch let signOutError {
            onError(signOutError.localizedDescription)
        }
    }
    
    
    // MARK: - Firebase Saving Methods
    
//    static func setUserInformation(profileImageURL: String, username: String, email: String, uid: String) {
//        // create the new user in the user node and store username, email, and profile image URL
//        let db = Firestore.firestore()
//        db.collection("users").document(uid).setData([
//            "username": username,
//            "email":email,
//            "profileImageURL": profileImageURL
//        ]) { err in
//            if let err = err {
//                print("Error writing document: \(err)")
//            } else {
//                print("Document successfully written!")
//                PrefsManager.sharedinstance.UIDfirebase = uid
//                PrefsManager.sharedinstance.username  = username
//                PrefsManager.sharedinstance.userEmail = email
//                PrefsManager.sharedinstance.imageURL  = profileImageURL
//                ProgressHUD.dismiss()
//            }
//        }
//
//
////        onSuccess()
//    }
    
}
