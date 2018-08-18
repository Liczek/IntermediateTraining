//
//  CreateCompanyController.swift
//  IntermediateTrainingCoreData
//
//  Created by Paweł Liczmański on 18.08.2018.
//  Copyright © 2018 Paweł Liczmański. All rights reserved.
//

import UIKit
import CoreData

protocol CreateCompanyControllerDelegate {
	func addCompany(company: Company)
	func didEditCompany(company: Company)
}

class CreateCompanyController: UIViewController {
	
	var company: Company? {
		didSet {
			nameTextField.text = company?.name
		}
	}
	
	var delegate: CreateCompanyControllerDelegate?
	
	let lightBlueBGview: UIView = {
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
		textField.placeholder = "Enter new company name"
		textField.font = UIFont.boldSystemFont(ofSize: 16)
		textField.translatesAutoresizingMaskIntoConstraints = false
		return textField
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = "Create Company"
		
		view.backgroundColor = .darkBlue
		addObjectsAndSetConstraints()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		title = company == nil ? "Create Company" : "Edit Company"
	}
	
	func addObjectsAndSetConstraints() {
		
		view.addSubview(lightBlueBGview)
		let lightBlueBGViewConstraints = [
			lightBlueBGview.topAnchor.constraint(equalTo: view.topAnchor),
			lightBlueBGview.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			lightBlueBGview.leftAnchor.constraint(equalTo: view.leftAnchor),
			lightBlueBGview.rightAnchor.constraint(equalTo: view.rightAnchor)
		]
		lightBlueBGViewConstraints.forEach { (constraint) in
			constraint.isActive = true
		}
		
		view.addSubview(nameLabel)
		let nameLabelConstraints = [
			nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
			nameLabel.widthAnchor.constraint(equalToConstant: 100),
			nameLabel.heightAnchor.constraint(equalToConstant: 50),
			nameLabel.topAnchor.constraint(equalTo: view.topAnchor)
		]
		nameLabelConstraints.forEach { (constraint) in
			constraint.isActive = true
		}
		
		view.addSubview(nameTextField)
		let nameTextFieldConstraints = [
			nameTextField.leftAnchor.constraint(equalTo: nameLabel.rightAnchor),
			nameTextField.topAnchor.constraint(equalTo: nameLabel.topAnchor),
			nameTextField.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor),
			nameTextField.rightAnchor.constraint(equalTo: view.rightAnchor)
		]
		nameTextFieldConstraints.forEach { (constraint) in
			constraint.isActive = true
		}
		
		navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancel))
		
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(save))
	}
	
	@objc func cancel() {
		dismiss(animated: true, completion: nil)
	}
	
	@objc func save() {
		if self.company == nil {
			self.createComapny()
		} else {
			self.didEditCompany()
		}
	}
	
	func createComapny() {
		let context = CoreDataManager.shared.persistentContainer.viewContext
		let company = NSEntityDescription.insertNewObject(forEntityName: "Company", into: context)
		company.setValue(self.nameTextField.text, forKey: "name")
		do {
			try context.save()
			dismiss(animated: true) {
				self.delegate?.addCompany(company: company as! Company)
			}
		} catch let saveErr {
			print("Failed to save new company:", saveErr)
		}
	}
	
	func didEditCompany() {
		let context = CoreDataManager.shared.persistentContainer.viewContext
		
		company?.setValue(nameTextField.text, forKey: "name")
		
		do {
			try context.save()
			dismiss(animated: true) {
				self.delegate?.didEditCompany(company: self.company!)
			}
		} catch let saveErr {
			print("Failde to save edited company", saveErr)
		}
		
	}
}
