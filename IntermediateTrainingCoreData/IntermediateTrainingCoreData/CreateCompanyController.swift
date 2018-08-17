//
//  CreateCompanyController.swift
//  IntermediateTrainingCoreData
//
//  Created by Paweł Liczmański on 16.08.2018.
//  Copyright © 2018 Paweł Liczmański. All rights reserved.
//

import UIKit

class CreateCompanyController: UIViewController {
	
	let lightBlueBackgroudView: UIView = {
		let view = UIView()
		view.backgroundColor = .lightBlue
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	let nameLabel: UILabel = {
		let label = UILabel()
		label.text = "Name"
		label.font = UIFont.boldSystemFont(ofSize: 16)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	let nameTextField: UITextField = {
		let textField = UITextField()
		textField.placeholder = "Enter name of company"
		textField.font = UIFont.boldSystemFont(ofSize: 16)
		textField.translatesAutoresizingMaskIntoConstraints = false
		return textField
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .darkBlue
		title = "Create Company"
		let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonHandle))
		navigationItem.setLeftBarButton(cancelButton, animated: true)
		
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
		
		view.addSubview(lightBlueBackgroudView)
		view.addSubview(nameLabel)
		view.addSubview(nameTextField)
		setConstraints()
	}
	
	@objc func cancelButtonHandle() {
		dismiss(animated: true, completion: nil)
	}
	
	@objc func handleSave() {
		print("Save new company")
	}
	
	func setConstraints() {
		
		let lightBlueBGViewConstraints = [
			lightBlueBackgroudView.leftAnchor.constraint(equalTo: view.leftAnchor),
			lightBlueBackgroudView.rightAnchor.constraint(equalTo: view.rightAnchor),
			lightBlueBackgroudView.topAnchor.constraint(equalTo: view.topAnchor),
			lightBlueBackgroudView.heightAnchor.constraint(equalToConstant: 50)
		]
		lightBlueBGViewConstraints.forEach { (constraint) in
			constraint.isActive = true
		}
		
		
		let nameLabelConstraints = [
		nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
		nameLabel.widthAnchor.constraint(equalToConstant: 100),
		nameLabel.topAnchor.constraint(equalTo: view.topAnchor),
		nameLabel.heightAnchor.constraint(equalToConstant: 50)
		]
		nameLabelConstraints.forEach { (constraint) in
			constraint.isActive = true
		}

		let nameTextFieldConstraints = [
			nameTextField.leftAnchor.constraint(equalTo: nameLabel.rightAnchor),
			nameTextField.topAnchor.constraint(equalTo: nameLabel.topAnchor),
			nameTextField.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor),
			nameTextField.rightAnchor.constraint(equalTo: view.rightAnchor)
		]
		nameTextFieldConstraints.forEach { (constraint) in
			constraint.isActive = true
		}
		
	}
	
	
	
	
	
	
	
	
	
	
	
}
