//
//  EmployeeController.swift
//  IntermediateTrainingCoreData
//
//  Created by Paweł Liczmański on 04.09.2018.
//  Copyright © 2018 Paweł Liczmański. All rights reserved.
//

import UIKit

class EmployeesController: UITableViewController, CreateEmployeeControllerDelegate {
	
	let cellID = "cellID"
	
	var company: Company?
	var employees = [[Employee]]()
	override func viewDidLoad() {
		super.viewDidLoad()
		navigationItem.title = "\(company?.name ?? "")"
		
		tableView.backgroundColor = .darkBlue
		
		setLeftDismissButton(title: "Back")
		setPlusButton(selector: #selector(addEmployee))
		
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)

		fetchEmployees()
	}
	
	func fetchEmployees() {
		guard let employesArray = company?.employees?.allObjects as? [Employee] else {return}
		
//		v.1
//		let referentArray = employesArray.filter { (employee) -> Bool in
//			return employee.type == EmployeeType.Referent.rawValue
//		}
//
//		let starszyReferentArray = employesArray.filter { (employee) -> Bool in
//			return employee.type == EmployeeType.StarszyReferent.rawValue
//		}
//
//		let specjalistaArray = employesArray.filter { (employee) -> Bool in
//			return employee.type == EmployeeType.Specjalista.rawValue
//		}
//		v.2
//		employees = [ employesArray.filter {$0.type == EmployeeType.Referent.rawValue},
//					  employesArray.filter {$0.type == EmployeeType.StarszyReferent.rawValue},
//					  employesArray.filter {$0.type == EmployeeType.Specjalista.rawValue}
//					  ]
		EmployeeTypes.forEach { (employeeType) in
			employees.append(
				employesArray.filter { $0.type == employeeType}
			)
		}
	}
	
	@objc private func addEmployee() {
		let createEmployeeController = CreateEmployeeController()
		createEmployeeController.company = company
		let navController = UINavigationController(rootViewController: createEmployeeController)
		navController.navigationBar.prefersLargeTitles = false
		createEmployeeController.delegate = self
		createEmployeeController.company = company
		present(navController, animated: true, completion: nil)
	}
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		return employees.count
	}
	
	override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 40
	}
	
	override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

				let label = IndententLabel()
				label.text = EmployeeTypes[section]
				label.textColor = .darkBlue
				label.textAlignment = .left
				label.font = UIFont.boldSystemFont(ofSize: 16)
				label.backgroundColor = .lightBlue
				return label
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return employees[section].count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
		let employee = employees[indexPath.section][indexPath.row]
		let employeeName = employee.name
		let employeeTaxId = employee.employeeinformations?.taxId
		cell.textLabel?.text = "\(employeeName ?? "")"
		if let employeeBirthday = employee.employeeinformations?.birthday {
			let dateFormatter = DateFormatter()
			dateFormatter.dateFormat = "dd.MM.yyyy"
			let birthdayString = dateFormatter.string(from: employeeBirthday)
			cell.textLabel?.text = "\(employeeName ?? "") - \(employeeTaxId ?? "no id") - \(birthdayString)"
		}
		cell.backgroundColor = .tealColor
		cell.textLabel?.textColor = .white
		cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
		return cell
	}
	
	func didAddEmployee(employee: Employee) {
		guard let section = EmployeeTypes.index(of: employee.type!) else {return}
		let row = employees[section].count
		let newIndexPath = IndexPath(row: row, section: section)
		employees[section].append(employee)
		tableView.insertRows(at: [newIndexPath], with: .left)
	}
	
	
}
