//
//  ViewController+Helpers.swift
//  IntermediateTrainingCoreData
//
//  Created by Paweł Liczmański on 04.09.2018.
//  Copyright © 2018 Paweł Liczmański. All rights reserved.
//

import UIKit

extension UIViewController {
	
	func setLeftDismissButton(title: String) {
		navigationItem.leftBarButtonItem = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(handleCancel))
	}
	
	@objc private func handleCancel() {
		dismiss(animated: true, completion: nil)
	}
	
	func setPlusButton(selector: Selector) {
		navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus"), style: .plain, target: self, action: selector)
	}
	
	func setLightBlueBackgroundView(height: CGFloat) -> UIView {
		let lightBlueBackgroundView: UIView = {
			let view = UIView()
			view.backgroundColor = .lightBlue
			view.translatesAutoresizingMaskIntoConstraints = false
			return view
		}()
		
		view.addSubview(lightBlueBackgroundView)
		
		lightBlueBackgroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		lightBlueBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		lightBlueBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
		lightBlueBackgroundView.heightAnchor.constraint(equalToConstant: height).isActive = true
		return lightBlueBackgroundView
	}
	
	func setNameLabel(placeholder: String, constants: CGFloat) -> UITextField {
		let nameLabel: UILabel = {
			let label = UILabel()
			label.text = "Name"
			label.font = UIFont.boldSystemFont(ofSize: 16)
			label.translatesAutoresizingMaskIntoConstraints = false
			return label
		}()
		
		let nameTextField: UITextField = {
			let textField = UITextField()
			textField.placeholder = placeholder
			textField.font = UIFont.boldSystemFont(ofSize: 16)
			textField.translatesAutoresizingMaskIntoConstraints = false
			return textField
		}()
		
		view.addSubview(nameLabel)
		view.addSubview(nameTextField)
		
		nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: constants).isActive = true
		nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
		nameLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
		nameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
		
		nameTextField.topAnchor.constraint(equalTo: nameLabel.topAnchor).isActive = true
		nameTextField.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
		nameTextField.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 16).isActive = true
		nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
		return nameTextField
	}
}
