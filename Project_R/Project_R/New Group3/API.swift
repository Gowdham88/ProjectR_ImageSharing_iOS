//
//  API.swift
//  Blocstagram
//
//  Created by ddenis on 1/24/17.
//  Copyright © 2017 ddApps. All rights reserved.
//

import Foundation

struct API {
    static var User = UserAPI()
    static var Post = PostAPI()
    static var Comment = CommentAPI()
    static var PostComment = PostCommentAPI()
    static var UserPost = UserPostAPI()
    static var Follow = FollowApi()
    static var Feed = FeedApi()
    static var MyPosts = MyPostsApi()
    static var MySaves = saveApi()
    static var MyActivity = activityApi()
    
}
