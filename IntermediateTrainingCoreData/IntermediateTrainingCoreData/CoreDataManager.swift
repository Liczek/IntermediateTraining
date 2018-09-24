//
//  CoreDataManager.swift
//  IntermediateTrainingCoreData
//
//  Created by Paweł Liczmański on 18.08.2018.
//  Copyright © 2018 Paweł Liczmański. All rights reserved.
//

import CoreData

struct CoreDataManager {
	static let shared = CoreDataManager()
	
	let persistentContainer: NSPersistentContainer = {
		let container = NSPersistentContainer(name: "IntermediateTrainingCoreData")
		container.loadPersistentStores { (storeDescription, error) in
			if let error = error {
				print("Failde to load persistent store", error)
				fatalError()
			}
		}
		return container
	}()
	
	func fetchCompanies() -> [Company] {
		var companies = [Company]()
		let context = persistentContainer.viewContext
		do {
			companies = try context.fetch(Company.fetchRequest())
			return companies
		} catch let err {
			print("Fetch error", err)
		}
		return []
	}
	
	func deleteBatchCompanies(completion: () -> ()) {
		let context = persistentContainer.viewContext
		let deleteBatchRequest = NSBatchDeleteRequest(fetchRequest: Company.fetchRequest())
		do {
			try context.execute(deleteBatchRequest)
			completion()
		} catch let delBatchErr {
			print("Failed to deletaeBatchReq", delBatchErr)
		}
	}
	
//	func fetchEmployee() -> [Employee] {
//		let context = persistentContainer.viewContext
//		var employees = [Employee]()
//		let fetchRequest = NSFetchRequest<Employee>(entityName: "Employee")
//		do {
//			employees = try context.fetch(fetchRequest)
//			return employees
//		} catch let fetchErr {
//			print("Failed to fetch Employees", fetchErr)
//		}
//		return[]
//	}
	
	func createEmployee(employeeName: String, type: String, birthday: Date, company: Company) -> (employee: Employee?, error: Error?) {
		let context = persistentContainer.viewContext
		let employee = NSEntityDescription.insertNewObject(forEntityName: "Employee", into: context) as! Employee
		employee.name = employeeName
		employee.company = company
		employee.type = type
		
		let employeeInformations = NSEntityDescription.insertNewObject(forEntityName: "EmployeeInformations", into: context) as! EmployeeInformations
		employeeInformations.birthday = birthday
		
		employee.employeeinformations = employeeInformations
		
		do {
			try context.save()
			return (employee, nil)
		} catch let saveErr {
			print("Failed to save Employee", saveErr)
			return (nil, saveErr)
		}
		
	}
	
	
	
	
	
	
	
}
