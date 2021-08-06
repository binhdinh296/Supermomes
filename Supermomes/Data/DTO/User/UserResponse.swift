//
//  UserResponse.swift
//  Supermomes
//
//  Created by Mintpot on 8/6/21.
//

import Foundation

class UserResponse: Codable {
    let login: String?
    let id: Int32
    let nodeID: String?
    let avatarURL: String?
    let gravatarID: String?
    let url, htmlURL, followersURL: String?
    let followingURL, gistsURL, starredURL: String?
    let subscriptionsURL, organizationsURL, reposURL: String?
    let eventsURL: String?
    let receivedEventsURL: String?
    let type: String?
    let siteAdmin: Bool
    let name: String?
    let company: String?
    let blog: String?
    let location, email: String?
    let bio: String?
    let twitterUsername: String?
    let publicRepos, publicGists, followers, following: Int32?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case login, id
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
        case gravatarID = "gravatar_id"
        case url
        case htmlURL = "html_url"
        case followersURL = "followers_url"
        case followingURL = "following_url"
        case gistsURL = "gists_url"
        case starredURL = "starred_url"
        case subscriptionsURL = "subscriptions_url"
        case organizationsURL = "organizations_url"
        case reposURL = "repos_url"
        case eventsURL = "events_url"
        case receivedEventsURL = "received_events_url"
        case type
        case siteAdmin = "site_admin"
        case name, company, blog, location, email, bio
        case twitterUsername = "twitter_username"
        case publicRepos = "public_repos"
        case publicGists = "public_gists"
        case followers, following
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    init(user:User){
        self.id = user.id
        self.login = user.login
        self.nodeID = user.node_id
        self.avatarURL = user.avatar_url
        self.gravatarID = user.gravatar_id
        self.url = user.url
        self.htmlURL = user.html_url
        self.followersURL = user.followers_url
        self.followingURL = user.following_url
        self.gistsURL = user.gists_url
        self.starredURL = user.starred_url
        self.subscriptionsURL = user.subscriptions_url
        self.organizationsURL = user.organizations_url
        self.reposURL = user.repos_url
        self.eventsURL = user.events_url
        self.receivedEventsURL = user.received_events_url
        self.type = user.type
        self.siteAdmin = user.site_admin
        self.name = user.name
        self.company = user.company
        self.blog = user.blog
        self.location = user.location
        self.email = user.email
        self.bio = user.bio
        self.twitterUsername  = user.twitter_username
        self.publicRepos = user.public_repos
        self.publicGists = user.public_gists
        self.followers = user.followers
        self.following = user.following
        self.createdAt = user.created_at
        self.updatedAt = user.updated_at
    }
}

extension User {
    func update(user:UserResponse){
        self.id = user.id
        self.login = user.login
        self.node_id = user.nodeID
        self.avatar_url = user.avatarURL
        self.gravatar_id = user.gravatarID
        self.url = user.url
        self.html_url = user.htmlURL
        self.following_url = user.followingURL
        self.following_url = user.followingURL
        self.gists_url = user.gistsURL
        self.starred_url = user.starredURL
        self.subscriptions_url = user.subscriptionsURL
        self.organizations_url = user.organizationsURL
        self.repos_url = user.reposURL
        self.events_url = user.eventsURL
        self.received_events_url = user.receivedEventsURL
        self.type = user.type
        self.site_admin = user.siteAdmin
        self.name = user.name
        self.company = user.company
        self.blog = user.blog
        self.location = user.location
        self.email = user.email
        self.bio = user.bio
        self.twitter_username  = user.twitterUsername
        self.public_repos = user.publicRepos ?? 0
        self.public_gists = user.publicGists ?? 0
        self.followers = user.followers ?? 0
        self.following = user.following ?? 0
        self.created_at = user.createdAt
        self.updated_at = user.updatedAt
    }
}
