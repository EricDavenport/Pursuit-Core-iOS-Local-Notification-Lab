//
//  CreateTimerViewController.swift
//  LocalNotificationsLab
//
//  Created by Eric Davenport on 2/20/20.
//  Copyright © 2020 Eric Davenport. All rights reserved.
//

import UIKit

class CreateTimerViewController: UIViewController {
  
  private var createView = CreateTimerView()
  
  private var timeInterval : TimeInterval = Date().timeIntervalSinceNow + 10 // 10 sec from now

  override func loadView() {
    view = createView
    view.backgroundColor = .systemGroupedBackground
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    buttonSetup()
    
  }
  
  private func buttonSetup() {
    createView.launchButton.addTarget(self, action: #selector(createTimer), for: .touchUpInside)
    createView.datePicker.addTarget(self, action: #selector(datePickerChanged(_:)), for: .allTouchEvents)
  }
  
  @objc private func datePickerChanged(_ sender: UIDatePicker) {
    guard sender.date > Date() else { return }
    timeInterval = sender.date.timeIntervalSinceNow
    print(timeInterval)
  }
  
  @objc private func createTimer() {
    print("create")
    let content = UNMutableNotificationContent()
    content.title = createView.titleField.text ?? "No title"
    content.body = "Body"
    content.subtitle = "Subtitle"
    content.sound = .default
    
    let identifier = UUID().uuidString
    
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
    
    let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
    
    UNUserNotificationCenter.current().add(request) { (error) in
      if let error = error {
        print("error: \(error)")
      } else {
        print("Successfully added")
      }
    }
    dismiss(animated: true)
  }
  
  
}
