//
//  MedicationCollectionViewController.swift
//  MedicationTracker
//
//  Created by patelpra on 10/19/19.
//  Copyright © 2019 Crus Technologies. All rights reserved.
//

import UIKit

private let reuseIdentifier = "MedicationItemCell"

class MedicationCollectionViewController: UICollectionViewController {
    
    var medicationController = MedicationController()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
        
    }
  
    // MARK: - Navigation

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "MedTracker" {
//            guard let medicationDetailVC = segue.destination as? MedicationDetailViewController else { return }
//            medicationDetailVC.medicationController = self.medicationController
//        }
//    }


    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.medicationController.medicationItems.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? MedicationItemCollectionViewCell else { return UICollectionViewCell() }
    
        let MedicationItem = self.medicationController.medicationItems[indexPath.item]
        cell.nameLabel.text = MedicationItem.name
        cell.imageView.image = UIImage(named: MedicationItem.name)
        cell.hasBeenTaken.text = MedicationItem.hasBeenTaken ? "Taken" : "Not Taken"
        cell.delegate = self
    
        return cell
    }
}

    // MARK: UICollectionViewDelegate

extension MedicationCollectionViewController: MedicationItemCollectionViewCellDelegate {
    func toggleHasBeenTaken(for cell: MedicationItemCollectionViewCell) {
        guard let indexPath = self.collectionView.indexPath(for: cell) else { return }
        
        let medicationItem = self.medicationController.medicationItems[indexPath.item]
        self.medicationController.updateHasBeenTaken(for: medicationItem)
        
        collectionView.reloadData()
    }
}
