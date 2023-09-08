//
//  SettingsViewController.swift
//  WinHelper
//
//  Created by Nurkhan Tashimov on 23.05.2023.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var findPair_emojiField: UITextField!
    
    @IBOutlet weak var findPair_numberOfPairsLabel: UILabel!
    
    @IBOutlet weak var findPair_numberOfPairStepper: UIStepper!
    
    @IBOutlet weak var diff: UISegmentedControl!
    
    @IBOutlet weak var diffWord: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        findPair_emojiField.text = UserDefaults.standard.string(forKey: "Emojies") ?? ""
        self.findPair_numberOfPairStepper.value = Double(UserDefaults.standard.integer(forKey: "NumberOfPairs"))
        findPair_numberOfPairsLabel.text = String(self.findPair_numberOfPairStepper.value)
        findPair_emojiField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        self.diff.selectedSegmentIndex = UserDefaults.standard.integer(forKey: "Simon")
        self.diffWord.selectedSegmentIndex = UserDefaults.standard.integer(forKey: "Word")
    }
    
    @IBAction func changeDiffSimon(_ sender: UISegmentedControl) {
        UserDefaults.standard.setValue(sender.selectedSegmentIndex, forKey: "Simon")
    }
    @IBAction func changeDiffWord(_ sender: UISegmentedControl) {
        UserDefaults.standard.setValue(sender.selectedSegmentIndex, forKey: "Word")
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        UserDefaults.standard.setValue(textField.text, forKey: "Emojies")
    }
    
    
    @IBAction func findPair_stepperAction(_ sender: UIStepper) {
        self.findPair_numberOfPairsLabel.text = String(sender.value)
        UserDefaults.standard.setValue(Int(sender.value), forKey: "NumberOfPairs")
    }
    
}
