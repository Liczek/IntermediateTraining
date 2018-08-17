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
		container.loadPersistentStores(completionHandler: { (storeDescrition, error) in
			if let error = error {
				print("Failed to load persistent stores", error)
			}
		})
		return container
	}()
}
