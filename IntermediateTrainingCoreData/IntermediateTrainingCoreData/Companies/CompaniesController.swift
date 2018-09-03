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

		let plusButton = UIBarButtonItem(image: #imageLiteral(resourceName: "plus").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(addCompanyHandle))
		navigationItem.setRightBarButton(plusButton, animated: true)
		navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(resetAll))
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













