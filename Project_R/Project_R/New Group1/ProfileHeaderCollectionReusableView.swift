//
//  ProfileHeaderCollectionReusableView.swift
//  Blocstagram
//
//  Created by Dulio Denis on 1/31/17.
//  Copyright © 2017 ddApps. All rights reserved.
//

import UIKit

protocol ProfileHeaderCollectionReusableViewDelegate {
    
    func upload()
    func editname()
}

protocol HeaderProfileCollectionReusableViewDelegate {
    func updateFollowButton(forUser user: Users)
}


class ProfileHeaderCollectionReusableView: UICollectionReusableView {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var postCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    @IBOutlet weak var addText: UILabel!
    
    var delegate : ProfileHeaderCollectionReusableViewDelegate?
    var delegate2: HeaderProfileCollectionReusableViewDelegate?
    
    var user: Users? {
        didSet {
            updateView()
        }
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVc = segue.destination as! TextScroll
    
        destinationVc.transferImg = profileImageView.image
        print("Get profile image",destinationVc.transferImg)
    }
    
    

    func updateView() {
       
        
        //Saved user name and profile image in pref - retrive to comment view//
        self.nameLabel.text = user?.username
        PrefsManager.sharedinstance.username = nameLabel.text!
        if let photoURL = user?.profileImageURL {
            self.profileImageView.sd_setImage(with: URL(string: photoURL))
        PrefsManager.sharedinstance.imageURL = photoURL
        }
        
        API.Follow.fetchCountFollowing(userId: user!.id!) { (count) in
            
            if self.followingCountLabel.text != nil {
            self.followingCountLabel.text = "\(count)"
                print("followingcountlabel::::\(self.followingCountLabel)")
                
            }
        }
        
        API.Follow.fetchCountFollowers(userId: API.User.CURRENT_USER!.uid) { (count) in

            if self.followersCountLabel.text != nil {
                self.followersCountLabel.text = "\(count)"
                print("followersCountLabel::::\(self.followersCountLabel)")
                
            }
        }
        
        API.Post.fetchCountuserPost(withID: API.User.CURRENT_USER!.uid) { (count) in
 
            if self.postCountLabel.text != nil {
                
                self.postCountLabel.text = "\(count)"
                print("postcountLabel::::\(self.postCountLabel)")
            }
        }
        
        profileImageView.layer.cornerRadius = 12
        profileImageView.clipsToBounds = true
//        profileImageView.layer.borderWidth = 2
        
        
     
    }
    
   
    
    @IBAction func ButtonProfile(_ sender: UIButton) {
        
        delegate?.upload()
    }
    
    
    @IBAction func ButtonEditName(_ sender: UIButton) {
        
        delegate?.editname()
    }
    
    
}
