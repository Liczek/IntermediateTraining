//
//  ViewController.swift
//  IntermediateTrainingCoreData
//
//  Created by Paweł Liczmański on 16.08.2018.
//  Copyright © 2018 Paweł Liczmański. All rights reserved.
//

import UIKit
import CoreData

class CompaniesController: UITableViewController, CreateCompanyControllerDelegate {
	
	var companies = [Company]()

	override func viewDidLoad() {
		super.viewDidLoad()
		navigationItem.title = "Companies"
		addObjectsAndConfigureTableView()
		fetchCompanies()
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return companies.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
		cell.textLabel?.text = companies[indexPath.row].name
		cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
		cell.textLabel?.textColor = .white
		cell.backgroundColor = .tealColor
		return cell
	}
	
	override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let view = UIView()
		view.backgroundColor = .lightBlue
		return view
	}
	override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 50
	}
	
	override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
		let view = UIView()
		return view
	}
	
	override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
		let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete", handler: deleteActionFunction)
		deleteAction.backgroundColor = .lightRed
		
		let editAction = UITableViewRowAction(style: .normal, title: "Edit", handler: editActionFunction)
		editAction.backgroundColor = .darkBlue
		return [deleteAction, editAction]
	}
	
	func deleteActionFunction(action: UITableViewRowAction, indexPath: IndexPath) {
		let company = companies[indexPath.row]
		companies.remove(at: indexPath.row)
		tableView.deleteRows(at: [indexPath], with: .fade)
		let context = CoreDataManager.shared.persistentContainer.viewContext
		context.delete(company)
		
		do {
			try context.save()
		} catch let saveErr {
			print("Failed to remove company", saveErr)
		}
		
		
	}
	
	func editActionFunction(action: UITableViewRowAction, indexPath: IndexPath) {
		let company = companies[indexPath.row]
		let editCompanyController = CreateCompanyController()
		editCompanyController.delegate = self
		let navController = CustomNavigationController(rootViewController: editCompanyController)
		present(navController, animated: true, completion: nil)
		editCompanyController.company = company
	}
	
	func addObjectsAndConfigureTableView() {
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
		
		tableView.backgroundColor = .darkBlue
		tableView.separatorColor = .darkBlue
		tableView.separatorInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
		
		navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(addCompanyButton))
	}
	
	@objc func addCompanyButton() {
		let createCompanyController = CreateCompanyController()
		createCompanyController.delegate = self
		let navController = CustomNavigationController(rootViewController: createCompanyController)
		present(navController, animated: true, completion: nil)
	}
	
	func addCompany(company: Company) {
		let row = companies.count
		self.companies.append(company)
		let newCompanyIndexPath = IndexPath(row: row, section: 0)
		self.tableView.insertRows(at: [newCompanyIndexPath], with: .middle)
	}
	
	func didEditCompany(company: Company) {
		guard let row = companies.index(of: company) else {return}
		let newIndexPath = IndexPath(row: row, section: 0)
		self.tableView.reloadRows(at: [newIndexPath], with: .bottom)
	}
	
	func fetchCompanies() {
		let context = CoreDataManager.shared.persistentContainer.viewContext
		let fetchRequest = NSFetchRequest<Company>(entityName: "Company")
		do {
			let companies = try context.fetch(fetchRequest)
			self.companies = companies
		} catch let fetchErr {
			print("Failed to fetch data:", fetchErr)
		}
	}
	
	
	
	
	
	
	

	

}

