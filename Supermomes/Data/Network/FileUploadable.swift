//
//  FileUploadable.swift
//
//  Created by Dinh Le on 8/6/21..
//

import Foundation

protocol FileUploadable {}

extension Data: FileUploadable {
  
}

extension URL: FileUploadable {
  
}
