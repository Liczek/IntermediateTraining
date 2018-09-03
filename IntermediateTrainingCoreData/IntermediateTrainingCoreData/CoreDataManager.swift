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
}
