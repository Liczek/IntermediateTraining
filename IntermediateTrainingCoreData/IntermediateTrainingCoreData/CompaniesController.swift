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
	//test nauka 1
	var companies = [Company]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let persistentContainer = NSPersistentContainer(name: "IntermediateTrainingCoreData")
		persistentContainer.loadPersistentStores { (storeDescription, error) in
			if let error = error {
				print("Failde to load persistent store", error)
				fatalError()
			}
		}
		let context = persistentContainer.viewContext
		
		let fetchRequest = NSFetchRequest<Company>(entityName: "Company")
		
		do {
			let companies = try context.fetch(fetchRequest)
			companies.forEach { (company) in
				print(company.name ?? "abc")
			}

		} catch let fetchError {
			print("Failde to fetch", fetchError)
		}
		
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
		tableView.backgroundColor = .darkBlue
		navigationItem.title = "Companies"

		let plusButton = UIBarButtonItem(image: #imageLiteral(resourceName: "plus").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(addCompanyHandle))
		navigationItem.setRightBarButton(plusButton, animated: true)
	
	}
	
	@objc func addCompanyHandle() {
		let createCompanyController = CreateCompanyController()
		let createCompanyNavigator = CustomNavigationController(rootViewController: createCompanyController)
		createCompanyController.delegate = self
		present(createCompanyNavigator, animated: true, completion: nil)
	}
	
	func addCompany(company: Company) {
		dismiss(animated: true) {
			let newIndexPath = IndexPath(row: self.companies.count, section: 0)
			self.companies.append(company)
			self.tableView.insertRows(at: [newIndexPath], with: .automatic)
		}
	}
	
	override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let view = UIView()
		view.backgroundColor = .lightBlue
		return view
	}
	
	override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 40
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return companies.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
		cell.backgroundColor = .tealColor
		cell.textLabel?.textColor = .white
		cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
		
		let company = companies[indexPath.row]
		cell.textLabel?.text = company.name
		return cell
	}
	
	override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
		let view = UIView()
		return view
	}
	
	

	

}













