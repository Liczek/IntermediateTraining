//
//  CreateCompanyController.swift
//  IntermediateTrainingCoreData
//
//  Created by Paweł Liczmański on 16.08.2018.
//  Copyright © 2018 Paweł Liczmański. All rights reserved.
//

import UIKit
import CoreData

protocol CreateCompanyControllerDelegate {
	func addCompany(company: Company)
	func didEditCompany(company: Company)
}

class CreateCompanyController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
	
	var company: Company? {
		didSet {
			guard let founded = company?.founded else {return}
			nameTextField.text = company?.name
			datePicker.date	= founded
			if let imageData = company?.imageData {
				companyImageView.image = UIImage(data: imageData)
				makeImageRounded()
			}
		}
	}
	
	var delegate: CreateCompanyControllerDelegate?
	
	
	lazy var companyImageView: UIImageView = {
		let image = UIImageView(image: #imageLiteral(resourceName: "select_photo_empty"))
		image.translatesAutoresizingMaskIntoConstraints = false
		image.contentMode = .scaleAspectFill
		image.isUserInteractionEnabled = true
		return image
	}()
	var nameTextField = UITextField()
	var lightBlueBackgroundView = UIView()
	
	let datePicker: UIDatePicker = {
		let dp = UIDatePicker()
		dp.date = Date()
		dp.datePickerMode = .date
		dp.translatesAutoresizingMaskIntoConstraints = false
		return dp
	}()
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationItem.title = company == nil ? "Create Company" : "Edit Company"
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .darkBlue
		title = "Create Company"
		
		addObjects()
		setConstraints()
		let tapCompanyImageView = UITapGestureRecognizer(target: self, action: #selector(pickImageForCompany))
		companyImageView.addGestureRecognizer(tapCompanyImageView)
		
		nameTextField.becomeFirstResponder()
	}
	
	@objc func cancelButtonHandle() {
		dismiss(animated: true, completion: nil)
	}
	
	@objc func handleSave() {
		
		if company == nil {
			createCompany()
		} else {
			saveCompanyChanges()
		}
		
		
	}
	
	func createCompany() {
		let context = CoreDataManager.shared.persistentContainer.viewContext
		let company = NSEntityDescription.insertNewObject(forEntityName: "Company", into: context)
		
		company.setValue(nameTextField.text, forKey: "name")
		company.setValue(datePicker.date, forKey: "founded")
		guard let image = companyImageView.image else {return}
		let imageData = UIImageJPEGRepresentation(image, 1)
		company.setValue(imageData, forKey: "imageData")
		
		do {
			try context.save()
			dismiss(animated: true) {
				self.delegate?.addCompany(company: company as! Company)
			}
		} catch let saveError {
			print("Faild to save context", saveError)
		}
	}
	
	func saveCompanyChanges() {
		let context = CoreDataManager.shared.persistentContainer.viewContext
		company?.name = nameTextField.text
		company?.founded = datePicker.date
		guard let image = companyImageView.image else {return}
		let imageData = UIImageJPEGRepresentation(image, 1)
		company?.imageData = imageData
		
		do {
			try context.save()
			dismiss(animated: true) {
				self.delegate?.didEditCompany(company: self.company!)
			}
		} catch let saveErr {
			print("Failed to update company:", saveErr)
		}
		
	}
	
	func addObjects() {
		
		setLeftDismissButton(title: "Cancel")
		
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
		
	}
	
	func setConstraints() {
		lightBlueBackgroundView = setLightBlueBackgroundView(height: 350)
		
		
		view.addSubview(companyImageView)
		let companyImageViewConstraints = [
			companyImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
			companyImageView.widthAnchor.constraint(equalToConstant: 100),
			companyImageView.heightAnchor.constraint(equalToConstant: 100),
			companyImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
		]
		companyImageViewConstraints.forEach { (constraint) in
			constraint.isActive = true
		}
		
		nameTextField = setNameLabel(placeholder: "Add Company name", constants: 100 + 16)
		
		view.addSubview(datePicker)
		let datePickerConstraints = [
			datePicker.topAnchor.constraint(equalTo: nameTextField.bottomAnchor),
			datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			datePicker.bottomAnchor.constraint(equalTo: lightBlueBackgroundView.bottomAnchor)
		]
		datePickerConstraints.forEach { (constraint) in
			constraint.isActive = true
		}
	}
	
	@objc func pickImageForCompany() {
		let imagePickerController = UIImagePickerController()
		imagePickerController.delegate = self
		imagePickerController.allowsEditing = true
		present(imagePickerController, animated: true, completion: nil)
	}
	
	func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
		dismiss(animated: true, completion: nil)
	}
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
		if let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
			self.companyImageView.image = editedImage
		} else if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
			companyImageView.image = originalImage
		}
		makeImageRounded()
		dismiss(animated: true, completion: nil)
	}
	
	private func makeImageRounded() {
		companyImageView.layer.cornerRadius = companyImageView.frame.width / 2
		print(companyImageView.frame.width / 2)
		companyImageView.clipsToBounds = true
		companyImageView.layer.borderColor = UIColor.darkBlue.cgColor
		companyImageView.layer.borderWidth = 2
	}
	
	
	
	
	
	
	
	
	
}
