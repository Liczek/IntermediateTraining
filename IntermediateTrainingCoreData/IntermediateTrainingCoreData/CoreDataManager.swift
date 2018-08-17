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
}
