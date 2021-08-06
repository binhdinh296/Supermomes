//
//  UIView+Ext.swift
//  Supermomes
//
//  Created by Mintpot on 8/6/21.
//

import UIKit
import Nuke

extension UIImageView {
  func setImage(_ urlString: String?, showLoading: Bool = false, placeholder: UIImage? = nil) {
        self.contentMode = .scaleAspectFill
        Nuke.cancelRequest(for: self)
        guard let urlString = urlString, let url = urlString.toURL else {
          image = placeholder
          return
        }
        if showLoading {
          showSimpleLoading()
        }
        Nuke.loadImage(with: url, options: .init(placeholder: placeholder), into: self, progress: nil) { [weak self] (result) in
          DispatchQueue.main.async {
            if showLoading {
              self?.hideSimpleIndicator()
            }
          }
        }
  }
}

extension String {
    var toURL: URL? {
      return URL(string: self.addedPercentEncoding)
    }
    var addedPercentEncoding: String {
      return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? self
    }
}

extension UIView {
    
    func roundCorners(cornerRadius: Double) {
        self.layer.cornerRadius = CGFloat(cornerRadius)
        self.clipsToBounds = true
    }
    
    func border(color: UIColor?, borderWidth: CGFloat) {
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = color?.cgColor
    }
    
    static let loadingViewTag = 123456
    func showSimpleLoading() {
      var loading = viewWithTag(UIView.loadingViewTag) as? UIActivityIndicatorView
      if loading == nil {
        if #available(iOS 13.0, *) {
            loading = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        } else {
            loading?.color = UIColor.darkGray
        }
      }
      loading?.translatesAutoresizingMaskIntoConstraints = false
      loading?.startAnimating()
      loading?.hidesWhenStopped = true
      loading?.tag = UIView.loadingViewTag
      addSubview(loading!)
      loading?.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
      loading?.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    func hideSimpleIndicator() {
      let loading = viewWithTag(UIView.loadingViewTag) as? UIActivityIndicatorView
      loading?.stopAnimating()
      loading?.removeFromSuperview()
    }
}
