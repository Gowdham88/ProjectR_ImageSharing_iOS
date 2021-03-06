//
//  Post.swift
//  Blocstagram
//
//  Created by ddenis on 1/16/17.
//  Copyright © 2017 ddApps. All rights reserved.
//

import Foundation
import FirebaseAuth


class Post {
    var caption: String?
    var photoURL: String?
    var uid: String?
    var id: String?
    var likeCount: Int?
    var likes: Dictionary<String, Bool>?
    var isLiked: Bool?
    var userName : String?
    var profileImageURL : String?
    var postTime : Double?
    var documentID: String?
    var rating: String?
    var location: String?
    var productName: String?
    var productDetailPageURL: String?
    var token: String?
    var value: Bool?
}

extension Post {
    
    
    
    static func transformPost(postDictionary: [String: Any], key: String) -> Post {
        let post = Post()
        
        post.id = key
        post.caption = postDictionary["caption"] as? String
        post.photoURL = postDictionary["photoURL"] as? String
        post.uid = postDictionary["uid"] as? String
        post.likeCount = postDictionary["likeCount"] as? Int
        post.likes = postDictionary["likes"] as? Dictionary<String, Bool>
        post.userName = postDictionary["userName"] as? String
        post.profileImageURL = postDictionary["profileImageURL"] as? String
        post.postTime        = postDictionary["postTime"] as? Double
        post.documentID = postDictionary["documentID"] as? String
        post.rating = postDictionary["rating"] as? String
        post.location = postDictionary["location"] as? String
        post.productName = postDictionary["productName"] as? String
        post.productDetailPageURL = postDictionary["productDetailPageURL"] as? String
        post.token  = postDictionary["token"] as? String
        post.value = postDictionary["value"] as? Bool
        
        
        if let currentUserID = Auth.auth().currentUser?.uid {
            if post.likes != nil {
                post.isLiked = post.likes![currentUserID]
                
            }
        }
        
        return post
    }
    
}
