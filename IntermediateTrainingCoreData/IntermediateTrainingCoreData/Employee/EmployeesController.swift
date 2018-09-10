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
	var employees = [Employee]()
	override func viewDidLoad() {
		super.viewDidLoad()
		navigationItem.title = "\(company?.name ?? "")"
		
		tableView.backgroundColor = .darkBlue
		
		setLeftDismissButton(title: "Back")
		setPlusButton(selector: #selector(addEmployee))
		
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
		
		employees = CoreDataManager.shared.fetchEmployee()
	}
	
	@objc private func addEmployee() {
		let createEmployeeController = CreateEmployeeController()
		createEmployeeController.company = company
		let navController = UINavigationController(rootViewController: createEmployeeController)
		navController.navigationBar.prefersLargeTitles = false
		createEmployeeController.delegate = self
		present(navController, animated: true, completion: nil)
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return employees.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
		let employee = employees[indexPath.row]
		cell.textLabel?.text = employee.name
		cell.backgroundColor = .tealColor
		cell.textLabel?.textColor = .white
		cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
		return cell
	}
	
	func didAddEmployee(employee: Employee) {
		let row = employees.count
		let newIndexPath = IndexPath(row: row, section: 0)
		employees.append(employee)
		tableView.insertRows(at: [newIndexPath], with: .automatic)
		tableView.reloadData()
	}
	
	
}
