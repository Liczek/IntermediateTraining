//
//  CompanyCell.swift
//  IntermediateTrainingCoreData
//
//  Created by Paweł Liczmański on 03.09.2018.
//  Copyright © 2018 Paweł Liczmański. All rights reserved.
//

import UIKit

class CompanyCell: UITableViewCell {
	
	let companyImage: UIImageView = {
		let image = UIImageView()
		image.backgroundColor = UIColor.tealColor
		image.layer.cornerRadius = 20
		image.clipsToBounds = true
		image.translatesAutoresizingMaskIntoConstraints = false
		return image
	}()
	
	let companyNameFoundedLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.boldSystemFont(ofSize: 16)
		label.textColor = UIColor.white
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textAlignment = .left
		return label
	}()
	
	
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		self.backgroundColor = UIColor.tealColor
		
		addSubview(companyImage)
		companyImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
		companyImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
		companyImage.heightAnchor.constraint(equalToConstant: 40).isActive = true
		companyImage.widthAnchor.constraint(equalToConstant: 40).isActive = true
		
		addSubview(companyNameFoundedLabel)
		companyNameFoundedLabel.leftAnchor.constraint(equalTo: companyImage.rightAnchor, constant: 8).isActive = true
		companyNameFoundedLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
		companyNameFoundedLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
		companyNameFoundedLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
		
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
