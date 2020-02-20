//
//  PendingNotifications.swift
//  LocalNotificationsLab
//
//  Created by Eric Davenport on 2/20/20.
//  Copyright © 2020 Eric Davenport. All rights reserved.
//

import Foundation
import UserNotifications

class PendingNotifications {
  public func getPendingNotifications(completion: @escaping ([UNNotificationRequest]) -> ()) {
    UNUserNotificationCenter.current().getPendingNotificationRequests { (request) in
      print("There are \(request.count) pending requst")
      completion(request)
    }
  }
}
