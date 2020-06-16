//
//  MainScreen2.swift
//  testAssignment App 1 (Storyboard)
//
//  Created by Roman Kavinskyi on 16.06.2020.
//  Copyright © 2020 Roman Kavinskyi. All rights reserved.
//

import UIKit

class MainScreen2: UIViewController {


	@IBOutlet weak var button: CustomButton!
	@IBOutlet weak var textField: UITextField!
	
	override func viewDidLoad() {
        super.viewDidLoad()

		self.title = "Screen 2"
		let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewTapped(tapGestureRecognizer: )))
		view.addGestureRecognizer(tapGestureRecognizer)
    }
    

   
	@IBAction func buttonPressed(_ sender: CustomButton) {
		let input = textField.text!
		switch input {
		case "":
			navigationController?.popToRootViewController(animated: true)
		default:
			performSegue(withIdentifier: "ChildToParent", sender: self)
		}
	}
	
	@objc private func viewTapped(tapGestureRecognizer: UITapGestureRecognizer) {
		textField.resignFirstResponder()
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "ChildToParent" {
			let destinationVC = segue.destination as! MainScreen1
			let input = textField.text!
			destinationVC.input = input
		}
		
	}
}
