//
//  ViewController.swift
//  Memory Game
//
//  Created by Alissa Ten on 20.05.2023.
//

import UIKit

struct Question{
    let row: Int
    let col: Int
    var str: String {
        String(row) + String(col)
    }
    public var description: String{
        return "What word was on the \(row+1) row, \(col+1) column?"
    }
}

class WordWallViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    @IBOutlet var questionView: UIView!
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var scoreLabel: UILabel!
    
    let levels: [String] = ["1", "2", "3"]
    let words: [String] = ["cat", "hat", "coat", "green", "shoes", "red", "socks", "purple", "orange", "blue", "vanilla", "rose", "tulip", "door", "floor", "roof", "window", "wall",  "book", "white", "black", "love", "dove", "dog", "bear", "beer", "milk", "water", "sun", "moon", "planet", "house", "horse", "fish", "dish", "rain", "pain", "mind", "kind", "bad", "sweet", "sweat", "great", "grade", "you", "I", "mother", "father", "aunt", "ant"]
    let firstLevel = ["00", "10", "01", "11", "20", "02", "21", "12", "22"]
    var secondLevel: [String] {
        firstLevel + ["30", "03", "31", "13", "32", "23", "33"]
    }
    var thirdLevel: [String] {
        secondLevel.dropLast(1) + ["40", "41", "33", "42", "43"]
    }
    var seen: [Int] = [Int]()
    var seenWords: [String] = [String]()
    var newQuestion: Question!
    var currLevel = 1
    var score = 0
    var effect: UIVisualEffect!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currLevel = UserDefaults().integer(forKey: "Word") + 1
        print(currLevel)
        effect = visualEffectView.effect
        visualEffectView.effect = nil
        questionView.layer.cornerRadius = 15
    }
    
    
    @IBAction func readyForQuestion(_ sender: Any) {
        animateIn()
        var randomRow: Int = 0
        var randomCol: Int = 0
        switch currLevel{
        case 1:
            randomRow = Int.random(in: 0...2)
            randomCol = Int.random(in: 0...2)
        case 2:
            randomRow = Int.random(in: 0...3)
            randomCol = Int.random(in: 0...3)
        case 3:
            randomRow = Int.random(in: 0...4)
            randomCol = Int.random(in: 0...3)
        default: break
        }
        
         newQuestion = Question(row: randomRow, col: randomCol)
        questionLabel.text = newQuestion.description
    }
    
    @IBAction func checkAnswer(_ sender: Any) {
        print(seenWords)
        if textField.text == findWordByID(newQuestion.str){
            score += 100
            if score >= 500 && currLevel >= 2{
                UserDefaults.standard.setValue(true, forKey: "FindWordAch1")
                achieve()
            }
            if score >= 1000 && currLevel >= 2{
                UserDefaults.standard.setValue(true, forKey: "FindWordAch2")
                achieve()
            }
        } else {
            let alert = UIAlertController(
                title: "Wrong Answer!",
                message: "Please, try again!",
                preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "All Right!", style: .default))
            self.present(alert, animated: true, completion: nil)
        }
        scoreLabel.text = "Score: \(score)"
        animateOut()
    }
    
    func animateIn() {
        self.view.addSubview(questionView)
        questionView.center = self.view.center
        questionView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        questionView.alpha = 0
        
        UIView.animate(withDuration: 0.4){
            self.visualEffectView.effect = self.effect
            self.questionView.alpha = 1
            self.questionView.transform = CGAffineTransform.identity
        }
    }
    func animateOut(){
        textField.text = ""
        UIView.animate(withDuration: 0.5, animations: {
            self.questionView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.questionView.alpha = 0
            self.visualEffectView.effect = nil
        }) {
            (success: Bool) in self.questionView.removeFromSuperview()
        }
    }
    
    func findWordByID(_ ID: String) -> String{
        var wordAnswer: String = ""
        var localArr: [String] = [String]()
        
        switch currLevel{
        case 1:
            localArr = firstLevel
        case 2:
            localArr = secondLevel
        case 3:
            localArr = thirdLevel
        default: break
        }
        
        for (i, id) in localArr.enumerated(){
            guard ID != id else{
                wordAnswer = seenWords[i]
                break
            }
        }
        return wordAnswer
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch self.currLevel {
        case 1: return 9
        case 2: return 16
        case 3: return 20
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as!MyCollectionViewCell
        cell.backgroundColor = UIColor(red: 0, green: 1, blue: 0, alpha: 0.5)
    
        var currLabel:String = ""
        var randomNumber = Int.random(in: 0..<self.words.count)
        while seen.contains(randomNumber){
            randomNumber = Int.random(in: 0..<self.words.count)
        }
        seen.append(randomNumber)
        seenWords.append(words[randomNumber])
        currLabel = self.words[randomNumber]
        cell.label.text = currLabel
        return cell
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int { return 1 }
    
    func collectionView(_: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch self.currLevel{
        case 1:
            return CGSize(width: 115, height: 110)
        case 2:
            return CGSize(width: 84, height: 80)
        case 3:
            return CGSize(width: 84, height: 80)
        default:
            return CGSize(width: 200, height: 200)
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
        label.text = "New achievement!"
        label.textAlignment = .center
        label.textColor = .black
        
        
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

