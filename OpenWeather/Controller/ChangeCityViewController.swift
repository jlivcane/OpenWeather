//
//  ChangeCityViewController.swift
//  OpenWeather
//
//  Created by jekaterina.livcane on 18/09/2020.
//  Copyright © 2020 jekaterina.livcane. All rights reserved.
//

import UIKit

protocol ChangeCityDelegate{
    func userEnteredNewCityName(city: String)
}

class ChangeCityViewController: UIViewController {
    
    var delegate: ChangeCityDelegate?
    
    @IBOutlet weak var cityTextField: UITextField!
    
    @IBAction func getWeatherTapped(_ sender: Any) {
        
        guard let cityName = cityTextField.text else { return }
        if cityName.isEmpty{
            warningPopup(withTitle: "Input error!", withMessage: "Please enter City Name!")
        }else{
            delegate?.userEnteredNewCityName(city: cityName)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func warningPopup(withTitle title:String?, withMessage message:String?){
        
        DispatchQueue.main.async {
            
            let popUp = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            popUp.addAction(okButton)
            self.present(popUp, animated: true, completion: nil)
            
        }
    }
}




