//
//  ViewController.swift
//  Berlin Clock
//
//  Created by Nurkhan Tashimov on 23.09.2023.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    @IBOutlet weak var second: UIImageView!
    var timer: Timer?
    @IBOutlet weak var datePicker: UIDatePicker!
    var now = Date()
    override func viewDidLoad() {
        second.layer.cornerRadius = second.frame.width / 2
        super.viewDidLoad()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        // Do any additional setup after loading the view.
    }
    @IBAction func dateValueChanged(_ sender: UIDatePicker) {
            now = sender.date
        }
    @objc func updateTime(){
        now = Calendar.current.date(byAdding: .second, value: 1, to: now)!
        datePicker.setDate(now, animated: true)
        print(now)
        let hours = Calendar.current.component(.hour, from: now) //текущие часы
        let hoursLeft = hours % 5 // оставшееся время
        if hours / 5 > 0{
            separateByTime(begin: 1, end: hours / 5)
            blackDraw(begin: hours / 5 + 1, end: 4)
        }
        else{
            blackDraw(begin: 1, end: 4)
        }
        if hoursLeft > 0{
            separateByTime(begin: 5, end: hoursLeft + 4)
            blackDraw(begin: hoursLeft + 6, end: 13)
        }
        else{
            blackDraw(begin: 5, end: 9)
        }
        let minutes = Calendar.current.component(.minute, from: now)
        if minutes / 5 > 0{
            separateByTime(begin: 9, end: minutes / 5 + 8)
            blackDraw(begin: minutes / 5 + 10, end: 20)
        }
        else{
            blackDraw(begin: 9, end: 20)
        }
        let minutesLeft = minutes % 5
        if minutesLeft > 0{
            separateByTime(begin: 21, end: minutesLeft + 20)
            blackDraw(begin: minutesLeft + 21, end: 24)
        }
        else{
            blackDraw(begin: 21, end: 24)
        }
        let seconds = Calendar.current.component(.second, from: now)
        if seconds % 2 == 0{
            second.tintColor = .red
            second.backgroundColor = .red
        }
        else{
            second.tintColor = .black
            second.backgroundColor = .black
        }
    }

    func separateByTime(begin: Int, end: Int){
        for index in begin...end{
            let time = view.viewWithTag(index) as? UIImageView
            time?.tintColor = .red
            time?.backgroundColor = .red
        }
    }
    func blackDraw(begin: Int, end: Int){
        if begin > end{
            for index in end - 3...end{
                let time = view.viewWithTag(index) as? UIImageView
                time?.tintColor = .red
                time?.backgroundColor = .red
            }
            return
        }
        for index in begin...end{
            let time = view.viewWithTag(index) as? UIImageView
            time?.tintColor = .black
            time?.backgroundColor = .black
        }
    }
}

