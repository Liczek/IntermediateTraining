//
//  CreateEmployeeController.swift
//  IntermediateTrainingCoreData
//
//  Created by Paweł Liczmański on 04.09.2018.
//  Copyright © 2018 Paweł Liczmański. All rights reserved.
//

import UIKit
import CoreData

protocol CreateEmployeeControllerDelegate {
	func didAddEmployee(employee: Employee)
}

class CreateEmployeeController: UIViewController {
	
	var nameTextField = UITextField()
	var dateTextField = UITextField()
	let dateFormat = "dd.MM.yyyy"
	var company: Company?
	var delegate: CreateEmployeeControllerDelegate?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		navigationItem.title = "Add Employee for \(company?.name ?? "")"
		view.backgroundColor = .darkBlue
		
		setLeftDismissButton(title: "Cancel")
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
		_ = setLightBlueBackgroundView(height: 150)
		nameTextField = setRowWithTextfield(rowName: "Name", placeholder: "Add Employee name", constants: 0, topNeighbor: view, isFirstLine: true)
		dateTextField = setRowWithTextfield(rowName: "Birthday", placeholder: dateFormat, constants: 0, topNeighbor: nameTextField, isFirstLine: false)
	}
	
	@objc private func handleSave() {
		guard let employeeName = nameTextField.text else {return}
		guard let company = company else { return }
		
		
		if employeeName.isEmpty {
			setAlertController(title: "Name is required", message: "Please enter name of Employee", textField: nameTextField )
			return
		}
		
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = dateFormat
		guard let birthdayString = dateTextField.text else {return}
		if birthdayString.isEmpty {
			setAlertController(title: "Birthday is required", message: "Please eneter birthday date", textField: dateTextField)
			return
		}
		
		guard let birthdayDate = dateFormatter.date(from: birthdayString) else {
			setAlertController(title: "Bad date format", message: "Please use correct date format", textField: dateTextField)
			dateTextField.text = ""
			dateTextField.placeholder = dateFormat
			return
		}
		guard let employee = CoreDataManager.shared.createEmployee(employeeName: employeeName, birthday: birthdayDate, company: company).employee else {
			print("error during employee creating")
			return
		}
		dismiss(animated: true) {
			self.delegate?.didAddEmployee(employee: employee)
		}
		
		
	}
	
	func setAlertController(title: String, message: String, textField: UITextField) {
		let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
		let alertAction = UIAlertAction(title: "Ok", style: .default) { (action) in
			textField.becomeFirstResponder()
		}
		alertController.addAction(alertAction)
		present(alertController, animated: true, completion: nil)
	}
	
}
