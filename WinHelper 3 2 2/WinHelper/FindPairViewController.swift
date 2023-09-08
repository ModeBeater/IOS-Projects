//
//  ViewController.swift
//  FindPair
//
//  Created by Данил Хлебоказов on 21.05.2023.
//

import UIKit

class FindPairViewController: UIViewController {
    
    var elements = "";
    
    @IBOutlet weak var emojiField: UITextField!
    
    @IBOutlet weak var numberOfPairsLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var stepper: UIStepper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.elements = UserDefaults.standard.string(forKey: "Emojies") ?? "🕊️🐖🐏"
        self.emojiField.text = elements
        
        self.stepper.value = Double(UserDefaults.standard.integer(forKey: "NumberOfPairs"))
        self.numberOfPairsLabel.text = String(self.stepper.value)
        UserDefaults.standard.setValue(elements, forKey: "Emojies")
        
        
    }
    @IBAction func playButton(_ sender: UIButton) {
        UserDefaults.standard.setValue(textField.text, forKey: "Emojies")
    }
    
    @IBAction func emojiTextField(_ sender: UITextField) {
    }
    
    @IBAction func numberOfPairsStepper(_ sender: UIStepper) {
        self.numberOfPairsLabel.text = String(sender.value)
        UserDefaults.standard.setValue(Int(sender.value), forKey: "NumberOfPairs")
    }
    
}

