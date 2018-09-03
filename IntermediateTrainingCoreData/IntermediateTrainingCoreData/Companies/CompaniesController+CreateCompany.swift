//
//  CompaniesController+CreateCompany.swift
//  IntermediateTrainingCoreData
//
//  Created by Paweł Liczmański on 03.09.2018.
//  Copyright © 2018 Paweł Liczmański. All rights reserved.
//

import UIKit

extension CompaniesController: CreateCompanyControllerDelegate {
	
	func addCompany(company: Company) {
		let newIndexPath = IndexPath(row: self.companies.count, section: 0)
		self.companies.append(company)
		self.tableView.insertRows(at: [newIndexPath], with: .automatic)
	}
	
	func didEditCompany(company: Company) {
		guard let row = companies.index(of: company) else {return}
		let newIndexPath = IndexPath(row: row, section: 0)
		tableView.reloadRows(at: [newIndexPath], with: .middle)
	}
	
}
