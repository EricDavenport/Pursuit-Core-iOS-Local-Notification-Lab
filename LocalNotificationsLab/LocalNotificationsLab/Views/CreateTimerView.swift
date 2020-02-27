//
//  CreateTimerView.swift
//  LocalNotificationsLab
//
//  Created by Eric Davenport on 2/20/20.
//  Copyright © 2020 Eric Davenport. All rights reserved.
//

import UIKit

protocol createTimer : AnyObject {
  func didCreateTimer(_ createTimerViewController: CreateTimerViewController)
}

class CreateTimerView: UIView {
  
  lazy var delegate = createTimer.self
  
  // TODO : add stack view of imageViews to select image to associate with timer
  public lazy var stackView : UIStackView = {
    let stack = UIStackView()
    
    return stack
  }()
  
  public lazy var titleField : UITextField = {
    let textField = UITextField()
    textField.backgroundColor = .orange
    textField.placeholder = "Enter timer title"
    return textField
  }()
  
  public lazy var datePicker : UIDatePicker = {
    let datePicker = UIDatePicker()
    return datePicker
  }()
  
  public lazy var launchButton : UIButton = {
    let button = UIButton()
    button.titleLabel?.text = "Launch"
    button.backgroundColor = .systemOrange
    button.tintColor = .black
    button.layer.cornerRadius = button.bounds.size.width / 2.0
//    button.clipsToBounds = true
    return button
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
    textFieldContraints()
    datePickerConstraints()
    launchButtonConstraints()
  }
  
  private func textFieldContraints() {
    addSubview(titleField)
    titleField.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      titleField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
      titleField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
      titleField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
    ])
  }
  private func datePickerConstraints() {
    addSubview(datePicker)
    datePicker.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      datePicker.topAnchor.constraint(equalTo: titleField.bottomAnchor, constant: 20),
      datePicker.leadingAnchor.constraint(equalTo: leadingAnchor),
      datePicker.trailingAnchor.constraint(equalTo: trailingAnchor),
      datePicker.heightAnchor.constraint(equalToConstant: 450)
    ])
  }

  private func launchButtonConstraints() {
    addSubview(launchButton)
    launchButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      launchButton.heightAnchor.constraint(equalToConstant: 65),
      launchButton.widthAnchor.constraint(equalToConstant: 65),
      launchButton.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 20),
      launchButton.centerXAnchor.constraint(equalTo: centerXAnchor)
    ])
  }

}
