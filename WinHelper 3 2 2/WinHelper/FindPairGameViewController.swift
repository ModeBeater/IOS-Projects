//
//  FindPairGameViewController.swift
//  FindPair
//
//  Created by Данил Хлебоказов on 21.05.2023.
//

import UIKit

class FindPairGameViewController: UIViewController {
    
    @IBOutlet var hStackViewArray: [UIStackView]!
    @IBOutlet weak var gameView: UIView!
    
    @IBOutlet weak var timeLabel: UILabel!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    var timer: Timer?
    var timePassed = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        self.startGame()
    }
    
    @objc func updateCounter(){
        timePassed += 1
        self.timeLabel.text = String(timePassed)
    }
    
    var pairs: [Card] = []
    var buttons: [UIButton] = []
    var upCards: [UIButton] = []
    var numberOfErrors = 0;
    
    func startGame(){
        let numberOfPair = UserDefaults.standard.integer(forKey: "NumberOfPairs")
        
        let emojies = UserDefaults.standard.string(forKey: "Emojies")
        
        for _ in (1...numberOfPair){
            if let em = emojies?.randomElement(){
                self.pairs.append(Card(symbol: String(em)))
                self.pairs.append(Card(symbol: String(em)))
            }
        }
        
        self.pairs.shuffle()
        
        for (i, card) in pairs.enumerated(){
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: 90, height: 135))
            button.layer.cornerRadius = 20
            button.setBackgroundImage(UIImage(named: "backside.png"), for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 40, weight: .bold)
            button.layer.borderColor = CGColor(red: 255, green: 0, blue: 0, alpha: 1)
            button.backgroundColor = UIColor(red: 100, green: 0, blue: 0, alpha: 1)
            button.layer.borderWidth = 0
            button.titleLabel?.layer.opacity = 0
            button.setTitle(card.symbol, for: .normal)
            button.addTarget(self, action: #selector(makeUp), for: .touchUpInside)
            buttons.append(button)
            self.hStackViewArray[i/4].addArrangedSubview(button)
        }
        
        
    }
    
    func checkPair(){
        if upCards[0].titleLabel?.text == upCards[1].titleLabel?.text{
            if let btn1 = buttons.firstIndex(of: upCards[0]){
                buttons.remove(at: btn1)
            }
            if let btn2 = buttons.firstIndex(of: upCards[1]){
                buttons.remove(at: btn2)
            }
            makeHidden(button: upCards[0])
            makeHidden(button: upCards[1])
        }
        else{
            numberOfErrors += 1
        }
        upCards.removeAll()
        makeAllClose()
    }
    
    func makeHidden(button: UIButton){
        UIView.animate(withDuration: 0.3, animations: {
            button.alpha = 0;
            button.backgroundColor = .white
            button.titleLabel?.layer.opacity = 0
            button.layer.borderWidth = 0
            button.removeTarget(self, action: #selector(self.makeUp), for: .touchUpInside)
        })
        
    }
    
    @objc func makeUp(button: UIButton!){
        if upCards.contains(button){
            return
        }
        button.setBackgroundImage(nil, for: .normal)
        button.backgroundColor = .white
        button.layer.borderWidth = 2
        button.titleLabel?.layer.opacity = 1
        UIView.transition(with: button, duration: 0.2, options: .transitionFlipFromRight, animations: nil, completion: { _ in
            self.upCards.append(button)
            if self.upCards.count == 2{
                self.checkPair()
            }
        })
//        upCards.append(button)
//        if upCards.count == 2{
//            checkPair()
//        }
    }
    
    func makeAllClose(){
        if buttons.count == 0{
            showAlert()
            self.timer?.invalidate()
        }
        for button in buttons{
            if button.backgroundColor != UIColor(red: 100, green: 0, blue: 0, alpha: 1){
                button.backgroundColor = UIColor(red: 100, green: 0, blue: 0, alpha: 1)
                button.layer.borderWidth = 0
                button.setBackgroundImage(UIImage(named: "backside.png"), for: .normal)
                button.titleLabel?.layer.opacity = 0
                UIView.transition(with: button, duration: 0.5, options: .transitionFlipFromLeft, animations: nil, completion: nil)
            }
        }
    }
    
    class Card{
        var symbol: String;
        var isFaceUp: Bool = false;
        
        init(symbol: String) {
            self.symbol = symbol
        }
        
    }
    
    private func showAlert(){
        let alert  = UIAlertController(title: "Congratulations", message: "You won!", preferredStyle: .alert)
        
        var alertText = "OK"
        
        if numberOfErrors < 20 && pairs.count == 20{
            alertText = "New achievement unlocked!"
            UserDefaults.standard.setValue(true, forKey: "FindPairAch1")
        }
        if numberOfErrors < 20 && pairs.count >= 12 && timePassed <= 20{
            alertText = "New achievement unlocked!"
            UserDefaults.standard.setValue(true, forKey: "FindPairAch2")
        }
        
        
        let okAction = UIAlertAction(title: alertText, style: .default, handler:{[weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        })
        
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    

}
