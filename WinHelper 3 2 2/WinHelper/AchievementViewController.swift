//
//  AchievementViewController.swift
//  PushPads
//
//  Created by Дамир Кулжабай on 23.05.2023.
//

import UIKit

class AchievementViewController: UIViewController {
    
    
    @IBOutlet weak var achievementCheck1: UIImageView!
    
    
    @IBOutlet weak var achievementCheck2: UIImageView!
    
    
    @IBOutlet weak var achievementCheck3: UIImageView!
    
    
    @IBOutlet weak var achievementCheck4: UIImageView!
    
   
    @IBOutlet weak var achievementCheck5: UIImageView!
    
    
    @IBOutlet weak var achievementCheck6: UIImageView!
    
    
    @IBOutlet weak var achievementCheck7: UIImageView!
    
    
    @IBOutlet weak var achievementCheck8: UIImageView!
    
    @IBOutlet weak var achievementCheck9: UIImageView!
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if(UserDefaults.standard.bool(forKey: "PushPadsAch1")){
            achievementCheck1.image = UIImage(systemName: "checkmark.seal.fill")
        }
        if(UserDefaults.standard.bool(forKey: "PushPadsAch2")){
            achievementCheck2.image = UIImage(systemName: "checkmark.seal.fill")
        }
        if(UserDefaults.standard.bool(forKey: "PushPadsAch3")){
            achievementCheck3.image = UIImage(systemName: "checkmark.seal.fill")
        }
        if(UserDefaults.standard.bool(forKey: "SimonSaysAch1")){
            achievementCheck4.image = UIImage(systemName: "checkmark.seal.fill")
        }
        if(UserDefaults.standard.bool(forKey: "SimonSaysAch2")){
            achievementCheck5.image = UIImage(systemName: "checkmark.seal.fill")
        }
        if(UserDefaults.standard.bool(forKey: "FindPairAch1")){
            achievementCheck6.image = UIImage(systemName: "checkmark.seal.fill")
        }
        if(UserDefaults.standard.bool(forKey: "FindPairAch2")){
            achievementCheck7.image = UIImage(systemName: "checkmark.seal.fill")
        }
        if(UserDefaults.standard.bool(forKey: "FindWordAch1")){
            achievementCheck8.image = UIImage(systemName: "checkmark.seal.fill")
        }
        if(UserDefaults.standard.bool(forKey: "FindWordAch2")){
            achievementCheck9.image = UIImage(systemName: "checkmark.seal.fill")
        }
        
        
        // Do any additional setup after loading the view.
    }
    

}
