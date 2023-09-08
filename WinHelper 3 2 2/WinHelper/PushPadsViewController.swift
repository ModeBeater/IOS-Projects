//
//  PushPadsViewController.swift
//  WinHelper
//
//  Created by Nurkhan Tashimov on 23.05.2023.
//

import UIKit
import Foundation

class PushPadsViewController: UIViewController {
    
    var pads: [Int] = []
    
    var cnt: Int = 0
    
    var score : Int = 0
    
    var scoreTemp : Int = 0
    
    var timer: Timer?
    
    var mainTimer: Timer?
    
    var timeCounter = 0
    
    var randomColor : Int = 0
    
    var color : UIColor = .systemBlue
    
    var streak : Int = 0
    
    var isStreakBroke : Bool = false
    
    var isRepeatable : Bool = true
    
    var maxStreak = 0
    
    
    @IBOutlet weak var repeatButton: UIButton!
    
    @IBOutlet weak var padNumber0: UIButton!
    
    @IBOutlet weak var padNumber1: UIButton!
    
    @IBOutlet weak var padNumber2: UIButton!
    
    @IBOutlet weak var padNumber3: UIButton!
    
    @IBOutlet weak var padNumber4: UIButton!
    
    @IBOutlet weak var padNumber5: UIButton!
    
    @IBOutlet weak var padNumber6: UIButton!
    
    @IBOutlet weak var padNumber7: UIButton!
    
    @IBOutlet weak var padNumber8: UIButton!
    
    @IBOutlet weak var padNumber9: UIButton!
    
    @IBOutlet weak var padNumber10: UIButton!
    
    @IBOutlet weak var padNumber11: UIButton!
    
    @IBOutlet weak var padNumber12: UIButton!
    
    @IBOutlet weak var padNumber13: UIButton!
    
    @IBOutlet weak var padNumber14: UIButton!
    
    @IBOutlet weak var padNumber15: UIButton!
    
    @IBOutlet var buttons: [UIButton]!
    
    @IBOutlet weak var Score: UILabel!
    
    @IBOutlet weak var time: UILabel!
    
    @IBOutlet weak var streakText: UILabel!
    
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var streakLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    
    var canPlay: Bool = false;

    
    var pressedButons: [Int] = [];
    
