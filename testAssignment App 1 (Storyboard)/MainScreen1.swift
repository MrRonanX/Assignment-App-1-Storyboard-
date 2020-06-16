//
//  ViewController.swift
//  testAssignment App 1 (Storyboard)
//
//  Created by Roman Kavinskyi on 16.06.2020.
//  Copyright © 2020 Roman Kavinskyi. All rights reserved.
//

import UIKit


class MainScreen1: UIViewController {
	
	@IBOutlet weak var label: UILabel!
	@IBOutlet weak var button: CustomButton!
	
	
	var input: String!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		navigationItem.hidesBackButton = true
		button.setTitle("Next Screen", for: .normal)
		self.title = "Screen 1"
		if let input = input {
			label.text = input
		}
		
	}


	@IBAction func buttonTapped(_ sender: CustomButton) {
		performSegue(withIdentifier: "ParentToChild", sender: self)
	}
	
	
	

}

