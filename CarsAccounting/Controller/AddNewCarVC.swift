//
//  AddNewCarVC.swift
//  CarsAccounting
//
//  Created by Eduard Sinyakov on 10/6/19.
//  Copyright © 2019 Eduard Sinyakov. All rights reserved.
//

import UIKit

class AddNewCarVC: UIViewController {
    
    let segueID = "toMain"
   // var dateTextFieldText = String()
    
    let yearPicker = UIDatePicker()
    let calendar = Calendar(identifier: .gregorian)
    var comps = DateComponents()

    @IBOutlet weak var typeOfCarTF: UITextField!
    @IBOutlet weak var dateOfMadeTF: UITextField!
    @IBOutlet weak var carBrandNameTF: UITextField!
    @IBOutlet weak var carModelNameTF: UITextField!
    @IBOutlet weak var addOutlet: UIButton!
    @IBAction func addAction(_ sender: UIButton) {
        
        if typeOfCarTF.text!.isEmpty || dateOfMadeTF.text!.isEmpty || carBrandNameTF.text!.isEmpty || carModelNameTF.text!.isEmpty {
            showAlert()
        } else {
            performSegue(withIdentifier: segueID, sender: self)
        }
    }
    
    @IBAction func dateTFAction(_ sender: UITextField) {
         setupYearsPickerView()
        
    }
    
    @IBAction func typeTFAction(_ sender: UITextField) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTextFields()
       setupYearsPickerView()
    }
    
    
    func setupTextFields() {
        typeOfCarTF.delegate = self
        dateOfMadeTF.delegate = self
        carBrandNameTF.delegate = self
        carModelNameTF.delegate = self
    }
    
    func setupYearsPickerView() {

        // MARK: - init yearPicker(DatePicker) for dateOfMadeTF
        let maxDate = calendar.date(byAdding: comps, to: Date())
        yearPicker.maximumDate = maxDate
        
        yearPicker.datePickerMode = .date
        yearPicker.locale = Locale.init(identifier: "RU")
        
        
        let toolBar = UIToolbar()
       toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Готово", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolBar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        dateOfMadeTF.inputAccessoryView = toolBar
        dateOfMadeTF.inputView = yearPicker
        
    }
    
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        formatter.dateStyle = .medium
        formatter.locale = Locale.init(identifier: "RU")
        dateOfMadeTF.text = formatter.string(from: yearPicker.date)
       // dateTextFieldText = dateOfMadeTF.text!
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "НЕ ВСЕ ПОЛЯ ЗАПОЛНЕНЫ", message: "Пожалуйста, заполните", preferredStyle: .alert)
        let action = UIAlertAction(title: "ОК", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    // MARK: - Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueID {
            let dvc = segue.destination as! AllCarsVC
            guard let cardBrandText = carBrandNameTF.text else {return}
            cars.carsBrandName = cardBrandText
            guard let modelText = carModelNameTF.text else {return}
            cars.carsModelName = modelText
            guard let dateOfMadeText = dateOfMadeTF.text else {return}
            cars.datesOFMade = dateOfMadeText
            guard let typeOfCarText = typeOfCarTF.text else {return}
            cars.typesOfCars = typeOfCarText
            
            arrayOfCars.append(cars)
            PersistenceService.saveContext()
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
} // end of class

extension AddNewCarVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
       
        return true
    }
}

//extension AddNewCarVC: UIPickerViewDelegate, UIPickerViewDataSource {
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//
//
//        return datesOFMade.count
//    }
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return datesOFMade[row]
//    }
//
//}
