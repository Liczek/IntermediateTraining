//
//  CreateCompanyController.swift
//  IntermediateTrainingCoreData
//
//  Created by Paweł Liczmański on 16.08.2018.
//  Copyright © 2018 Paweł Liczmański. All rights reserved.
//

import UIKit
import CoreData

protocol CreateCompanyControllerDelegate {
	func addCompany(company: Company)
}

class CreateCompanyController: UIViewController {
	
	var delegate: CreateCompanyControllerDelegate?
	
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
		
		addObjects()
		setConstraints()
	}
	
	@objc func cancelButtonHandle() {
		dismiss(animated: true, completion: nil)
	}
	
	@objc func handleSave() {
		
		print("test Save")
		
		let persistantContainer = NSPersistentContainer(name: "IntermediateTrainingCoreData")
		
		persistantContainer.loadPersistentStores { (storeDescription, error) in
			if let error = error {
				print("Faild to load Persistans Store", error)
				fatalError()
			}
		}
		let context = persistantContainer.viewContext
		
		let company = NSEntityDescription.insertNewObject(forEntityName: "Company", into: context)
		
		company.setValue(nameTextField.text, forKey: "name")
		
		do {
			try context.save()
		} catch let saveError {
			print("Faild to save context", saveError)
		}
		
		
		
//		guard let companyName = nameTextField.text else { return }
//		let company = Company(name: companyName, founded: Date())
//		delegate?.addCompany(company: company)
	}
	
	func addObjects() {
		
		navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonHandle))
		
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
		
		view.addSubview(lightBlueBackgroudView)
		view.addSubview(nameLabel)
		view.addSubview(nameTextField)
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
