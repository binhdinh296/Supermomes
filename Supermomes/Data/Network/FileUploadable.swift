//
//  FileUploadable.swift
//
//  Created by Mintpot on 12/3/20.
//

import Foundation

protocol FileUploadable {}

extension Data: FileUploadable {
  
}

extension URL: FileUploadable {
  
}
