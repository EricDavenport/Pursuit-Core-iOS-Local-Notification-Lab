//
//  ViewController.swift
//  LocalNotificationsLab
//
//  Created by Eric Davenport on 2/20/20.
//  Copyright © 2020 Eric Davenport. All rights reserved.
//

import UIKit
import UserNotifications

class ManageTimersViewController: UIViewController {
  
  private var timerView = ManageTimesView()
  
  private var timers = [UNNotificationRequest]() {
    didSet {
      DispatchQueue.main.async {
        self.timerView.tableView.reloadData()
      }
    }
  }
  
  private var center = UNUserNotificationCenter.current()
  
  private var pendingNotifications = PendingNotifications()
  
  private var refreshControl: UIRefreshControl!
  
  private lazy var barButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(segue))
  
  override func loadView() {
    view = timerView
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Timers"
    navigationItem.rightBarButtonItem = barButton
    timerView.tableView.dataSource = self
    timerView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "timerCell")
    checkForAuthorization()
    loadNotifications()
    configureRefreshControl()
  }
  
  private func configureRefreshControl() {
   refreshControl = UIRefreshControl()
    timerView.tableView.refreshControl = refreshControl
    refreshControl.addTarget(self, action: #selector(loadNotifications), for: .valueChanged)
  }
  
  private func checkForAuthorization() {
    center.getNotificationSettings { (settings) in
      if settings.authorizationStatus == .authorized {
        print("Authorized")
      } else {
        self.requestNotificationPermission()
      }
    }
  }
  
  private func requestNotificationPermission() {
    center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
      if let error = error {
        print("error \(error)")
        return
      }
      if granted {
        print("Access Granted")
      } else {
        print("Access denied")
      }
    }
  }
  
  @objc private func loadNotifications() {
    pendingNotifications.getPendingNotifications { (request) in
      self.timers = request
      DispatchQueue.main.async {
        self.refreshControl.endRefreshing()
      }
    }
  }
  
  @objc private func segue() {
    self.present(CreateTimerViewController(), animated: true)
    print("segue")
  }



}

extension ManageTimersViewController : UITableViewDataSource {
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "timerCell", for: indexPath)
    let notification = timers[indexPath.row]
    
    cell.textLabel?.text = "\(notification.content.title)"
    cell.detailTextLabel?.text = "detail"
    cell.imageView?.image = UIImage(systemName: "photo.fill")
    return cell
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return timers.count
  }
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      removeTimer(atIndexPath: indexPath)
    }
  }
  
  private func removeTimer(atIndexPath indexPath: IndexPath) {
    let notification = timers[indexPath.row]
    let identifier = notification.identifier
    
    center.removePendingNotificationRequests(withIdentifiers: [identifier])
    timers.remove(at: indexPath.row)
    timerView.tableView.deleteRows(at: [indexPath], with: .fade)
    print("to be deleted")
  }
}

extension ManageTimersViewController : UNUserNotificationCenterDelegate {
  func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    completionHandler(.alert)
  }
}


