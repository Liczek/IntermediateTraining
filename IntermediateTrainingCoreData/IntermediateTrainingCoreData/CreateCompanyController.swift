//
//  CreateCompanyController.swift
//  IntermediateTrainingCoreData
//
//  Created by Paweł Liczmański on 16.08.2018.
//  Copyright © 2018 Paweł Liczmański. All rights reserved.
//

import UIKit

class CreateCompanyController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .darkBlue
		title = "Create Company"
		let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonHandle))
		navigationItem.setLeftBarButton(cancelButton, animated: true)
	}
	
	@objc func cancelButtonHandle() {
		dismiss(animated: true, completion: nil)
	}
}
