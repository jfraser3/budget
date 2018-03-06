//
//  AddEnvPopUpVC.swift
//  Budget-App
//
//  Created by Joshua Fraser on 2/28/18.
//  Copyright © 2018 Joshua Fraser. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class AddEnvPopUpVC: UIViewController, DataEnteredDelegate {
    
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
        
        /*let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Envelope", in: context)
        
        let envelope = Envelope(entity: entity!, insertInto: context)
        envelope.name = envelopeTextField.text
        let cost: Double? = Double(amountTextField.text!)
        envelope.amount = cost!
        let index: Int? = fetchedResultsController?.sections![0].numberOfObjects
        envelope.index = Int64(index!)
        envelope.image = "default.jpg"
        envelopeImage.image = UIImage(named: envelope.image!)
        appDelegate.saveContext()*/
        envelopeImage.image = UIImage(named: "default.jpg")
        //envelopeTextField.text = "hi"
    }
    
    func userDidPickImage(info: String) {
        envImageName = info
    }
    
    @IBOutlet weak var envelopeTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var envelopeImage: UIImageView!
    var envImageName: String?
    
    @IBAction func createButtonTapped(_ sender: Any) {
         let appDelegate = UIApplication.shared.delegate as! AppDelegate
         let context = appDelegate.persistentContainer.viewContext
         let entity = NSEntityDescription.entity(forEntityName: "Envelope", in: context)
        
         let envelope = Envelope(entity: entity!, insertInto: context)
         //person.firstName = randomFirstName
         //person.lastName = randomLastName
         //person.age = Int32(randomAge)
         envelope.name = envelopeTextField.text
        if envelope.image == "default.jpg" {
            //envelopeImage.image = UIImage(named:"default.jpg")
        } else {
            envelope.image = envImageName
        }
         let cost: Double? = Double(amountTextField.text!)
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
        if segue.identifier == "selectImage" {
            let pushedVC = segue.destination as! ImageCollectionVC
            pushedVC.delegate = self
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
