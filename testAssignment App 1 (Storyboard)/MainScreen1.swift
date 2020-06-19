//
//  ViewController.swift
//  testAssignment App 1 (Storyboard)
//
//  Created by Roman Kavinskyi on 16.06.2020.
//  Copyright © 2020 Roman Kavinskyi. All rights reserved.
//

import UIKit
import CoreData


class MainScreen1: UIViewController {
	
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
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		//setLabelFromDefaults()
		setLabelFromCoreData()
	}
	
	private func setLabelFromDefaults() {
		
		if let input = defaults.string(forKey: "SavedLabel") {
			label.text = input
		}
	}
	
	private func loadLabelFromCoreData() -> String? {
		
		let context = persistentContainer.viewContext
		
		let fetchRequest = NSFetchRequest<SavedLabel>(entityName: "SavedLabel")
		
		do {
			let labelText = try context.fetch(fetchRequest)
			return labelText.first?.text
		} catch {
			print("Error loading data ---> \(error.localizedDescription)")
		}
		return nil
	}
	
	private func setLabelFromCoreData() {
		if let labelText = loadLabelFromCoreData() {
			label.text = labelText
		}
	}


	@IBAction func buttonTapped(_ sender: CustomButton) {
		performSegue(withIdentifier: "ParentToChild", sender: self)
	}
	
	
	

}

