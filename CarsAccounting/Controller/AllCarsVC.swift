//
//  ViewController.swift
//  CarsAccounting
//
//  Created by Eduard Sinyakov on 10/6/19.
//  Copyright © 2019 Eduard Sinyakov. All rights reserved.
//

import UIKit
import CoreData



class AllCarsVC: UIViewController {

    var firstLaunch: Int = 0
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBAction func addNewCar(_ sender: UIButton) {
        performSegue(withIdentifier: segueID, sender: self)
    }
    
    let segueID     = "addNewCar"
    let cellName    = "CarCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVC()
        firstLaunch = UserDefaults.standard.integer(forKey: "key")
        checkFirstLaunc()
        
    } // end of viewDidLoad
    
    func setupVC() {
        
        let fetchRequest: NSFetchRequest<Cars> = Cars.fetchRequest()
        do {
        let cars = try PersistenceService.context.fetch(fetchRequest)
            arrayOfCars = cars
            collectionView.reloadData()
        } catch {
            
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
       
        
    } // end of func setupVC
    
    func checkFirstLaunc() {
        if firstLaunch == 0 {
            firstLaunch = 1
            UserDefaults.standard.set(1, forKey: "key")
            let bmw = Cars(context: PersistenceService.context)
            bmw.carsBrandName = "BMW"
            bmw.carsModelName = "5er"
            bmw.datesOFMade = "17 авг.2019"
            bmw.typesOfCars = "Седан"
            arrayOfCars.append(bmw)
            PersistenceService.saveContext()
            
            let lada = Cars(context: PersistenceService.context)
            lada.carsBrandName = "Lada"
            lada.carsModelName = "Priora"
            lada.datesOFMade = "8 янв.2017"
            lada.typesOfCars = "Седан"
            arrayOfCars.append(lada)
            PersistenceService.saveContext()
            
            let cadillac = Cars(context: PersistenceService.context)
            cadillac.carsBrandName = "Cadillac"
            cadillac.carsModelName = "Escalade"
            cadillac.datesOFMade = "22 мая.2008"
            cadillac.typesOfCars = "SUV"
            arrayOfCars.append(cadillac)
            PersistenceService.saveContext()
        }
    }
        

    
    // MARK: - Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueID {
            let dvc = segue.destination as! AddNewCarVC
            
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

} // end of class

// MARK: - collectionViewDelegate, collectionViewDatasource
extension AllCarsVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayOfCars.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellName, for: indexPath) as! CarCVC
        

        
        // MARK: Я использую forced unwraped тк я уверен, что данные будут (делаю проверку при заполнении данных)
        cell.carBrandNameLabel.text         = "Бренд: " + arrayOfCars[indexPath.row].carsBrandName!
        cell.carModelNameLabel.text         = "Модель: " + arrayOfCars[indexPath.row].carsModelName!
        cell.carDateOfMadeLabel.text        = "Дата производства: " + arrayOfCars[indexPath.row].datesOFMade!
        cell.typeOfCarLabel.text            = "Тип кузова: " + arrayOfCars[indexPath.row].typesOfCars!
        
        

        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CarCVC
        
        var selectedCar = arrayOfCars[indexPath.row]
        
        let deleteAlert = UIAlertController(title: "Вы хотите удалить автомобиль?", message: nil, preferredStyle: .actionSheet)
        
        let action = UIAlertAction(title: "Да", style: .default) { (delete) in
            
        
            
            
            PersistenceService.context.delete(arrayOfCars[indexPath.row])
            arrayOfCars.remove(at: indexPath.row)
            collectionView.deleteItems(at: [indexPath])
            PersistenceService.saveContext()
            collectionView.reloadData()
        }
        
        let actionCancel = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
        deleteAlert.addAction(action)
        deleteAlert.addAction(actionCancel)
        present(deleteAlert, animated: true, completion: nil)
        

        
    }
    
    
 
    
}

extension AllCarsVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
}


