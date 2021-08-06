//
//  HeaderProfileView.swift
//  Supermomes
//
//  Created by Dinh Le on 8/6/21.
//

import UIKit

class HeaderProfileView: UIView {
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var avatarView: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameUserLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var followingsLabel: UILabel!
    @IBOutlet weak var reposLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    
    static let shared = UINib(nibName: "HeaderProfileView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! HeaderProfileView
    
    
    func setupUI(){
        avatarView.roundCorners(cornerRadius: 75)
        avatarImageView.roundCorners(cornerRadius: 65)
        avatarImageView.border(color: .black, borderWidth: 0.5)
    }
    
    var user:UserResponse? {
        didSet {
            guard let user = self.user else {return}
            backgroundImageView.setImage(user.avatarURL)
            avatarImageView.setImage(user.avatarURL)
            nameUserLabel.text = user.name
            locationLabel.text = user.location
            followersLabel.text = "\(user.followers ?? 0)"
            followingsLabel.text = "\(user.following ?? 0)"
            reposLabel.text = "\(user.publicRepos ?? 0)"
            bioLabel.text = user.bio
        }
    }
}
