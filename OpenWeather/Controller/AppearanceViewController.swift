//
//  AppearanceViewController.swift
//  OpenWeather
//
//  Created by jekaterina.livcane on 19/09/2020.
//  Copyright © 2020 jekaterina.livcane. All rights reserved.
//

import UIKit

class AppearanceViewController: UIViewController {
    
    
    @IBOutlet weak var textLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabelText()
    }
    
    @IBAction func openSettingsTapped(_ sender: Any) {
        
        guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        if UIApplication.shared.canOpenURL(settingsURL){
            UIApplication.shared.open(settingsURL, options: [:]) { (success) in
                print(success)
            }
        }
    }
    func setLabelText(){
        var text = "Unable to specify UI style"
        
        if self.traitCollection.userInterfaceStyle == .dark {text = "Dark Mode is on. \nGo to settings if you would like\nto change to Light Mode"
            
        }else{
            text = "Light Mode is on. \nGo to settings if you would like\nto change to Dark Mode."
        }
        textLabel.text = text
        
    }
}

extension AppearanceViewController {
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setLabelText()
    }
}

