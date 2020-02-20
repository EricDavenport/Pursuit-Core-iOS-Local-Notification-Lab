//
//  ManageTimesView.swift
//  LocalNotificationsLab
//
//  Created by Eric Davenport on 2/20/20.
//  Copyright © 2020 Eric Davenport. All rights reserved.
//

import UIKit

class ManageTimesView: UIView {

  public lazy var tableView : UITableView = {
    let tableView = UITableView()
    tableView.backgroundColor = .purple
    return tableView
  }()

  override init(frame: CGRect) {
    super.init(frame: UIScreen.main.bounds)
    commonInit()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    commonInit()
  }
  
  private func commonInit() {
    tableViewConstraints()
  }

  private func tableViewConstraints() {
    addSubview(tableView)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
      tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
      tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
    ])
  }
  
  
}
