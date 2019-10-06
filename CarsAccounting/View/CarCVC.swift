//
//  CarCVC.swift
//  CarsAccounting
//
//  Created by Eduard Sinyakov on 10/6/19.
//  Copyright © 2019 Eduard Sinyakov. All rights reserved.
//

import UIKit

class CarCVC: UICollectionViewCell {
    @IBOutlet weak var carModelNameLabel: UILabel!
    @IBOutlet weak var carBrandNameLabel: UILabel!
    @IBOutlet weak var carDateOfMadeLabel: UILabel!
    @IBOutlet weak var typeOfCarLabel: UILabel!
    
    @IBOutlet weak var modelFT: UITextField!
    @IBOutlet weak var brandTF: UITextField!
    @IBOutlet weak var dateOfMadeTF: UITextField!
    @IBOutlet weak var typeOfCarTF: UITextField!
    
    
    override func awakeFromNib() {
        self.backgroundColor = .white
        self.alpha = 0.9
        self.layer.cornerRadius = 50
        self.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        self.layer.borderWidth = 5
        self.clipsToBounds = true
        
        
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.endEditing(true)
    }
}

extension CarCVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
}
