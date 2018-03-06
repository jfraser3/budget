//
//  ImageCollectionVC.swift
//  Budget-App
//
//  Created by Joshua Fraser on 3/1/18.
//  Copyright © 2018 Joshua Fraser. All rights reserved.
//

import UIKit
import CoreData

private let reuseIdentifier = "Cell2"

protocol DataEnteredDelegate: class {
    func userDidPickImage(info: String)
}

class ImageCollectionVC: UICollectionViewController {
    
    weak var delegate: DataEnteredDelegate? = nil
    var fetchedResultsController: NSFetchedResultsController<Envelope>?
    var image: String?
    var envelopes = [EnvelopeItem]()
    fileprivate var tapGesture: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let width = collectionView!.frame.width / 3
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
        collectionView?.contentInset = UIEdgeInsets(top: 10, left: 30, bottom: 10, right: 30)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Do any additional setup after loading the view.
        
        //tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleTapGesture(gesture:)))
        //collectionView?.addGestureRecognizer(tapGesture)
        for i in 1...6 {
            envelopes.append(EnvelopeItem(title: "EnvIcon1", imageName: "icon1"))
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Envelope>(entityName: "Envelope")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "index", ascending: true)]
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedContext, sectionNameKeyPath: nil, cacheName: "PersonsCache")
        fetchedResultsController?.delegate = self as? NSFetchedResultsControllerDelegate
        do {
            try fetchedResultsController?.performFetch()
        } catch {
            fatalError("Unable to fetch: \(error)")
        }
    }
    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let envImage = image
        if let AddEnvPopUp = segue.destination as? AddEnvPopUpVC {
            AddEnvPopUp.envelopeImage.image = UIImage(named: envImage!)
            AddEnvPopUp.envImageName = envImage
        }
    }*/
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //guard let sectionInfo = fetchedResultsController?.sections?[section] else {
        //    fatalError("Failed to load fetched results controller")
        //}
        
        //return sectionInfo.numberOfObjects
        return envelopes.count
    }
    
    /*override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! EnvItemCell
     let envelopeItem = envelopes[indexPath.item]
     cell.envelopeItem = envelopeItem
     
     return cell
     }*/
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //guard let fetchedResultsController = fetchedResultsController else {
        //    fatalError("Failed to load fetched results controller")
        //}
        //
        //let envelope = fetchedResultsController.object(at: indexPath)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell2", for: indexPath) as! ImageItemCell
        //let firstName = person.firstName
        //let lastName = person.lastName
        //let age = person.age
        //let statement = "\(firstName!) \(lastName!) age \(age)"
        //cell.dataItemTextField.text = statement
        //cell.envelopeItem = envelope
        let item = envelopes[indexPath.item]
        cell.envelopeItem = item
        //let tap = UITapGestureRecognizer!
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(sender:)))
        cell.addGestureRecognizer(tapGesture)
        cell.isUserInteractionEnabled = true
        
        return cell
    }
    
    /*override func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     
     override func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
     print("Starting Index: \(sourceIndexPath.item)")
     print("Ending Index: \(destinationIndexPath.item)")
     //let temp = envelopes.remove(at: sourceIndexPath.item)
     //envelopes.insert(temp, at: destinationIndexPath.item)
     guard let fetchedResultsController = fetchedResultsController else {
     fatalError("Failed to load fetched results controller")
     }
     let num: Int! = fetchedResultsController.sections![0].numberOfObjects
     fetchedResultsController.object(at: sourceIndexPath).index = destinationIndexPath.item
     for i in 0...num {
     fetchedResultsController.object(at: <#T##IndexPath#>)
     }
     
     }*/
    
    func controller(_ control: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            guard let newIndexPath = newIndexPath else {
                fatalError("New index path is nil")
            }
            
            collectionView?.insertItems(at: [newIndexPath])
        case .delete:
            guard let indexPath = indexPath else {
                fatalError("Index path is nil")
            }
            
            collectionView?.deleteItems(at: [indexPath])
        case .move:
            guard let newIndexPath = newIndexPath,
                let indexPath = indexPath else {
                    fatalError("Index path or new index path is nil?")
            }
            
            collectionView?.deleteItems(at: [indexPath])
            collectionView?.insertItems(at: [newIndexPath])
        case .update:
            guard let indexPath = indexPath else {
                fatalError("Index path is nil")
            }
            
            collectionView?.reloadItems(at: [indexPath])
        }
    }
    
    
    /*@objc func handleTapGesture(gesture: UITapGestureRecognizer) {
        let selectedImage = collectionView?.indexPathForItem(at: tapGesture.location(in: collectionView))
        guard let fetchedResultsController = fetchedResultsController else {
            fatalError("Failed to load fetched results controller")
        }
        //let firstName = person.firstName
        //let lastName = person.lastName
        //let age = person.age
        //let statement = "\(firstName!) \(lastName!) age \(age)"
        //cell.dataItemTextField.text = statement
        //envelope.image = envelope
    }*/
    
    @objc func handleTapGesture(sender: UITapGestureRecognizer){
        //guard let fetchedResultsController = fetchedResultsController else {
        //    fatalError("Failed to load fetched results controller")
        //}
        
        //let envelope = fetchedResultsController.object(at: indexPath)
        
        if let indexPath = self.collectionView?.indexPathForItem(at: sender.location(in: self.collectionView)) {
            let cell = self.collectionView?.cellForItem(at: indexPath) as! ImageItemCell
            //let location = fetchedResultsController.sections![0].numberOfObjects - 1
            //fetchedResultsController.fetchedObjects![location].image = cell.envelopeItem?.imageName
            image = cell.envelopeItem?.imageName
            delegate?.userDidPickImage(info: image!)
            _ = navigationController?.popViewController(animated: true)
        } else {
            print("collection view was tapped")
        }

        
    }
    
    /*@objc func handleLongGesture(gesture: UILongPressGestureRecognizer) {
        switch(gesture.state) {
            
        case .began:
            guard let selectedIndexPath = collectionView?.indexPathForItem(at: gesture.location(in: collectionView)) else {
                break
            }
            collectionView?.beginInteractiveMovementForItem(at: selectedIndexPath)
        case .changed:
            collectionView?.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
        case .ended:
            collectionView?.endInteractiveMovement()
        default:
            collectionView?.cancelInteractiveMovement()
        }
    }*/
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Called when user taps outside the text field
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    /*func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .fullScreen
    }
    
    func presentationController(_ controller: UIPresentationController, viewControllerForAdaptivePresentationStyle style: UIModalPresentationStyle) -> UIViewController? {
        let navigationController = UINavigationController(rootViewController: controller.presentedViewController)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(CollectionViewController.dismissViewController))
        navigationController.topViewController?.navigationItem.rightBarButtonItem = doneButton
        return navigationController
    }
    
    @objc func dismissViewController() {
        self.dismiss(animated: true, completion: nil)
    }*/
    
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
    
}
