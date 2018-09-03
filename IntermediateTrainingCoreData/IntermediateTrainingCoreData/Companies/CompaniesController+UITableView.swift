//
//  CompaniesController+UITableView.swift
//  IntermediateTrainingCoreData
//
//  Created by Paweł Liczmański on 03.09.2018.
//  Copyright © 2018 Paweł Liczmański. All rights reserved.
//

import UIKit

extension CompaniesController {
	override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let view = UIView()
		view.backgroundColor = .lightBlue
		return view
	}
	
	override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 40
	}
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 60
	}
	
	override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
		let label = UILabel()
		label.text = "Add companies by clicking + button"
		label.font = UIFont.boldSystemFont(ofSize: 16)
		label.textColor = .white
		label.textAlignment = .center
		return label
	}
	
	override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		return companies.count == 0 ? 150 : 0
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return companies.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! CompanyCell
		let company = companies[indexPath.row]
		if let imageData = company.imageData {
			cell.companyImage.image = UIImage(data: imageData)
		} else {
			cell.companyImage.image = #imageLiteral(resourceName: "select_photo_empty")
		}
		
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "dd MMMM yyyy"
		if let founded = company.founded, let name = company.name {
			let stringDate = dateFormatter.string(from: founded)
			cell.companyNameFoundedLabel.text = "\(name) founded: \(stringDate)"
		}
		return cell
	}
	
	override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
		
		let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete", handler: deleteActionHandler)
		deleteAction.backgroundColor = .lightRed
		
		
		let editAction = UITableViewRowAction(style: .normal, title: "Edit", handler: editActionHandler)
		editAction.backgroundColor = .darkBlue
		return [deleteAction, editAction]
	}
	
	private func deleteActionHandler(action: UITableViewRowAction, indexPath: IndexPath) {
		let company = self.companies[indexPath.row]
		self.companies.remove(at: indexPath.row)
		self.tableView.deleteRows(at: [indexPath], with: .automatic)
		
		let context = CoreDataManager.shared.persistentContainer.viewContext
		context.delete(company)
		
		do {
			try context.save()
		} catch let saveError {
			print("Failed to save companies", saveError)
		}
	}
	
	private func editActionHandler(action: UITableViewRowAction, indexPath: IndexPath) {
		let company = self.companies[indexPath.row]
		let editCompanyController = CreateCompanyController()
		editCompanyController.delegate = self
		let navController = CustomNavigationController(rootViewController: editCompanyController)
		self.present(navController, animated: true, completion: nil)
		editCompanyController.company = company
	}
	
}
