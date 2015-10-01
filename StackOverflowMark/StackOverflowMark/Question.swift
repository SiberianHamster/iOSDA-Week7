//
//  Question.swift
//  StackOverflow
//
//  Created by Mark Lin on 9/30/15.
//  Copyright © 2015 Mark Lin. All rights reserved.
//

import UIKit

class Question: NSObject {
  
  var title:NSString
  var avatarURL:NSString
  var profileImage:UIImage?
  var displayName:NSString
  
  init(title:NSString, avatarURL:NSString, displayName:NSString) {
    self.title = title
    self.avatarURL = avatarURL
    self.displayName = displayName
  }
}
