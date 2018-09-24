//
//  IndententLabel.swift
//  IntermediateTrainingCoreData
//
//  Created by Paweł Liczmański on 11.09.2018.
//  Copyright © 2018 Paweł Liczmański. All rights reserved.
//

import UIKit

class IndententLabel: UILabel {
	override func drawText(in rect: CGRect) {
		let indententRect = UIEdgeInsetsMake(0, 16, 0, 0)
		super.drawText(in: UIEdgeInsetsInsetRect(rect, indententRect))
	}
}
