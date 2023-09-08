//
//  ViewController.swift
//  mini game
//
//  Created by Nurkhan Tashimov on 20.05.2023.
//

import UIKit

class SimonSaysViewController: UIViewController {
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var blue: UIButton!
    @IBOutlet weak var green: UIButton!
    @IBOutlet weak var red: UIButton!
    @IBOutlet weak var yellow: UIButton!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var again: UIButton!
    @IBOutlet weak var maxScore: UILabel!
    var animation = false
    var check = false
    var difficult = "Normal"
    var array : Array<Int> = []
    var buttons : Array<UIButton> = []
    var positions : Array<(CGFloat,CGFloat)> = []
    var maxNormal: Int = 0
    var maxHard : Int = 0
    var i = 0
    @IBAction func repeating(_ sender: UIButton){
        again.addTarget(self, action: #selector(self.repeatCombo), for: .touchUpInside)
    }
    @IBAction func buttons(_ sender: UIButton){
        if(animation == false){
            let tagButton = sender.tag
            print(tagButton)
            if tagButton == array[i]{
                i += 1
                if i == array.count{
                    check = false
                    score.text = "Score: \(i)"
                    if difficult == "Hard"{
                        if i > self.maxHard{
                            self.maxHard = i
                            UserDefaults.standard.setValue(i, forKey: "MaxSimonHard")
                            self.maxScore.text = "Max Score: \(i)"
                        }
                        if i == 5{
                            achieve()
                        }
                    }
                    if difficult == "Normal"{
                        if i > self.maxNormal{
                            self.maxNormal = i
                            UserDefaults.standard.setValue(i, forKey: "MaxSimonNormal")
                            self.maxScore.text = "Max Score: \(i)"
                        }
                        if i == 10{
                            achieve()
                        }
                    }
                    getRandomColor()
                    i = 0
                }
            }
            else{
                array.removeAll()
                i = 0
                getRandomColor()
                score.text = "Score: 0"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let savedIndex = UserDefaults.standard.integer(forKey: "Simon")
        print(savedIndex)
        if savedIndex == 0{
            self.difficult = "Normal"
            self.maxNormal = UserDefaults.standard.integer(forKey: "MaxSimonNormal")
            self.maxScore.text = "Max score: \(self.maxNormal)"
        }
        if savedIndex == 1{
            self.difficult = "Hard"
            self.maxHard = UserDefaults.standard.integer(forKey: "MaxSimonHard")
            self.maxScore.text = "Max score: \(self.maxHard)"
        }
        self.red.tintColor = .red
        self.yellow.tintColor = UIColor(red: 1.0, green: 0.8, blue: 0.0, alpha: 1.0)
        self.green.tintColor = UIColor(red: 0.0, green: 0.8, blue: 0.0, alpha: 1.0)
        self.buttons = [self.yellow,self.green,self.blue,self.red]
        getRandomColor()
        again.addTarget(self, action: #selector(self.repeatCombo), for: .touchUpInside)
    }
    func getRandomColor(){
        let randomNumber = Int.random(in: 1...4)
        array.append(randomNumber)
        if self.difficult == "Hard"{
            if array.count % 2 == 0{
                for i in buttons{
                    self.positions.append((i.frame.origin.x,i.frame.origin.y))
                }
                for i in buttons{
                    UIView.animate(withDuration: 0.2, animations: {
                        let randomPos = Int.random(in: 0...self.positions.count - 1)
                        i.frame.origin.x = self.positions[randomPos].0
                        i.frame.origin.y = self.positions[randomPos].1
                        self.positions.remove(at: randomPos)
                    })
                }
            }
        }
        print(array)
        self.status.text = "Waiting"
        self.animateButton(index: 0)
    }
    @objc func repeatCombo(){
        if check == false && animation == false{
            self.status.text = "Waiting"
            self.animateButton(index: 0)
            check = true
        }
    }
    func animateButton(index: Int){
        guard index < array.count else {
            self.animation = false
            self.status.text = "Go!"
            return
        }
        self.animation = true
        let currentColor = array[index]
        let button: UIButton
                
        switch currentColor {
        case 1:
            button = blue
        case 2:
            button = red
        case 3:
            button = yellow
        case 4:
            button = green
        default:
            return
        }
        
        let duration = 0.5
        
        UIView.animate(withDuration: duration, animations: {
            button.alpha = 0.3
        }) { _ in
            UIView.animate(withDuration: duration) {
                button.alpha = 1.0
                
            } completion: { _ in
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    self.animateButton(index: index + 1)
                }
            }
        }
    }
    func achieve(){
        
        let v2 = UIView(frame: CGRect(x: 25, y: 100, width: UIScreen.main.bounds.size.width - 50, height: 80))
        
        v2.layer.cornerRadius = 10
        
        v2.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        
        let backgroundImage = UIImage(named: "SimonAch")
//        v2.backgroundColor = UIColor(patternImage: backgroundImage!)
        let image = UIView(frame: CGRect(x: 25, y: 70, width: 20, height: 20))
        image.backgroundColor = UIColor(patternImage: backgroundImage!)
        
        
        
        let transparency: CGFloat = 0.9
        v2.backgroundColor = .white
        v2.backgroundColor = v2.backgroundColor?.withAlphaComponent(transparency)
        
        v2.layer.borderColor = UIColor.black.cgColor
        v2.layer.borderWidth = 2.0
        
        
        let label = UILabel(frame: CGRect(x: 50, y: 70, width: v2.bounds.width - 50, height: 120))
        label.text = "5 streaks in a row!"
        label.textAlignment = .center
        label.textColor = .black
        
        if(maxHard == 5){
            label.text = "5 points in a row in Hard mode!"
            UserDefaults.standard.setValue(true, forKey: "SimonSaysAch2")
            
        }
        if(maxNormal == 10){
            label.text = "10 points in a row in Normal mode!"
            UserDefaults.standard.setValue(true, forKey: "SimonSaysAch1")
            
        }
        
        
        self.view.addSubview(v2)
        self.view.addSubview(label)
        self.view.addSubview(image)
        
        
        
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
