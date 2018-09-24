//
//  ViewController.swift
//  IntermediateTrainingCoreData
//
//  Created by Paweł Liczmański on 16.08.2018.
//  Copyright © 2018 Paweł Liczmański. All rights reserved.
//

import UIKit
import CoreData

class CompaniesController: UITableViewController {
	
	var companies = [Company]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		companies = CoreDataManager.shared.fetchCompanies()
		
		tableView.register(CompanyCell.self, forCellReuseIdentifier: "cellID")
		tableView.backgroundColor = .darkBlue
		navigationItem.title = "Companies"
		tableView.tableFooterView = UIView()

		navigationItem.setLeftBarButtonItems([
			UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(resetAll)),
			UIBarButtonItem(title: "Add letter", style: .plain, target: self, action: #selector(addLetter))
			], animated: true)
		
		let plusButton = UIBarButtonItem(image: #imageLiteral(resourceName: "plus").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(addCompanyHandle))
		navigationItem.setRightBarButton(plusButton, animated: true)
	}
	
	@objc private func addLetter() {
		print("test")
		// 1 stworzyc companies poprzez fetch Company
		// 2 zrobic for each in companies i zmienic imiona
		// 3 zrobic save na background/privatefetch
		// 4 przejsc na global i zrobic save na global
		
		DispatchQueue.global(qos: .background).async {
			
			let privateContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
			privateContext.parent = CoreDataManager.shared.persistentContainer.viewContext
			let request: NSFetchRequest<Company> = Company.fetchRequest()
			request.fetchLimit = 2
			do {
				let companies = try privateContext.fetch(request)
				for (index, company) in companies.enumerated() {
					company.name = "B\(index + 1): \(company.name ?? "")"
					print(company.name ?? "")
					
					do {
						try privateContext.save()
						
						DispatchQueue.main.async {
							let contex = CoreDataManager.shared.persistentContainer.viewContext
							
							do {
								try contex.save()
								self.tableView.reloadData()
								
							} catch let saveErr {
								print("Failed to save to mainQueue", saveErr)
							}
						}
					} catch let saveErr {
						print("Failed to save to privateContex", saveErr)
					}
				}
			} catch let privFetchErr {
				print("Failed to fetch to priveContext", privFetchErr)
			}
		}
	}
	
	@objc private func addCompanyHandle() {
		let createCompanyController = CreateCompanyController()
		let createCompanyNavigator = CustomNavigationController(rootViewController: createCompanyController)
		createCompanyController.delegate = self
		present(createCompanyNavigator, animated: true, completion: nil)
	}
	
	@objc private func resetAll() {
		CoreDataManager.shared.deleteBatchCompanies {
			var deletedRowIndexPaths = [IndexPath]()
			for (index, _) in companies.enumerated() {
				let indexPath = IndexPath(row: index, section: 0)
				deletedRowIndexPaths.append(indexPath)
			}
			companies.removeAll()
			tableView.deleteRows(at: deletedRowIndexPaths, with: .left)
		}
	}
}













