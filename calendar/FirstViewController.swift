//
//  FirstViewController.swift
//  calendar
//
//  Created by Nurkhan Tashimov on 05.10.2023.
//
protocol FirstViewControllerDelegate: ViewController {
    func sendData(name: String, date:UIDatePicker)
}
import UIKit
import Foundation
class FirstViewController: UIViewController {
    var date = UIDatePicker()
    weak var delegate: FirstViewControllerDelegate?
    static var dateComponents : [DateComponents] = []
    @IBOutlet weak var name: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "New Event"
        let addButton = UIBarButtonItem(title: "add", style: .plain, target: self, action: #selector(addEvent))
        self.navigationItem.rightBarButtonItem = addButton
        date.datePickerMode = .dateAndTime
        date.minimumDate = Date()
        
        date.locale = Locale.current
    }
    @IBAction func getName(_ sender: UITextField){
        name = sender
    }
    @IBAction func valueChanged(_ sender: UIDatePicker) {
        date = sender
    }
    @objc func addEvent(_ sender: Any) {
        if self.name.text != "" && self.date.date > Date() {
            let mycalendar = Calendar.current
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyyMMdd"
            let stringDate = dateFormatter.string(from: self.date.date)
            let dateFormatterForTime = DateFormatter()
            dateFormatterForTime.dateFormat = "HH:mm"
            _ = [(self.name.text!, dateFormatterForTime.string(from: self.date.date))]
            if var existingArray = UserDefaults.standard.array(forKey: stringDate) as? [[String: String]] {
                // Если массив уже существует в UserDefaults, добавьте новый элемент
                existingArray.append(["name": self.name.text!, "time": dateFormatterForTime.string(from: self.date.date)])
                UserDefaults.standard.set(existingArray, forKey: stringDate)
            } else {
                // Если массив не существует, создайте новый
                UserDefaults.standard.set([["name": self.name.text!, "time": dateFormatterForTime.string(from: self.date.date)]], forKey: stringDate)
            }
            self.navigationController?.popViewController(animated: true)
            FirstViewController.dateComponents.append(mycalendar.dateComponents([.year, .month, .day], from: self.date.date))
            print(FirstViewController.dateComponents)
            ViewController.calendar.reloadDecorations(forDateComponents: FirstViewController.dateComponents, animated: true)
//            ViewController.calendar.reloadDecorations(forDateComponents: FirstViewController.dateComponents, animated: true)
            
            
//            calendar.reloadDecorations(forDateComponents: DateComponents(from: [dateComponents] as! Decoder), animated: true)
        }
        if self.name.text == ""{
            let alertController = UIAlertController(title: "Error", message: "Empty event", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
        else if self.date.date < Date(){
            let alertController = UIAlertController(title: "Error", message: "You can't add event on past date", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
    }
}
