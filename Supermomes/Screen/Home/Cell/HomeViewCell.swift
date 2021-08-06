//
//  HomeViewCell.swift
//  Supermomes
//
//  Created by Mintpot on 8/6/21.
//

import UIKit

class HomeViewCell: UITableViewCell {
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        avatarImageView.roundCorners(cornerRadius: 25)
    }

    var user:UserResponse? {
        didSet{
            guard let user = self.user else {return}
            avatarImageView.setImage(user.avatarURL,placeholder: UIImage.init(named: "avatar_place_holder"))
            nameLabel.text = user.login?.capitalized
            urlLabel.text = user.url
        }
    }
}
