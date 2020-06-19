//
//  MainScreen2.swift
//  testAssignment App 1 (Storyboard)
//
//  Created by Roman Kavinskyi on 16.06.2020.
//  Copyright © 2020 Roman Kavinskyi. All rights reserved.
//

import UIKit
import CoreData

class MainScreen2: UIViewController {
	
	let persistentContainer: NSPersistentContainer = {
		let container = NSPersistentContainer(name: "LabelSaver")
		container.loadPersistentStores { (storeDescription, error) in
			if let error = error {
				fatalError("Loading of store failed \(error)")
			}
		}
		return container
	}()
	
	private let defaults = UserDefaults()


	@IBOutlet weak var button: CustomButton!
	@IBOutlet weak var textField: UITextField!
	
	override func viewDidLoad() {
        super.viewDidLoad()

		self.title = "Screen 2"
		let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewTapped(tapGestureRecognizer: )))
		view.addGestureRecognizer(tapGestureRecognizer)
    }
    

   
	@IBAction func buttonPressed(_ sender: CustomButton) {
		deleteLastLabelFromCoreData()
		
		//FIXED POP TO NAVIGATION CONTROLLER
		
		let input = textField.text!
		if let rootVC = navigationController?.viewControllers.first as? MainScreen1 {
			rootVC.input = input
		}
		navigationController?.popToRootViewController(animated: true)
		
//		let input = textField.text!
//		switch input {
//		case "":
//			navigationController?.popToRootViewController(animated: true)
//		default:
//			performSegue(withIdentifier: "ChildToParent", sender: self)
//		}
//
		
//		ONE MORE WAY TO SAVE DATA    --> USER DEFAULTS
//
//		COMMENT OUT CODE BELLOW AND DELETE CODE ABOVE TO CHECK IT
//		ALSO COMMENT OUT METHOD IN VIEW WILL APPEAR IN SCREEN 1

//		let input = textField.text!
//		defaults.set(input, forKey: "SavedLabel")
//		navigationController?.popViewController(animated: true)
//
//
//		ONE MORE WAY TO SAVE DATA    --> CORE DATA
//
//		COMMENT OUT CODE BELLOW AND DELETE CODE ABOVE TO CHECK IT
//
//
//		deleteLastLabelFromCoreData()
//		saveToCoreData()
//		navigationController?.popViewController(animated: true)
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
	
	fileprivate func deleteLastLabelFromCoreData() {
		let context = persistentContainer.viewContext
		
		let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "SavedLabel")
		let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
		
		do {
			try context.execute(deleteRequest)
		} catch {
			print("Error deleting data ---> \(error.localizedDescription)")
		}
		
	}
	
	fileprivate func saveToCoreData() {
		
		
		let userInput = textField.text!
		
		let context = persistentContainer.viewContext
		let label = NSEntityDescription.insertNewObject(forEntityName: "SavedLabel", into: context) as! SavedLabel
		
		label.text = userInput
		
		do {
			try context.save()
			
		} catch {
			print("Error saving data ---> \(error.localizedDescription)")
		}
	}
}
