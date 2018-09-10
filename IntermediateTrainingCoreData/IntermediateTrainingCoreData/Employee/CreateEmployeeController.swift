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
	var company: Company?
	var delegate: CreateEmployeeControllerDelegate?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		navigationItem.title = "Add Employee for \(company?.name ?? "")"
		view.backgroundColor = .darkBlue
		
		setLeftDismissButton(title: "Cancel")
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
		_ = setLightBlueBackgroundView(height: 50)
		nameTextField = setNameLabel(placeholder: "Add Employee name", constants: 0)
		
	}
	
	@objc private func handleSave() {
		guard let employeeName = nameTextField.text else {return}
		guard let employee = CoreDataManager.shared.createEmployee(employeeName: employeeName).employee else {return}
		dismiss(animated: true) {
			self.delegate?.didAddEmployee(employee: employee)
		}
	}
}