    @IBAction func padClicked(_ sender: UIButton) {
        if !canPlay{
            return
        }
        let tagButton = sender.tag
        if pressedButons.contains(tagButton){
            return
        }
        
        
        if let _ = pads.firstIndex(of:tagButton){
            sender.backgroundColor = color
            
            scoreTemp += 100
            cnt += 1
            
            
        }
        else{
            sender.backgroundColor = .red
            scoreTemp -= 100
            self.isStreakBroke = true
//            pressedButons.append(tagButton)
        }
        pressedButons.append(tagButton)
        
        if cnt == pads.count{
            if(self.isStreakBroke == false){
                self.streak += 1
                if(self.streak > maxStreak){
                    maxStreak = self.streak
                }
                
            }
            
            else if(self.isStreakBroke == true){
                
                self.streak = 0
                
                self.score = 0
                
                self.isStreakBroke = false
            }
            
            
            if((streak != 0) && (streak % 5 == 0)){
                achieve()
                
            }
            isRepeatable = true
            score = scoreTemp
            Score.text = "Score: \(score)"
            time.text = "Time: \(timeCounter) milliseconds"
            streakText.text = "Streak: \(self.streak)"
            stopMainTimer()
            timer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(startNewGame), userInfo: nil, repeats: false)
            
        }
        
        
    }
    
    
    
    

    

    func startMainTimer(){
        mainTimer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(updateMainTimer), userInfo: nil, repeats: true)
        canPlay = true
    }
    
    @objc func updateMainTimer() {
        timeCounter += 1
    }
    
    func stopMainTimer() {
        mainTimer?.invalidate()
        mainTimer = nil
        timeCounter = 0
        canPlay = false
    }
    
    @objc func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(timerFired), userInfo: nil, repeats: false)
    }
    
    @objc func timerFired() {
        
        setColor(colorOfPad: .systemGray3)
        
        startMainTimer()
    }
    
   
    
    
    
    func clearPads(){
        for button in buttons{
            button.backgroundColor = .systemGray3
        }
        self.pads = []
        self.cnt = 0
        self.timeCounter = 0
    }
    
    
    
    
    
    
    
    

    @objc override func viewDidLoad() {
        super.viewDidLoad()
        
        repeatButton.layer.cornerRadius = 5
        scoreLabel.layer.cornerRadius = 5
        streakLabel.layer.cornerRadius = 5
        timeLabel.layer.cornerRadius = 5
        
        for button in buttons{
            button.layer.cornerRadius = 5
        }
        
        streakText.text = "Streak: \(streak)"
        Score.text = "Score: 0"
        
        startNewGame()
        
        
        
    }
    
    
    
    @objc func startNewGame(){
        time.text = "Time: 0 milliseconds"
        pressedButons = []
        
        
        self.clearPads()
        
        
        self.randomColor = Int.random(in: 0...2)
        color = getColor(colorNumber: randomColor)
        
        
        
        let randomNumber1 = Int.random(in: 6...8)
        for _ in 0...randomNumber1{
            let randomNumber2 = Int.random(in: 0...15)
            if let _ = pads.firstIndex(of:randomNumber2){
                continue
            } else {
                pads.append(randomNumber2)
            }
        }
        
        setColor(colorOfPad:color)
        
        
        startTimer()
    }
    
    
    @IBAction func repeatLevel(_ sender: UIButton) {
        if(isRepeatable == true){
            for button in buttons{
                button.backgroundColor = .systemGray3
            }
            UIView.animate(withDuration: 3.5, animations: {
                for i in self.pads{
                    self.buttons[i].backgroundColor = self.color
                }
            })
            UIView.animate(withDuration: 1, animations: {
                for i in self.pads{
                    self.buttons[i].backgroundColor = .systemGray3
                }
            })
            pressedButons = []
            cnt = 0
            scoreTemp = 0
            isRepeatable = false
        }
       
    }
    
    
    
    
    
    func getColor(colorNumber:Int) -> UIColor{
        if(colorNumber == 0){
            return .systemBlue
        }
        else if(colorNumber == 1){
            return .systemYellow
        }
        else{
            return .systemGreen
        }
    }
    
    func setColor(colorOfPad:UIColor){

        UIView.animate(withDuration: 1, animations: {
            for i in self.pads{
                self.buttons[i].backgroundColor = colorOfPad
            }
        })

        
    }
                    
    
    
        
    
    
    func achieve(){

        let v2 = UIView(frame: CGRect(x: 25, y: 70, width: UIScreen.main.bounds.size.width - 50, height: 120))
        
        v2.layer.cornerRadius = 10
        
        v2.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        
        let backgroundImage = UIImage(named: "achievementImage")
        v2.backgroundColor = UIColor(patternImage: backgroundImage!)
        
        
        let transparency: CGFloat = 0.9
        v2.backgroundColor = v2.backgroundColor?.withAlphaComponent(transparency)
        
        v2.layer.borderColor = UIColor.black.cgColor
        v2.layer.borderWidth = 2.0
        
        
        let label = UILabel(frame: CGRect(x: 50, y: 70, width: v2.bounds.width - 50, height: 120))
        label.text = "5 streaks in a row!"
        label.textAlignment = .center
        label.textColor = .black
        
        if(maxStreak == 5){
            label.text = "5 streaks in a row!"
            UserDefaults.standard.setValue(true, forKey: "PushPadsAch1")
            
        }
        else if(maxStreak == 10){
            label.text = "10 streaks in a row!"
            UserDefaults.standard.setValue(true, forKey: "PushPadsAch2")

        }
        else if(maxStreak == 15){
            label.text = "15 streaks in a row!"
            UserDefaults.standard.setValue(true, forKey: "PushPadsAch3")
            
        }
        
        
        self.view.addSubview(v2)
        self.view.addSubview(label)
        
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            UIView.animate(withDuration: 3, animations: {
                v2.alpha = 0.0
                label.alpha = 0.0
            }, completion: { _ in
                v2.removeFromSuperview()
                label.removeFromSuperview()
                
            })
        }
        
    }

    


}
