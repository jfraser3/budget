//
//  EditEnvPopUpVC.swift
//  Budget-App
//
//  Created by Joshua Fraser on 3/2/18.
//  Copyright © 2018 Joshua Fraser. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class EditEnvPopUpVC: UIViewController, DataEnteredDelegate {
    
    var fetchedResultsController: NSFetchedResultsController<Envelope>?
    
    
    override func viewDidLoad() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Envelope>(entityName: "Envelope")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "index", ascending: true)]
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedContext, sectionNameKeyPath: nil, cacheName: "PersonsCache") //as? NSFetchedResultsController<Envelope>
        fetchedResultsController?.delegate = self as? NSFetchedResultsControllerDelegate
        do {
            try fetchedResultsController?.performFetch()
        } catch {
            fatalError("Unable to fetch: \(error)")
        }
        
        guard let fetchedResultsController = fetchedResultsController else {
            fatalError("Failed to load fetched results controller")
        }
        
        let envelope = fetchedResultsController.object(at: index!)
        let name = envelope.name
        let amount = envelope.amount
        let envImage = envelope.image
        envTextField.text = name
        amTextField.text = String(amount)
        imageView.image = UIImage(named: envImage!)
        
    }
    
    func userDidPickImage(info: String) {
        envImageName = info
    }
    
    @IBOutlet weak var envTextField: UITextField!
    @IBOutlet weak var amTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    var envImageName: String?
    var index: IndexPath?
    
    @IBAction func createButtonTapped(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Envelope", in: context)
        
        let envelope = Envelope(entity: entity!, insertInto: context)
        //person.firstName = randomFirstName
        //person.lastName = randomLastName
        //person.age = Int32(randomAge)
        envelope.name = envTextField.text
        if envelope.image == "default.jpg" {
            //envelopeImage.image = UIImage(named:"default.jpg")
        } else {
            envelope.image = envImageName
        }
        let cost: Double? = Double(amTextField.text!)
        envelope.amount = cost!
        let index: Int? = fetchedResultsController?.sections![0].numberOfObjects
        envelope.index = Int64(index!)
        appDelegate.saveContext()
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Called when user taps outside the text field
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showImage" {
            let pushedVC = segue.destination as! ImageCollectionVC
            pushedVC.delegate = self
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
