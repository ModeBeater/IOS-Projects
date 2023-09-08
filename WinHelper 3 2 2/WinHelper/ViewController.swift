//
//  ViewController.swift
//  WinHelper
//
//  Created by Nurkhan Tashimov on 23.05.2023.
//

import UIKit
import AVFoundation
class ViewController: UIViewController {
    
    
    @IBOutlet weak var l1: UILabel!
    @IBOutlet weak var l2: UILabel!
    @IBOutlet weak var l3: UILabel!
    @IBOutlet weak var l4: UILabel!
    @IBOutlet weak var l5: UILabel!
    @IBOutlet weak var l6: UILabel!
    @IBOutlet weak var l7: UILabel!
    @IBOutlet weak var l8: UILabel!
    @IBOutlet weak var l9: UILabel!
    var player: AVAudioPlayer?
    
    

    @IBOutlet weak var storyButton: UIButton!
    
    
    
    func letterControl(){
        if(UserDefaults.standard.bool(forKey: "PushPadsAch1")){
            l3.text = "N"
        }
        if(UserDefaults.standard.bool(forKey: "PushPadsAch2")){
            l5.text = "O"
        }
        if(UserDefaults.standard.bool(forKey: "PushPadsAch3")){
            l9.text = "2"
        }
        if(UserDefaults.standard.bool(forKey: "SimonSaysAch1")){
            l7.text = "S"
        }
        if(UserDefaults.standard.bool(forKey: "SimonSaysAch2")){
            l2.text = "I"
        }
        if(UserDefaults.standard.bool(forKey: "FindPairAch1")){
            l6.text = "W"
        }
        if(UserDefaults.standard.bool(forKey: "FindPairAch2")){
            l4.text = "D"
        }
        if(UserDefaults.standard.bool(forKey: "FindWordAch1")){
            l8.text = "3"
        }
        if(UserDefaults.standard.bool(forKey: "FindWordAch2")){
            l3.text = "W"
        }
    }

    @IBOutlet weak var settingsButton: UIButton!
    override func viewDidLoad() {
        

//        restoreDefaults()
//        self.storyButton.setBackgroundImage(UIImage(named: "bookThirdState"), for: .normal)
       
        do {
            let urlString = Bundle.main.path(forResource: "music2", ofType: "mp3")
            player = try AVAudioPlayer(contentsOf: URL(string: urlString!)!)
            player!.volume = 0.4
            player!.play()
        
        }
        catch {
            print("error occurred")
        }
        player?.numberOfLoops = -1
        player?.play()
        let firstTime = UserDefaults.standard.bool(forKey: "NotFirstTime")
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        settingsButton.addTarget(self, action: #selector(rotate360), for: .touchUpInside)
        
        if !firstTime {
            restoreDefaults()
            UserDefaults.standard.setValue(true, forKey: "NotFirstTime")
        }
        
        
    
        
        
    
        
//        storyButton.setBackgroundImage(UIImage(named: "bookFirstState"), for: .normal)
//
//        storyButton.setBackgroundImage(UIImage(named: "bookSecondState"), for: .highlighted)
//        storyButton.setBackgroundImage(UIImage(named: "bookThirdState"), for: .selected)
//
//        storyButton.addTarget(self, action: #selector(buttonHovered), for: [.touchDown, .touchDragEnter])
//        storyButton.addTarget(self, action: #selector(buttonUnhovered), for: [.touchUpInside, .touchDragExit])
        
        
        
        letterControl()
    }
    
    
    
    
    
    @IBAction func openStory(_ sender: UIButton) {
        
        sender.transform = .identity
        
        
        UIView.transition(with: self.storyButton, duration: 0.1, options: .transitionCrossDissolve, animations: {
            self.storyButton.setBackgroundImage(UIImage(named: "bookSecondState"), for: .normal)
        }, completion: {_ in
            UIView.transition(with: self.storyButton, duration: 0.1, options: .transitionCrossDissolve, animations: {
                self.storyButton.setBackgroundImage(UIImage(named: "bookFirstState"), for: .normal)
                }, completion: {_ in
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "history")
                    self.navigationController?.pushViewController(vc, animated: true)
                })
        })
        
        
        
        
        
        
    }
    
    
//
//    @objc func buttonHovered() {
//        UIView.animate(withDuration: 0.2) {
//            self.storyButton.setBackgroundImage(UIImage(named: "secondImage"), for: .normal)
//            self.storyButton.setBackgroundImage(UIImage(named: "thirdImage"), for: .highlighted)
//
//        }
//    }
//
//    @objc func buttonUnhovered() {
//        UIView.animate(withDuration: 0.2) {
//            self.storyButton.setBackgroundImage(UIImage(named: "firstImage"), for: .normal)
//            self.storyButton.setBackgroundImage(UIImage(named: "secondImage"), for: .highlighted)
//        }
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.storyButton.setBackgroundImage(UIImage(named: "bookThirdState"), for: .normal)
        letterControl()
        
    }
    
    
    
    func restoreDefaults(){
        UserDefaults.standard.setValue(6, forKey: "NumberOfPairs")
        UserDefaults.standard.setValue("🤡🏀🚗📱💻📞", forKey: "Emojies")
        UserDefaults.standard.setValue(0, forKey: "Simon")
        UserDefaults.standard.setValue(false, forKey: "PushPadsAch1")
        UserDefaults.standard.setValue(false, forKey: "PushPadsAch2")
        UserDefaults.standard.setValue(false, forKey: "PushPadsAch3")
        UserDefaults.standard.setValue(false, forKey: "SimonSaysAch1")
        UserDefaults.standard.setValue(false, forKey: "SimonSaysAch2")
        UserDefaults.standard.setValue(false, forKey: "FindPairAch1")
        UserDefaults.standard.setValue(false, forKey: "FindPairAch2")
        UserDefaults.standard.setValue(false, forKey: "FindWordAch1")
        UserDefaults.standard.setValue(false, forKey: "FindWordAch2")
        UserDefaults.standard.setValue(0, forKey: "MaxSimonHard")
        UserDefaults.standard.setValue(0, forKey: "MaxSimonNormal")
    }

    @IBAction func settingsButton(_ sender: UIButton) {
    }
    
    @objc func rotate360(button: UIButton!){
//        UIView.animate(withDuration: 0.3, animations: {
//            button.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
//        })
        button.transform = .identity
        
        UIView.transition(with: button, duration: 0.2, animations: {
            button.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        }, completion: {_ in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "Setting")
            self.navigationController?.pushViewController(vc, animated: true)
        })
    }
    
   
    
    
    
}

