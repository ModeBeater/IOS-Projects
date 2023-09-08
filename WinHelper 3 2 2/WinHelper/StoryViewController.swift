//
//  StoryViewController.swift
//  WinHelper
//
//  Created by Дамир Кулжабай on 24.05.2023.
//

import UIKit

struct Story{
    var storyImage: String
    var storyText: String
}

class StoryViewController: UIViewController {
    
    
    let first = Story(storyImage: "storyImage 1", storyText: "Once upon a time there was a man named Bill Gates")
    let second = Story(storyImage: "storyImage 2", storyText: "He idolized his windows operating system")
    let third = Story(storyImage: "storyImage 3", storyText: "But an evil man came and took away his most precious thing")
    let fourth = Story(storyImage: "storyImage 4", storyText: "He grieved, could not find peace")
    let fifth = Story(storyImage: "storyImage 5", storyText: "Out of grief , he drank")
    let six = Story(storyImage: "storyImage 6", storyText: "And died of cardiac arrest")
    let seven = Story(storyImage: "storyImage 7", storyText: "But he came to life because he remembered that the cat needed to be fed")
    let eight = Story(storyImage: "storyImage 8", storyText: "He was walking to his home, sad, broken")
    let nine = Story(storyImage: "storyImage 9", storyText: "On the way I saw a terrible picture, steve jobs was tormenting poor windows")
    let ten = Story(storyImage: "storyImage 10", storyText: "He was trembling with anger, the earth was shaking, he could not stand the screams of the torment of his windows, rushed at the demon")
    let eleven = Story(storyImage: "storyImage 11", storyText: "The offender fell, the sky turned blue, sakura blossomed, the world became kinder")
    let twelve = Story(storyImage: "storyImage 12", storyText: "They got married and lived happily ever after")
    
    
    
    
    var currentStory : Int = 0
    
    var openedPieces : Int = 12
    
    
    var storyPieces : [Story] = []
    
    
    
    @IBOutlet weak var storyImage: UIImageView!
    
    
    @IBOutlet weak var storyText: UITextView!
    
    
    
    @IBOutlet weak var previousButton: UIButton!
    
    
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if(currentStory == 0){
            previousButton.backgroundColor = .gray
        }
        
        
        
        if(UserDefaults.standard.bool(forKey: "PushPadsAch1")){
            openedPieces += 1
        }
        if(UserDefaults.standard.bool(forKey: "PushPadsAch2")){
            openedPieces += 1
        }
        if(UserDefaults.standard.bool(forKey: "PushPadsAch3")){
            openedPieces += 1
        }
        if(UserDefaults.standard.bool(forKey: "SimonSaysAch1")){
            openedPieces += 1
        }
        if(UserDefaults.standard.bool(forKey: "SimonSaysAch2")){
            openedPieces += 1
        }
        if(UserDefaults.standard.bool(forKey: "FindPairAch1")){
            openedPieces += 1
        }
        if(UserDefaults.standard.bool(forKey: "FindPairAch2")){
            openedPieces += 1
        }
        if(UserDefaults.standard.bool(forKey: "FindWordAch1")){
            openedPieces += 1
        }
        if(UserDefaults.standard.bool(forKey: "FindWordAch2")){
            openedPieces += 1
        }
        if openedPieces > 12{
            openedPieces = 12
        }
        
        storyPieces =  [
            self.first,self.second,self.third,self.fourth,self.fifth,self.six,self.seven,self.eight,self.nine,self.ten,self.eleven,self.twelve
        ]
        
        storyImage.image = UIImage(named:storyPieces[0].storyImage)
        storyText.text = storyPieces[0].storyText
    }
    
    
    
    @IBAction func nextPiece(_ sender: UIButton) {
        if(currentStory + 1 < storyPieces.count && currentStory + 1 < openedPieces){
            currentStory += 1
            storyImage.image = UIImage(named: storyPieces[currentStory].storyImage)
            storyText.text = storyPieces[currentStory].storyText
        }
        if(currentStory + 1 >= openedPieces){
            nextButton.backgroundColor = .gray
        }
        if(currentStory > 0){
            previousButton.backgroundColor = .black
        }
//        print(currentStory, openedPieces)
    }
    
    
    
    @IBAction func previousPiece(_ sender: UIButton) {
        if(currentStory - 1 >= 0 ){
            currentStory -= 1
            storyImage.image = UIImage(named: storyPieces[currentStory].storyImage)
            storyText.text = storyPieces[currentStory].storyText
        }
        if(currentStory == 0){
            sender.backgroundColor = .gray
        }
        if(currentStory + 1 < openedPieces){
            nextButton.backgroundColor = .black
        }
    }
    
    
    

}
